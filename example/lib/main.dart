import 'package:doc_scan_flutter/doc_scan.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatefulWidget {
  const DemoApp({super.key});

  @override
  State<DemoApp> createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  DocScanFormat _format = .jpeg;
  List<String>? _scannedFiles;
  String? _errorMessage;

  Future<void> _scan() async {
    try {
      setState(() {
        _scannedFiles = null;
        _errorMessage = null;
      });

      final result = await DocumentScanner.scan(format: _format);
      setState(() => _scannedFiles = result);
    } on DocumentScannerException catch (e) {
      setState(() => _errorMessage = e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Doc Scan Flutter - Demo App')),
        body: Padding(
          padding: const .all(16.0),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Row(
                spacing: 24,
                children: [
                  Expanded(
                    child: DropdownButton<DocScanFormat>(
                      value: _format,
                      onChanged: (value) => setState(() => _format = value!),
                      items: const [
                        DropdownMenuItem(value: .jpeg, child: Text("JPEG")),
                        DropdownMenuItem(value: .pdf, child: Text("PDF")),
                      ],
                    ),
                  ),

                  ElevatedButton(onPressed: _scan, child: const Text("Scan")),
                ],
              ),

              const SizedBox(height: 20),

              if (_errorMessage != null)
                Text(
                  "Error: $_errorMessage",
                  style: const TextStyle(color: Colors.red),
                ),

              if (_scannedFiles != null) ...[
                Text("Scanned files:"),
                ..._scannedFiles!.map((path) => Text(path)),
              ],

              Spacer(),

              Center(
                child: Column(
                  children: [
                    Text(
                      'Demo application, and library made with ❤️ by Ideeri',
                    ),
                    Text(
                      'github.com/Ideeri/doc_scan',
                      style: TextStyle(fontFamily: 'monospace'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
