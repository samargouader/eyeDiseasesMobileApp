import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  late Interpreter _interpreter;
  bool _isLoading = false;
  File? _image;
  List<String> _labels = [];
  String _prediction = '';
  double _confidence = 0.0;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final modelPath = '${appDir.path}/model.tflite';
      final labelPath = '${appDir.path}/labels.txt';

      // Copier depuis les assets si nécessaire
      await _copyAsset('assets/model.tflite', modelPath);
      await _copyAsset('assets/labels.txt', labelPath);

      _interpreter = await Interpreter.fromAsset('assets/model.tflite');

      final labelFile = File(labelPath);
      _labels = await labelFile.readAsLines();

      debugPrint('Modèle et labels chargés avec succès');
    } catch (e) {
      debugPrint('Erreur de chargement: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de chargement du modèle')),
      );
    }
  }

  Future<void> _copyAsset(String asset, String path) async {
    final data = await rootBundle.load(asset);
    final bytes = data.buffer.asUint8List();
    await File(path).writeAsBytes(bytes);
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      setState(() {
        _isLoading = true;
        _image = File(pickedFile.path);
        _prediction = '';
      });

      await _predictImage(_image!);
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${e.toString()}')),
      );
    }
  }

  Future<void> _predictImage(File image) async {
    try {
      // Préparation de l'image (à adapter selon votre modèle)
      final imageBytes = await image.readAsBytes();
      // ... (ajoutez ici votre logique de prétraitement)

      // Exécution du modèle
      final output = List.filled(1, List.filled(_labels.length, 0)).reshape([1, _labels.length]);
      _interpreter.run(imageBytes, output);

      // Interprétation des résultats
      final index = output[0].indexOf(output[0].reduce(max));
      setState(() {
        _prediction = _labels[index];
        _confidence = output[0][index] * 100;
        _isLoading = false;
      });

    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de prédiction: $e')),
      );
    }
  }

  @override
  void dispose() {
    _interpreter.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analyse oculaire')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_image != null)
              Expanded(
                child: Image.file(_image!, fit: BoxFit.contain),
              ),
            if (_isLoading) ...[
              SizedBox(height: 20),
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text('Analyse en cours...'),
            ],
            if (_prediction.isNotEmpty) ...[
              SizedBox(height: 20),
              Text(
                'Résultat: $_prediction',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Confiance: ${_confidence.toStringAsFixed(1)}%',
                style: TextStyle(fontSize: 16),
              ),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _pickImage,
              child: Text('Sélectionner une image'),
            ),
          ],
        ),
      ),
    );
  }
}