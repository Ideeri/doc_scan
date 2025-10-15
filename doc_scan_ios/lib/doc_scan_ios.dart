import 'package:doc_scan_platform_interface/doc_scan_platform_interface.dart';
import 'package:flutter/services.dart';

class DocScanIOS extends DocScanPlatform {
  static void registerWith() => DocScanPlatform.instance = DocScanIOS();

  final _channel = MethodChannel('doc_scan');

  @override
  Future<List<String>> scanDocumentImages() async {
    try {
      final result = await _channel.invokeMethod<List>('scanDocument', {
        'format': DocScanFormat.jpeg.name,
      });

      return (result ?? []).cast<String>();
    } on PlatformException catch (e) {
      throw DocScanException(e.message ?? 'Unknown error');
    }
  }

  @override
  Future<String?> scanDocumentPdf() async {
    try {
      final result = await _channel.invokeMethod<List>('scanDocument', {
        'format': DocScanFormat.pdf.name,
      });

      final resultCast = (result ?? []).cast<String>();
      return resultCast.isNotEmpty ? resultCast.first : null;
    } on PlatformException catch (e) {
      throw DocScanException(e.message ?? 'Unknown error');
    }
  }
}
