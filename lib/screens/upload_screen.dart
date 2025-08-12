import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import '../models/test.dart';
import '../services/database_service.dart';

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
  final DatabaseService _databaseService = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadModelAndLabels();
    _databaseService.initializeDatabase();
  }

  Future<void> _loadModelAndLabels() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/my_model.tflite');
      
      final labelsData = await DefaultAssetBundle.of(context).loadString('assets/labels.txt');
      setState(() {
        _labels = labelsData.split('\n').where((e) => e.isNotEmpty).toList();
      });
      
      print('Model and labels loaded successfully');
    } catch (e) {
      print('Error loading model: $e');
      
      String errorMessage = 'Erreur de chargement du modèle IA';
      if (e.toString().contains('FULLY_CONNECTED')) {
        errorMessage = 'Version du modèle incompatible. Veuillez mettre à jour l\'application.';
      } else if (e.toString().contains('FileSystemException')) {
        errorMessage = 'Fichier modèle manquant. Veuillez réinstaller l\'application.';
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Theme.of(context).colorScheme.error,
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Réessayer',
            textColor: Colors.white,
            onPressed: () => _loadModelAndLabels(),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _interpreter?.close();
    _nameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
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
      }
    } finally {
      setState(() { _pickerActive = false; });
    }
  }

  Future<void> _predict(File imageFile) async {
    setState(() => _loading = true);
    try {
      if (_interpreter == null) {
        throw Exception('Modèle IA non chargé. Veuillez redémarrer l\'application.');
      }
      
      final bytes = await imageFile.readAsBytes();
      final img.Image? oriImage = img.decodeImage(bytes);
      if (oriImage == null) throw Exception('Image non valide');
      
      final img.Image resized = img.copyResize(oriImage, width: 224, height: 224);
      
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
      
      var output = List.filled(4, 0.0).reshape([1, 4]);
      _interpreter!.run(input.reshape([1, 224, 224, 3]), output);
      
      final scores = output[0] as List<double>;
      final maxScore = scores.reduce((a, b) => a > b ? a : b);
      final maxIdx = scores.indexOf(maxScore);
      
      if (maxIdx < 0 || maxIdx >= _labels.length) {
        throw Exception('Index de résultat invalide: $maxIdx');
      }
      _result = _labels[maxIdx];
      _confidence = maxScore * 100;
      
    } catch (e) {
      print('Prediction error: $e');
      
      String errorMessage = 'Erreur lors de l\'analyse de l\'image';
      if (e.toString().contains('FULLY_CONNECTED')) {
        errorMessage = 'Version du modèle incompatible. Veuillez mettre à jour l\'application.';
      } else if (e.toString().contains('Modèle IA non chargé')) {
        errorMessage = 'Modèle IA non disponible. Veuillez redémarrer l\'application.';
      } else if (e.toString().contains('Image non valide')) {
        errorMessage = 'Format d\'image non supporté. Veuillez choisir une autre image.';
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Theme.of(context).colorScheme.error,
          duration: const Duration(seconds: 4),
        ),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _saveTestResult() async {
    if (_result == null || _confidence == null || _image == null) return;
    try {
      final test = Test(
        imagePath: _image!.path,
        result: _result!,
        confidence: _confidence!,
        name: _nameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        age: int.parse(_ageController.text.trim()),
        createdAt: DateTime.now(),
      );
      await _databaseService.insertTest(test);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Résultat sauvegardé avec succès'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la sauvegarde: $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analyse d\'Image'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF8FAFC),
              Color(0xFFF1F5F9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),

                  Card(
                    elevation: 4,
                    shadowColor: theme.colorScheme.primary.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 48,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Analyse d\'Image Oculaire',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Sélectionnez une photo claire de votre œil pour obtenir un diagnostic préliminaire.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Container(
                    height: 280,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: theme.colorScheme.outline,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.shadow,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.file(
                              _image!,
                              width: double.infinity,
                              height: 280,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 64,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Aucune image sélectionnée',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Appuyez sur le bouton ci-dessous',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                  ),

                  const SizedBox(height: 32),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Prénom'),
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Obligatoire' : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(labelText: 'Nom'),
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Obligatoire' : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _ageController,
                          decoration: const InputDecoration(labelText: 'Âge'),
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Obligatoire';
                            final n = int.tryParse(v);
                            if (n == null || n <= 0 || n > 120) return 'Âge invalide';
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  ElevatedButton.icon(
                    icon: Icon(
                      _loading ? Icons.hourglass_empty : Icons.photo_library,
                      size: 24,
                    ),
                    label: Text(_loading ? 'Analyse en cours...' : 'Sélectionner une Image'),
                    onPressed: _loading || _pickerActive ? null : _pickImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      shadowColor: theme.colorScheme.primary.withOpacity(0.3),
                    ),
                  ),

                  const SizedBox(height: 32),

                  ElevatedButton.icon(
                    icon: const Icon(Icons.science, size: 24),
                    label: const Text('Tester'),
                    onPressed: _loading
                        ? null
                        : () async {
                            if (!(_formKey.currentState?.validate() ?? false)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Veuillez remplir le formulaire'),
                                  backgroundColor: Theme.of(context).colorScheme.error,
                                ),
                              );
                              return;
                            }
                            if (_image == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Veuillez sélectionner une image'),
                                  backgroundColor: Theme.of(context).colorScheme.error,
                                ),
                              );
                              return;
                            }
                            await _predict(_image!);
                            if (_result != null) {
                              await _saveTestResult();
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E5BBA),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  if (_loading)
                    Card(
                      elevation: 4,
                      shadowColor: theme.colorScheme.primary.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            CircularProgressIndicator(
                              color: theme.colorScheme.primary,
                              strokeWidth: 3,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Analyse en cours...',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Veuillez patienter pendant que notre IA analyse votre image',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),

                  if (_result != null && !_loading)
                    Card(
                      elevation: 4,
                      shadowColor: _getResultColor(_result!).withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _getResultColor(_result!).withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: _getResultColor(_result!).withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _getResultIcon(_result!),
                                  size: 48,
                                  color: _getResultColor(_result!),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                _getResultTitle(_result!),
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  color: _getResultColor(_result!),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _getResultDescription(_result!),
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF5E7),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFFF6AD55),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.medical_services,
                                      color: const Color(0xFFDD6B20),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Consultez un ophtalmologue pour un diagnostic complet',
                                        style: theme.textTheme.bodySmall?.copyWith(
                                          color: const Color(0xFFDD6B20),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getResultColor(String result) {
    switch (result.toLowerCase()) {
      case 'normal':
        return const Color(0xFF38A169);
      case 'diabetic retinopathy':
      case 'rétinopathie diabétique':
        return const Color(0xFFE53E3E);
      case 'glaucoma':
      case 'glaucome':
        return const Color(0xFF3182CE);
      case 'cataract':
      case 'cataracte':
        return const Color(0xFF805AD5);
      default:
        return const Color(0xFF2E5BBA);
    }
  }

  IconData _getResultIcon(String result) {
    switch (result.toLowerCase()) {
      case 'normal':
        return Icons.check_circle;
      case 'diabetic retinopathy':
      case 'rétinopathie diabétique':
        return Icons.warning;
      case 'glaucoma':
      case 'glaucome':
        return Icons.visibility_off;
      case 'cataract':
      case 'cataracte':
        return Icons.blur_on;
      default:
        return Icons.medical_services;
    }
  }

  String _getResultTitle(String result) {
    switch (result.toLowerCase()) {
      case 'normal':
        return 'Aucune Maladie Détectée';
      case 'diabetic retinopathy':
      case 'rétinopathie diabétique':
        return 'Rétinopathie Diabétique Détectée';
      case 'glaucoma':
      case 'glaucome':
        return 'Glaucome Détecté';
      case 'cataract':
      case 'cataracte':
        return 'Cataracte Détectée';
      default:
        return 'Résultat: $result';
    }
  }

  String _getResultDescription(String result) {
    switch (result.toLowerCase()) {
      case 'normal':
        return 'Votre œil semble en bonne santé. Continuez à maintenir une bonne hygiène oculaire.';
      case 'diabetic retinopathy':
      case 'rétinopathie diabétique':
        return 'Des signes de rétinopathie diabétique ont été détectés. Une consultation ophtalmologique urgente est recommandée.';
      case 'glaucoma':
      case 'glaucome':
        return 'Des signes de glaucome ont été détectés. Une évaluation ophtalmologique est nécessaire.';
      case 'cataract':
      case 'cataracte':
        return 'Des signes de cataracte ont été détectés. Consultez un ophtalmologue pour évaluation.';
      default:
        return 'Résultat d\'analyse: $result';
    }
  }
}
