//
//  WebView.swift
//  Upkeep
//
//  Created by Mustafa on 4/28/24.
//

import Foundation
import SwiftData
import SwiftUI
import UIKit
import WebKit

@available(iOS 14.5, *)
struct WebView: UIViewRepresentable {
//    lazy var logger = Logger()
    @State var editorDownloadUrl: URL?
    var downloadUrl: URL?
    let modelContext: ModelContext
    let webView = WKWebView()
    @Binding var modelWasAdded: Bool
    var closeFunction: () -> Void
    @Binding var newManual: Manual?

    func makeCoordinator() -> WebViewCoordinator {
        return WebViewCoordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        return webView
    }

    func reload() {
        webView.reload()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.navigationDelegate = context.coordinator // very important to add this line.

        guard let url = downloadUrl else {
            return
        }

        let request = URLRequest(url: url)
        webView.load(request)
    }
}

// MARK: - WKNavigationDelegate

@available(iOS 14.5, *)
class WebViewCoordinator: NSObject, WKNavigationDelegate {
    var parent: WebView

    init(_ parent: WebView) {
        self.parent = parent
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        parent.reload()
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
        if let bool = navigationAction.request.url?.absoluteString.contains(".pdf"), bool {
            decisionHandler(.download, preferences)
        } else {
            decisionHandler(.allow, preferences)
        }
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let mime = navigationResponse.response.mimeType {
            if mime == "application/pdf" {
                decisionHandler(.download)
            } else {
                decisionHandler(.allow)
            }
        }
    }
}

// MARK: - WKDownloadDelegate

@available(iOS 14.5, *)
extension WebViewCoordinator: WKDownloadDelegate {
    func webView(_ webView: WKWebView, navigationAction: WKNavigationAction, didBecome download: WKDownload) {
        download.delegate = self
    }

    func download(_ download: WKDownload, decideDestinationUsing response: URLResponse, suggestedFilename: String, completionHandler: @escaping (URL?) -> Void) {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = documentDirectory.appendingPathComponent("\(suggestedFilename)", isDirectory: false)

        parent.downloadUrl = fileUrl

        if !parent.modelWasAdded, let data = try? Data(contentsOf: fileUrl) {
            let manual = Manual(name: "Test Manual", type: "Manual", file: data)
            parent.modelContext.insert(manual)
            parent.modelWasAdded = true
//            print("Manual created")
            parent.closeFunction()
        }

        completionHandler(fileUrl)
    }

    // MARK: - Optional

    func downloadDidFinish(_ download: WKDownload) {
        parent.editorDownloadUrl = parent.downloadUrl
    }

    func download(_ download: WKDownload, didFailWithError error: Error, resumeData: Data?) {
        print("\(error.localizedDescription)")
        // you can add code here to continue the download in case there was a failure.
    }
}

// struct WebView: UIViewRepresentable {
//    typealias UIViewType = WKWebView
//    var url: URL
//    var webView: WKWebView
//    let modelContext: ModelContext
//
//    init(url: URL, webView: WKWebView = WKWebView(), modelContext: ModelContext) {
//        self.url = url
//        self.webView = webView
//        self.modelContext = modelContext
//    }
//
//    /// To let SwiftUI instantiate your views
//    func makeUIView(context: Context) -> WKWebView {
//        webView.uiDelegate = context.coordinator
//        webView.navigationDelegate = context.coordinator
//
//        return webView
//    }
//
//    /// What to do on redraw
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//        let request = URLRequest(url: url)
//        uiView.load(request)
//    }
//
//    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
//        if navigationAction.targetFrame == nil {
//            webView.load(navigationAction.request)
//        }
//
//        return nil
//    }
// }
//
// extension WebView {
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    final class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
//        var parent: WebView
//        private var webViews: [WKWebView]
//
//        init(_ parent: WebView) {
//            self.parent = parent
//            self.webViews = []
//        }
//
//        func dismissAllPopupWebViews() {
//            webViews.forEach { $0.removeFromSuperview() }
//            webViews.removeAll()
//        }
//
//        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
//            if navigationAction.targetFrame == nil {
//                let popupWebView = WKWebView(frame: .zero, configuration: configuration)
//                popupWebView.navigationDelegate = self
//                popupWebView.uiDelegate = self
//
//                parent.webView.addSubview(popupWebView)
//                popupWebView.translatesAutoresizingMaskIntoConstraints = false
//                NSLayoutConstraint.activate([
//                    popupWebView.topAnchor.constraint(equalTo: parent.webView.topAnchor),
//                    popupWebView.bottomAnchor.constraint(equalTo: parent.webView.bottomAnchor),
//                    popupWebView.leadingAnchor.constraint(equalTo: parent.webView.leadingAnchor),
//                    popupWebView.trailingAnchor.constraint(equalTo: parent.webView.trailingAnchor)
//                ])
//
//                webViews.append(popupWebView)
//                return popupWebView
//            }
//
//            return nil
//        }
//    }
// }
