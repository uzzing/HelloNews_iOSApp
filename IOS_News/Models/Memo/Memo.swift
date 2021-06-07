//
//  Memo.swift
//  SwiftUIMemo
//
//  Created by PCW on 2021/05/06.
//

import SwiftUI

class Memo: Identifiable, ObservableObject { //Ident 데이터 목록을 데이터뷰나 컬렉션뷰에 쉽게 바인딩 가능, Observ 반응형 ui를 구현하기 위해 필요
    let id:UUID //ident 프로토콜이 요구하는 속성이며, 메모를 유일하게 구분할때 사용
    @Published var content: String //새로운 값이 추가될때 마다 바인딩 되어 있는 ui가 자동적으로 업데이트 됨
    let insertDate: Date //메모를 작성한 날짜 저장
    
    init(id: UUID = UUID(), content: String, insertDate: Date = Date()) {
        self.id = id
        self.content = content
        self.insertDate = insertDate
    }
}

extension Memo: Equatable {
    static func == (lhs: Memo, rhs: Memo) -> Bool {
        return lhs.id == rhs.id
    }
}

