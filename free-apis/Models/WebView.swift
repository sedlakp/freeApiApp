//
//  WebView.swift
//  free-apis
//
//  Created by Petr Sedlák on 17.05.2022.
//

import SwiftUI
import WebKit
import SafariServices
 
struct WebView: UIViewRepresentable {
 // using this leaves a navigation bar height of a blank space at the top of the view
    //needs more work
    var url: URL
 
    func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        return webview
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}


struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        let sc = SFSafariViewController(url: url)
        sc.preferredControlTintColor = .label
        return sc
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController,
                                context: UIViewControllerRepresentableContext<SafariView>) {

    }

}
