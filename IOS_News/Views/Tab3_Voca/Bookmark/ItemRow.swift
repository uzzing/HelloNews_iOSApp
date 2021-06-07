//
//  BookmarkRow.swift
//  IOS_News
//
//  Created by uzzing on 2021/05/27.
//

import SwiftUI

struct ItemRow: View {
    
    @EnvironmentObject var store: ItemStore
    var item: Item
    @State var boolValue: Bool = false
    @State var showWeb: Bool = false
    @State var tag: Int? = nil
    
    var favIndex: Int {
        store.items.firstIndex(where: { $0.id == item.id }) ?? 0
    }
    
    var body: some View {
        VStack {
            HStack {
                
                Text(item.title)
                    .fontWeight(.bold)
                    .font(.system(size: 23))
                    .padding(5)
                
                Text(item.mean)
                    .font(.system(size: 23))
                    .padding(5)
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20))
                }.onTapGesture {
                    self.tag = 1
                    self.showWeb.toggle()
                }
                .padding(.trailing, 10)
                
                Button(action: {}) {
                    if self.store.items[self.favIndex].favorites {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color.yellow)
                            .font(.system(size: 20))
                    } else {
                        Image(systemName: "star")
                            .font(.system(size: 20))
                        
                    }
                }.onTapGesture {
                    self.boolValue.toggle()
                    if boolValue { // true
                        store.updateFav(id: item.id, favorites: true)
                    } else { // false
                        store.updateFav(id: item.id, favorites: false)
                    }
                }
                .padding(.trailing, 10)
                
            }
            
            if showWeb {
                let space = item.title.filter {!$0.isWhitespace}
                
                NavigationLink(destination: DicWebView(urlToLoad: "https://en.dict.naver.com/#/search?range=example&shouldSearchVlive=false&query=\(space)"), tag: 1, selection: self.$tag) {}
            }
        }
    }
}

