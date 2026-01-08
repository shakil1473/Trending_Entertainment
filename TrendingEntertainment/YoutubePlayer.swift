//
//  YoutubePlayer.swift
//  TrendingEntertainment
//
//  Created by Shakil Mahmud on 08.01.26.
//

import SwiftUI
import WebKit

struct YoutubePlayer: UIViewRepresentable {
    
    let webView = WKWebView()
    
    let videoId: String
    let youtubeBasedURL = ApiConfig.shared?.youtubeBaseURL
    
    func makeUIView(context: Context) -> some UIView {
        webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let baseURLString = youtubeBasedURL,
              let baseURL = URL(string: baseURLString) else {
            return
        }
        let fullURL = baseURL.appending(path: videoId)
        webView.load(URLRequest(url: fullURL))
    }
}
