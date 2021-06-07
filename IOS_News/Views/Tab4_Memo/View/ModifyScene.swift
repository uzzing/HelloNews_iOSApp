//
//  ModifyScene.swift
//  IOS_News
//
//  Created by uzzing on 2021/06/02.
//

import SwiftUI

struct ModifyScene: View {
    @EnvironmentObject var keyboard: KeyboardObserver
    @EnvironmentObject var formatter: DateFormatter
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var stores: MemoStore
    @State private var content : String = "" //입력한 텍스트를 바인딩할때 사용하는 속성 선언, 이런 속성들은 @State 속성을 이용함s
    @Binding var showComposer: Bool
    
    
    var memo: Memo
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(memo.insertDate, formatter: self.formatter)")
                    .font(.caption)
                    .foregroundColor(Color(UIColor
                                            .secondaryLabel))
                    .padding(10)
                
                TextView(text: $content)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.bottom, keyboard.context.height)
                    .animation(.easeInOut(duration: keyboard.context.animationDuration))
                    .background(Color.gray)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // infinity를 전달하면 사용가능한 최대크기로 설정됨
            .navigationBarTitle("Memo", displayMode: .inline) //large타이틀 모드를 비활성화(inline)
            .navigationBarItems(leading: DismissButton(show: $showComposer), trailing: SaveButton(show: $showComposer, content: $content, memo: memo))
        }
        .onAppear {
            self.content = self.memo.content
        }
    }
}


fileprivate struct DismissButton: View {
    @Binding var show: Bool
    
    var body: some View {
        Button(action: {
            self.show = false
        }, label: {
            Text("취소")
        })
    }
}


fileprivate struct SaveButton: View {
    @Binding var show: Bool
    
    @EnvironmentObject var store: MemoStore
    @Binding var content: String
    
    var memo: Memo? = nil
    
    var body: some View {
        Button(action: {
            if let memo = self.memo {
                self.store.update(memo: memo, content: self.content)
            } else {
                self.store.insert(memo: self.content)
            }
            
            self.show = false
        }, label: {
            Text("저장")
        })
    }
}



