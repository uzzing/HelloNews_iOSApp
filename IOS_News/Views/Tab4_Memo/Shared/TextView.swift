//
//  TextView.swift
//  IOS_News
//
//  Created by uzzing on 2021/06/02.
//

import UIKit
import SwiftUI

struct TextView: UIViewRepresentable { //uikit이 제공하는 뷰를 사용하려면 이 프로토콜을 구현해야함
    @Binding var text: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let myTextView = UITextView()
        myTextView.delegate = context.coordinator
        myTextView.font = UIFont.init(name: "Apple SD Gothic Neo", size: 20)
        myTextView.isScrollEnabled = true
        
        return myTextView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    class Coordinator: NSObject, UITextViewDelegate{ //delegate클래스를 처리할 Coordinator 구현
        var parent: TextView
        
        init(_ uiTextView: TextView) {
            self.parent = uiTextView
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
    }
    
}
