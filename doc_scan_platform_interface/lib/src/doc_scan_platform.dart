import 'package:doc_scan_platform_interface/src/doc_scan_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// The interface that defines the contract for document scanning.
abstract class DocScanPlatform extends PlatformInterface {
  /// Constructs a DocScanPlatform.
  DocScanPlatform() : super(token: _token);

  static final Object _token = Object();

  static DocScanPlatform _instance = DocScanMethodChannel();

  /// The default instance of [DocScanPlatform] to use.
  ///
  /// Defaults to [DocScanMethodChannel].
  static DocScanPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DocScanPlatform] when
  /// they register themselves.
  static set instance(DocScanPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Runs a flow to scan documents.
  ///
  /// Returns list of scanned images.
  Future<List<String>?> scanDocumentImages() {
    throw UnimplementedError('scan() has not been implemented.');
  }

  /// Runs a flow to scan documents.
  /// Combines images into single PDF file.
  ///
  /// Returns generated PDF file path.
  Future<String?> scanDocumentPdf() {
    throw UnimplementedError('scan() has not been implemented.');
  }
}
