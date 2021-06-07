//
//  MemoStore.swift
//  SwiftUIMemo
//
//  Created by PCW on 2021/05/06.
//
//메모 목록을 저장하는 클래스 구현
import Foundation

class MemoStore: ObservableObject {
    @Published var list: [Memo] //배열을 published 특성으로 선언하면 배열을 업데이트 할때마다 binding되어 있는 뷰도 함께 업데이트 됨
    
    init() {
        list = [
            Memo(content: "Lorem Ipsum 1"),
            Memo(content: "Lorem Ipsum 2"),
            Memo(content: "Lorem Ipsum 3")
        ]
    }
    //기본적인 CRUD Code
    //입력한 메모를 parameter로 받은다음 list array에 저장
    func insert(memo: String) {
        list.insert(Memo(content: memo), at: 0) //새로운 메모는 0번째 인덱스에 추가, 가장 위에 표시됨
    }
    
    func update(memo: Memo?, content: String) {
        guard let memo = memo else { return }
        memo.content = content
    }
    
    //memo instance를 받는 버전, index set을 받는 버전
    func delete(memo: Memo) {
        DispatchQueue.main.async {
            self.list.removeAll{ $0 == memo }
        }
    }
    
    func delete(set: IndexSet) {
        for index in set {
            self.list.remove(at: index)
        }
    }
    
}

