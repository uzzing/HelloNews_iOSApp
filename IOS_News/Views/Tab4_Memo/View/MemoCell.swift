//
//  MemoCell.swift
//  SwiftUIMemo
//
//  Created by PCW on 2021/05/06.
//

import SwiftUI

struct MemoCell: View { //extract serveview를 하면 이렇게 별도의 구조체로 구성되어짐
    @ObservedObject var memo: Memo // 생성자로 전달받은 메모를 저장, @observe.. - 메모객체가 업데이트되는 시점마다 뷰가 새롭게 그려짐, 그래서 항상 최신데이터를 표시함
    @EnvironmentObject var formatter: DateFormatter
    
    var body: some View {
        VStack(alignment: .leading) { //vertical, 안에 있는 코드를 수직으로 나란히 배치함, leading으로 설정하면 Vstack에 포함된 모든 뷰가 왼쪽에 정렬됨
            Text(memo.content) //텍스트로 메모 내용 출력
                .font(.body)
                .lineLimit(1) //메모 내용을 한줄로만 표시하고 내용이 길다면 뒷부분을 생략해줌
            
            Text("\(memo.insertDate, formatter: self.formatter)") //날짜 데이터 출력
                .font(.caption)
                .foregroundColor(Color(UIColor
                                        .secondaryLabel))
            
        }
    }
}
