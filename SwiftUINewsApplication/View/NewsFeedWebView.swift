//
//  NewsFeedWebView.swift
//  SwiftUINewsApplication
//
//  Created by Pradeep's Macbook on 15/11/21.
//

import SwiftUI
import UIKit
import WebKit

struct NewsFeedWebView: UIViewRepresentable {
    
    typealias UIViewType = WKWebView
    
    var urlToDispaly: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest.init(url: urlToDispaly))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        //TODO: Need to implement the logic
    }
}
