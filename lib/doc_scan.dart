import 'dart:async';

import 'package:doc_scan_flutter/doc_scan_exception.dart';
import 'package:doc_scan_flutter/doc_scan_format.dart';
import 'package:doc_scan_flutter/doc_scan_platform_interface.dart';

/// The main class for scanning documents.
class DocScan {
  const DocScan._();

  static final _platform = DocScanPlatformInterface.instance;

  /// Scans a document and returns the file path(s) of the scanned document(s).
  ///
  /// Throws a [DocScanException] if the scan fails.
  static Future<List<String>?> scan({
    DocScanFormat format = DocScanFormat.jpeg,
  }) => _platform.scan(format: format);
}
