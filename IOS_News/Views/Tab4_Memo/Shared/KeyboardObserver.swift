//
//  KeyboardObserver.swift
//  SwiftUIMemo
//
//  Created by PCW on 2021/05/06.
//

import UIKit
import Combine

class KeyboardObserver: ObservableObject {
    
    struct Context {
        let animationDuration: TimeInterval //애니메이션 시간
        let height: CGFloat //키보드 높이
        
        static let hide = Self(animationDuration: 0.25, height: 0) //키보드가 숨겨진 상태의 기본값
    }
    
    @Published var context = Context.hide //값이 업데이트되면 연관되어 있는 뷰가 자동적으로 업데이트되게 함
    
    private var cancellables = Set<AnyCancellable>() //메모리 관리에 사용되는 속성
    
    init() {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
        
        willShow.merge(with: willHide)
            .compactMap(parse)
            .assign(to: \.context, on: self)
            .store(in: &cancellables)
    }
    
    func parse(notification: Notification) -> Context? {
        guard let userInfo = notification.userInfo else { return nil }
        
        let safeAreaInsets = UIApplication.shared.windows.first?.safeAreaInsets
        let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as?
                                    NSNumber)?.doubleValue ?? 0.25
        
        var height: CGFloat = 0
        
        if let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let frame = value.cgRectValue
            
            if frame.origin.y < UIScreen.main.bounds.height {
                height = frame.height - (safeAreaInsets?.bottom ?? 0)
            }
        }
        
        return Context(animationDuration: animationDuration, height: height)
    }
}

