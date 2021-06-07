//
//  BottomCardView.swift
//  IOS_News
//
//  Created by uzzing on 2021/06/05.
//

import SwiftUI
import WebKit
import AVFoundation

struct BottomCard<Content: View>: View{
    
    let content: Content
    @Binding var cardShown: Bool
    @Binding var cardDismissal: Bool
    let height: CGFloat
    
    init(cardShown: Binding<Bool>,
         cardDismissal: Binding<Bool>,
         height: CGFloat,
         @ViewBuilder content: () -> Content
    ){
        self.height = height
        _cardShown = cardShown
        _cardDismissal = cardDismissal
        self.content = content()
    }
    
    var body: some View{
        ZStack{
            //Dimmed
            GeometryReader{ _ in
                EmptyView()
            }
            .background(Color.white.opacity(0.5))
            .opacity(cardShown ? 1 : 0)
            .animation(Animation.easeIn)
            .onTapGesture {
                // Dismiss
                self.dismiss()
            }
            
            // Card
            VStack{
                Spacer()
                
                VStack{
                    content
                    
                    Button(action: {
                        self.dismiss()
                        
                    }, label: {
                        Text("Dismiss")
                            .foregroundColor(Color.white)
                            .frame(width: UIScreen.main.bounds.width/1.3,
                                   height: 50)
                            .background(Color.pink)
                            .cornerRadius(8)
                    })
                    .padding()
                }
                .background(Color(UIColor.secondarySystemBackground))
                .frame(height: height)
                .offset(y: cardDismissal && cardShown ? 0 : 300)
                .animation(Animation.default.delay(0.2))
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func dismiss() {
        cardDismissal.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.25) {
            cardShown.toggle()
        }
    }
}


// bottom card webview
struct DicWebView : UIViewRepresentable {

    var urlToLoad: String

    func makeUIView(context: Context) -> WKWebView {

        // unwrapping
        guard let url = URL(string: self.urlToLoad) else {
            return WKWebView()
        }

        // webview instance create
        let webview = WKWebView()
        webview.load(URLRequest(url: url))
        return webview
    }
    //update
    func updateUIView(_ uiView: WKWebView, context:
                        UIViewRepresentableContext<DicWebView>) {}
}
