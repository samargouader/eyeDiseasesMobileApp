import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? _image;
  String? _result;
  double? _confidence;
  bool _loading = false;
  bool _pickerActive = false;
  Interpreter? _interpreter;
  List<String> _labels = [];

  @override
  void initState() {
    super.initState();
    _loadModelAndLabels();
  }

  Future<void> _loadModelAndLabels() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/my_model.tflite');
      final labelsData = await DefaultAssetBundle.of(context).loadString('assets/labels.txt');
      setState(() {
        _labels = labelsData.split('\n').where((e) => e.isNotEmpty).toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de chargement du modèle: $e')),
      );
    }
  }

  Future<void> _pickImage() async {
    if (_loading || _pickerActive) return;
    setState(() { _pickerActive = true; });
    final picker = ImagePicker();
    try {
      final picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        setState(() {
          _image = File(picked.path);
          _result = null;
          _confidence = null;
        });
        await _predict(_image!);
      }
    } finally {
      setState(() { _pickerActive = false; });
    }
  }

  Future<void> _predict(File imageFile) async {
    setState(() => _loading = true);
    try {
      final bytes = await imageFile.readAsBytes();
      final img.Image? oriImage = img.decodeImage(bytes);
      if (oriImage == null) throw Exception('Image non valide');
      final img.Image resized = img.copyResize(oriImage, width: 224, height: 224);
      // Convert to Float32List and normalize
      final input = Float32List(1 * 224 * 224 * 3);
      int pixelIndex = 0;
      for (int y = 0; y < 224; y++) {
        for (int x = 0; x < 224; x++) {
          final pixel = resized.getPixel(x, y);
          input[pixelIndex++] = pixel.r / 255.0;
          input[pixelIndex++] = pixel.g / 255.0;
          input[pixelIndex++] = pixel.b / 255.0;
        }
      }
      var output = List.filled(_labels.length, 0.0).reshape([1, _labels.length]);
      _interpreter?.run(input.reshape([1, 224, 224, 3]), output);
      final scores = output[0];
      final maxScore = scores.reduce((a, b) => a > b ? a : b);
      final maxIdx = scores.indexOf(maxScore);
      setState(() {
        _result = _labels[maxIdx];
        _confidence = maxScore * 100;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la prédiction: $e')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analyse de l’Image'),
        centerTitle: true,
        backgroundColor: const Color(0xFF008080),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F7FA), Color(0xFFF1F8E9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                if (_image != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(_image!, height: 220, fit: BoxFit.cover),
                  )
                else
                  Container(
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text('Aucune image sélectionnée', style: TextStyle(color: Colors.black54)),
                    ),
                  ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Sélectionner une image'),
                  onPressed: _loading || _pickerActive ? null : _pickImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF008080),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),
                if (_loading)
                  const Center(child: CircularProgressIndicator(color: Color(0xFF008080))),
                if (_result != null && !_loading)
                  Card(
                    margin: const EdgeInsets.only(top: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            _result == 'Normal' ? 'Aucune maladie détectée' : 'Maladie détectée : $_result',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: _result == 'Normal' ? Colors.green : Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          if (_confidence != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Confiance : ${_confidence!.toStringAsFixed(1)}%',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
