import 'package:doc_scan_platform_interface/doc_scan_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

const _channel = MethodChannel('doc_scan');

/// An implementation of [DocScanPlatformInterface] that uses method channels.
class DocScanMethodChannel extends DocScanPlatform {
  /// The MethodChannel that is being used by this implementation of the plugin.
  @visibleForTesting
  MethodChannel get channel => _channel;

  @override
  Future<List<String>> scanDocumentImages() async {
    final result = await _channel.invokeMethod<List<String>>('scanDocument', {
      'format': DocScanFormat.jpeg.name,
    });
    return result ?? [];
  }

  @override
  Future<String?> scanDocumentPdf() async {
    final result = await _channel.invokeMethod<String?>('scanDocument', {
      'format': DocScanFormat.pdf.name,
    });

    return result;
  }
}
