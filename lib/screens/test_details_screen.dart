import 'dart:io';
import 'package:flutter/material.dart';
import '../services/database_service.dart';

class TestDetailsScreen extends StatefulWidget {
  final int testId;
  const TestDetailsScreen({super.key, required this.testId});

  @override
  State<TestDetailsScreen> createState() => _TestDetailsScreenState();
}

class _TestDetailsScreenState extends State<TestDetailsScreen> {
  final DatabaseService _databaseService = DatabaseService();
  Map<String, dynamic>? _test;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final t = await _databaseService.getTestById(widget.testId);
    setState(() {
      _test = t?.toMap();
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du Test'),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : (_test == null)
              ? Center(
                  child: Text(
                    'Test introuvable',
                    style: theme.textTheme.titleMedium,
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (_test!['imagePath'] != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(_test!['imagePath'] as String),
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(height: 16),
                      // Confidentialité: masquer nom et prénom
                      _buildRow('Patient', 'Anonyme'),
                      _buildRow('Âge', '${_test!['age']}'),
                      _buildRow('Résultat', _formatLabel('${_test!['result']}')),
                      if (_test!['createdAt'] != null)
                        _buildRow('Date', '${_test!['createdAt']}'),
                    ],
                  ),
                ),
    );
  }

  Widget _buildRow(String label, String value) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Text(
            value,
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

String _formatLabel(String raw) {
  final clean = raw.toString().replaceAll('_', ' ').trim();
  if (clean.isEmpty) return clean;
  return clean
      .split(RegExp(r'\s+'))
      .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}')
      .join(' ');
}


