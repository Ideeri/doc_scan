import 'package:doc_scan_flutter/doc_scan_format.dart';
import 'package:doc_scan_flutter/doc_scan_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// The interface that defines the contract for document scanning.
abstract class DocScanPlatformInterface extends PlatformInterface {
  /// Constructs a DocScanPlatform.
  DocScanPlatformInterface() : super(token: _token);

  static final Object _token = Object();

  static DocScanPlatformInterface _instance = DocScanMethodChannel();

  /// The default instance of [DocScanPlatformInterface] to use.
  ///
  /// Defaults to [DocScanMethodChannel].
  static DocScanPlatformInterface get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DocScanPlatformInterface] when
  /// they register themselves.
  static set instance(DocScanPlatformInterface instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Scans a document and returns the file path(s) of the scanned document(s).
  Future<List<String>?> scan({DocScanFormat format = DocScanFormat.jpeg}) {
    throw UnimplementedError('scan() has not been implemented on $runtimeType');
  }
}
