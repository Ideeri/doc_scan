import 'package:doc_scan_flutter/doc_scan.dart';
import 'package:doc_scan_flutter/doc_scan_format.dart';
import 'package:doc_scan_flutter/doc_scan_exception.dart';
import 'package:flutter/material.dart';

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
  DocScanFormat _format = DocScanFormat.jpeg;
  List<String>? _scannedFiles;
  String? _errorMessage;

  Future<void> _scanDocument() async {
    try {
      setState(() {
        _scannedFiles = null;
        _errorMessage = null;
      });

      final result = await DocScan.scan(format: _format);
      setState(() => _scannedFiles = result);
    } on DocScanException catch (e) {
      setState(() => _errorMessage = e.message);
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
            DropdownButton<DocScanFormat>(
              value: _format,
              onChanged: (value) => setState(() => _format = value!),
              items: const [
                DropdownMenuItem(
                  value: DocScanFormat.jpeg,
                  child: Text("JPEG"),
                ),
                DropdownMenuItem(value: DocScanFormat.pdf, child: Text("PDF")),
              ],
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
            if (_scannedFiles != null)
              ..._scannedFiles!.map((path) => Text(path)),
          ],
        ),
      ),
    );
  }
}
