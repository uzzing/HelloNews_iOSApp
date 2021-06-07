//
//  SecondNaviView.swift
//  IOS_News
//
//  Created by uzzing on 2021/06/05.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
import WebKit
import SlideOverCard
import AVFoundation
import Combine

struct SecondView : View {
    @State private var position = CardPosition.bottom
    @State private var background = BackgroundStyle.blur
    @EnvironmentObject var store: ItemStore
    
    @State var url: String
    
    var body: some View {
        
        ZStack {
            NewsWebView(url: url)
            
            SlideOverCard($position, backgroundStyle: $background) {
                VStack {
                    CardContent(items: store.items)
                        .padding()
                    Spacer()
                }
            }
        }
    }
}


struct NewsWebView : UIViewRepresentable { //swift에서 uiview를 추가해야할 경우 이 protocol을 활용, makeUIView, updateView를 무조건 구현해야함

    var url: String

    func makeUIView(context: UIViewRepresentableContext<NewsWebView>) -> WKWebView {
        let view = WKWebView()
        view.load(URLRequest(url: URL(string: url)!))
        return view
    }

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<NewsWebView>) {}
}
