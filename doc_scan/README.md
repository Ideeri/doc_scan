# doc_scan_flutter

[<img src="https://img.shields.io/pub/v/doc_scan_flutter">](https://pub.dev/packages/doc_scan_flutter)

doc_scan_flutter is a Flutter package that lets you scan documents as PDF or JPEG using native platform APIs. It automatically detects edges, crops, and enhances colors to give you a clean scan—just like a dedicated scanner app. Inspired by [flutter_doc_scanner](https://pub.dev/packages/flutter_doc_scanner), but with improved typing and compatibility

| what the user scans                                                                                         | the result you get                                                                                         |
|-------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------|
| ![](https://developers.google.com/static/ml-kit/images/vision/doc-scanner/example_wrinkle_angle_before.png) | ![](https://developers.google.com/static/ml-kit/images/vision/doc-scanner/example_wrinkle_angle_after.png) |

*Demo images courtesy of Google, [source](https://developers.google.com/ml-kit/vision/doc-scanner). You can expect the same results on iOS.*

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  doc_scan_flutter: ^1.0.5
```

Or, even better: 

```sh
flutter pub add doc_scan_flutter
```

Run:

```sh
flutter pub get
```

## Additional setup

### iOS

VisionKit is available for iOS 13 and up. To enforce this, edit your `Podfile` and add at the very top

```ruby
platform :ios, '13.0'
```

While you're in your `Podfile`, also add this at the bottom:

```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    # You should already have this
    flutter_additional_ios_build_settings(target)

    # add this
    target.build_configurations.each do |config|
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',
        'PERMISSION_CAMERA=1',
      ]
    end
  end
end
```

Finally, in order to request access to the camera, you need to inform the user on why you need this permission, otherwise your app will fail the App Store review. Edit `ios/Runner/Info.plist` and add:

```
<key>NSCameraUsageDescription</key>
<string>We need access to your camera to scan documents.</string>
```

### Android

ML Kit and the Google Play Services require a minimum SDK version of 21. Edit your `android/app/build.gradle`:

```
android {
    defaultConfig {
        minSdkVersion 21
    }
}
```

You should then run :

```sh
flutter clean
flutter pub get
```

To make sure everything is clean and up-to-date.

## Usage

```dart
import 'package:doc_scan_flutter/doc_scan.dart';

try {
    List<String>? result = await DocumentScanner.scan();

    // Scan in PDF
    List<String>? pdfResult = await DocumentScanner.scan(format: DocumentScannerFormat.pdf);


    if (result == null) {
        // the user cancelled
    }
} on DocumentScannerException {
    // Something went wrong, deal with it!
}
```

Once the scan is complete, you get a list of path to the scanned documents, which will be stored in the platform's temporary folder, which will be purged at some point, so if you need to persist the files locally, make sure to call `File('...').rename('...')`.

## License
This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.