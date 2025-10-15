import 'dart:async';

import 'package:doc_scan_platform_interface/doc_scan_platform_interface.dart';

export 'package:doc_scan_platform_interface/doc_scan_platform_interface.dart'
    show DocScanException;

/// The main class for scanning documents.
class DocScan {
  const DocScan._();

  static final _platform = DocScanPlatform.instance;

  /// Scans a document and returns the file path(s) of the scanned document(s).
  ///
  /// Throws a [DocScanException] if the scan fails.
  static Future<List<String>> scanDocumentImages() async =>
      await _platform.scanDocumentImages() ?? <String>[];

  /// Scans a document and returns the file path(s) of the scanned document(s).
  ///
  /// Throws a [DocScanException] if the scan fails.
  static Future<String?> scanDocumentPdf() async =>
      await _platform.scanDocumentPdf();
}
