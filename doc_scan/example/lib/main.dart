import 'package:doc_scan_flutter/doc_scan.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

/// The type of document to scan.
enum ScanType {
  /// Scans multiple images.
  images,

  /// Scans a single PDF document.
  pdf,
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DocScanPage(),
    );
  }
}

class DocScanPage extends StatefulWidget {
  const DocScanPage({super.key});

  @override
  State<DocScanPage> createState() => _DocScanPageState();
}

class _DocScanPageState extends State<DocScanPage> {
  final _scanTypeNotifier = ValueNotifier(ScanType.images);
  final _resultFilesNotifier = ValueNotifier(<String>[]);
  String? _errorMessage;

  Future<void> _scanDocument() async {
    try {
      _resultFilesNotifier.value = [];

      final result = await switch (_scanTypeNotifier.value) {
        ScanType.images => DocScan.scanDocumentImages(),
        ScanType.pdf => DocScan.scanDocumentPdf(),
      };

      if (result is String) {
        _resultFilesNotifier.value = [result];
      } else if (result is List<String>) {
        _resultFilesNotifier.value = result;
      }
    } on DocScanException catch (e) {
      if (!mounted) {
        debugPrint('DocScanException: ${e.message}');
        return;
      }

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text('Error'), content: Text(e.message));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doc Scan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Scan a document with custom options:"),
            const SizedBox(height: 20),

            // Format Selection
            ValueListenableBuilder(
              valueListenable: _scanTypeNotifier,
              builder: (context, value, child) {
                return DropdownButton<ScanType>(
                  value: value,
                  onChanged: (value) => _scanTypeNotifier.value = value!,
                  items: const [
                    DropdownMenuItem(
                      value: ScanType.images,
                      child: Text("IMAGES"),
                    ),
                    DropdownMenuItem(value: ScanType.pdf, child: Text("PDF")),
                  ],
                );
              },
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scanDocument,
              child: const Text("Scan Document"),
            ),
            const SizedBox(height: 20),

            if (_errorMessage != null)
              Text(
                "Error: $_errorMessage",
                style: const TextStyle(color: Colors.red),
              ),
            ValueListenableBuilder(
              valueListenable: _resultFilesNotifier,
              builder: (context, value, child) {
                if (value.isEmpty) {
                  return const SizedBox();
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final e in value)
                      ListTile(
                        title: Text(path.basename(e)),
                        subtitle: Text(e),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
