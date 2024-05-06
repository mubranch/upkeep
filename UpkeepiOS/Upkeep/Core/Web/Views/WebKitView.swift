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
struct WebKitView: UIViewRepresentable {
    @StateObject var viewModel: WebKitViewModel
    let webView = WKWebView()

    /// To let SwiftUI instantiate your views
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }

    /// Action on redraw
    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.navigationDelegate = context.coordinator
        let request = URLRequest(url: viewModel.activeUrl)
        webView.load(request)
    }

    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }

        return nil
    }

    func makeCoordinator() -> WebViewCoordinator {
        return WebViewCoordinator(self)
    }
}

@available(iOS 14.5, *)
class WebViewCoordinator: NSObject, WKNavigationDelegate {
    var parent: WebKitView

    init(_ parent: WebKitView) {
        self.parent = parent
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        // reloads the page if navigation fails
        parent.webView.reload()
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
        // navigates to a target url as long as it isn't a pdf file
        if let bool = navigationAction.request.url?.absoluteString.contains(".pdf"), bool {
            decisionHandler(.download, preferences)
        } else {
            decisionHandler(.allow, preferences)
        }
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        // pulls the mimetype from the navigation response
        if let mime = navigationResponse.response.mimeType {
            // if the mime type is application/pdf the pdf is downloaded and saved as a manual
            if mime == "application/pdf" {
                decisionHandler(.download)
            } else {
                decisionHandler(.allow)
            }
        }
    }
}

@available(iOS 14.5, *)
extension WebViewCoordinator: WKDownloadDelegate {
    func webView(_ webView: WKWebView, navigationAction: WKNavigationAction, didBecome download: WKDownload) {
        download.delegate = self
    }

    func download(_ download: WKDownload, decideDestinationUsing response: URLResponse, suggestedFilename: String, completionHandler: @escaping (URL?) -> Void) {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = documentDirectory.appendingPathComponent("\(suggestedFilename)", isDirectory: false)

        parent.viewModel.activeUrl = fileUrl

        // decode the pdf into a data object which can be stored in swiftdata
        if let data = try? Data(contentsOf: fileUrl) {
            let manual = Manual(name: String.none, urlString: fileUrl.absoluteString, file: data)
            // inserts the object in the parent modelcontext to initiate the editor view
            parent.viewModel.modelContext.insert(manual)
            // the newmanual binding triggers presentation of the manual editor sheet
            parent.viewModel.newManual = manual
        }

        completionHandler(fileUrl)
    }

    func downloadDidFinish(_ download: WKDownload) {
//        parent.editorDownloadUrl = parent.downloadUrl
    }

    func download(_ download: WKDownload, didFailWithError error: Error, resumeData: Data?) {
        print("\(error.localizedDescription)")
    }
}
