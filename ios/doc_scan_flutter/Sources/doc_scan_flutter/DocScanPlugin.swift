import Flutter
import UIKit
import VisionKit

public class DocScanPlugin: NSObject, FlutterPlugin, VNDocumentCameraViewControllerDelegate {
    private var result: FlutterResult?
    private var selectedFormat: String = "jpeg" // Default format

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "doc_scan", binaryMessenger: registrar.messenger())
        let instance = DocScanPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "scanDocument" {
            self.result = result
            let args = call.arguments as? [String: Any]
            self.selectedFormat = args?["format"] as? String ?? "jpeg"
            presentScanner()
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    private func presentScanner() {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
            result?(FlutterError(code: "NO_VIEW_CONTROLLER", message: "Cannot access root view controller", details: nil))
            return
        }

        let scannerVC = VNDocumentCameraViewController()
        scannerVC.delegate = self
        rootViewController.present(scannerVC, animated: true)
    }

    public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        var filePaths: [String] = []

        for i in 0..<scan.pageCount {
            let image = scan.imageOfPage(at: i)
            let filename = "\(UUID().uuidString).jpg"
            let path = NSTemporaryDirectory().appending(filename)

            if selectedFormat == "jpeg", let data = image.jpegData(compressionQuality: 0.8) {
                FileManager.default.createFile(atPath: path, contents: data, attributes: nil)
                filePaths.append(path)
            } else if selectedFormat == "pdf" {
                let pdfPath = saveImageAsPDF(image: image)
                filePaths.append(pdfPath)
            }
        }

        controller.dismiss(animated: true) {
            self.result?(filePaths)
        }
    }

    /// Helper function to save an image as PDF
    private func saveImageAsPDF(image: UIImage) -> String {
        let pdfPath = NSTemporaryDirectory().appending("\(UUID().uuidString).pdf")
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRect(origin: .zero, size: image.size), nil)
        UIGraphicsBeginPDFPage()
        let context = UIGraphicsGetCurrentContext()!
        image.draw(in: CGRect(origin: .zero, size: image.size))
        UIGraphicsEndPDFContext()
        pdfData.write(toFile: pdfPath, atomically: true)
        return pdfPath
    }

    public func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true) {
            self.result?(nil)
        }
    }

    public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        controller.dismiss(animated: true) {
            self.result?(FlutterError(code: "SCAN_ERROR", message: error.localizedDescription, details: nil))
        }
    }
}
