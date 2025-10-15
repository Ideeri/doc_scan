import 'package:doc_scan_flutter/doc_scan_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// An implementation of [DocScanPlatformInterface] that uses method channels.
class DocScanMethodChannel extends DocScanPlatformInterface {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('doc_scan');
}
