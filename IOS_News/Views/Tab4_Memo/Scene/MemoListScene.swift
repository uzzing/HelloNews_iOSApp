//
//  ContentView.swift
//  SwiftUIMemo
//
//  Created by PCW on 2021/05/06.
//

import SwiftUI


struct MemoListScene: View {
    @EnvironmentObject var stores: MemoStore //scenedelegate에서 memostore 인스턴스를 커스텀 공유데이터로 등록했음, 뷰가 생성되는 시점에 공유데이터 목록을 확인하고 store속성과 동일한 형식을 가진 객체가 등록되어 있다면 여기에 자동으로 저장해줌, 스유에서는 이런방식으로 하나의 데이터를 여러뷰에서 공유함
    
    
    @EnvironmentObject var formatter: DateFormatter //formatter속성 추가, 위의 store과 마찬가지로 뷰가 생성되는 시점에 자동으로 초기화됨
    
    
    
    @State var showComposer: Bool = false //composescene을 제어할때 사용됨 //+버튼을 누르면 showcomposer가 true로 바뀌고 sheet연산자는 바인딩되어있는 속성에 true가 저장되면 content의 클로져를 실행하고 return된 화면을 modal형식으로 표시한다.

    
    var body: some View {
        //list 추가 //memostore에 저장되어 있는 배열을 전달
        NavigationView { // 다음화면으로 전환해줄 navigation view //화면 상단에 빈 navigationbar가 출력됨
            List {
                ForEach(stores.list) { memo in // closure 추가 //배열에 저장되어 있는 메모가 memo(parameter)로 전달됨
//                    NavigationLink(destination: ModifyScene(showComposer: self.$showComposer, memo: memo),
//                        label: {
                    MemoCell(memo: memo)
                        .onTapGesture {
                            self.showComposer.toggle()
                        }
                        .sheet(isPresented: $showComposer, content: {
                            ModifyScene(showComposer: self.$showComposer, memo: memo)
                                .environmentObject(self.stores)
                                .environmentObject(KeyboardObserver())
                        })
                            //extract serveview로 인해 구조체와 호출하는 코드로 바뀌어짐
                        //})
                }
                .onDelete(perform: stores.delete)
            }
            .navigationBarTitle("내 메모") //modifier, modifier라고 불리는 특별한 메소드를 이용해 필요한 속성을 바꾸거나 뷰를 조작함, title이 추가됨
            .navigationBarItems(trailing: ModalButton(show: $showComposer)) //$를 붙이면 값이 아니라 바인딩이 전달됨, 여기서 전달한 속성은 밑의 show에 저장됨, 값이 아니라 바인딩이 저장됨, view외부에 있는 속성을 바꾸고 싶다면 이렇게 바인딩 형태로 전달해야함, 파라미터로 전달할때는 $를 붙이고 아래의 전달받는 곳은 바인딩 특성으로 선언하는 패턴이다.
//            .sheet(isPresented: $showComposer, content: {
//                ComposeScene(showComposer: self.$showComposer, memo: memo)
//                    .environmentObject(self.stores)
//                    .environmentObject(KeyboardObserver())
//            })
        }
           
    }
}

fileprivate struct ModalButton: View {
    @Binding var show: Bool
    
    var body: some View {
        Button(action: {
            self.show = true //여기의 show속성을 바꾸면 위의 바인딩 되어있는 showcomposer속성을 바꾸게됨
        }, label: {
            Image(systemName: "plus")
        })
    }
}

