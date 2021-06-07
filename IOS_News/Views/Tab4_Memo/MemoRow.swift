//
//  MemoRow.swift
//  IOS_News
//
//  Created by uzzing on 2021/06/02.
//

import SwiftUI

struct MemoRow: View {
    var memo: Memo
    
    @EnvironmentObject var formatter: DateFormatter

    var body: some View {
        VStack(alignment: .leading) {
            
            memo.contents.map(Text.init)
                .font(.system(size: 23, weight: .semibold))
                .padding(2)
                .lineLimit(1)
            
            memo.date.map { Text(self.formatter.string(from: $0))}
                .font(.system(size: 18))
                .foregroundColor(Color.black.opacity(0.6))
                .padding([.leading, .bottom], 2)
            
        }
        
    }
    
}
