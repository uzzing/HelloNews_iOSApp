//
//  VocaListView.swift
//  IOS_News
//
//  Created by uzzing on 2021/05/23.
//

import SwiftUI

// ItemListView - View
struct ItemListView: View {
    @EnvironmentObject var store: ItemStore
    @State var title = ""
    @State var mean = ""
    var items: [Item]
    
    // <-- for literative learning -->
    @State var tag: Int? = nil
    
    // <-- for bookmark -->
    @State var showFavoritesOnly : Bool = false
    
    // <-- for add the new -->
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(items) { item in
                            if !self.store.showFavoritesOnly || item.favorites {
                                ItemRow(item: item)
                            }
                        }
                        .onDelete(perform: self.delete)
                    }
                    .navigationBarTitle(Text(verbatim: "Voca"))
                    .toolbar {
                        ToolbarItemGroup(placement:.navigationBarTrailing) {
                            HStack (spacing: 15) {
                                
                                // <-- literative learning -->
                                Button {
                                    self.tag = 1
                                } label: {
                                    Image(systemName: "arrow.triangle.2.circlepath.doc.on.clipboard")
                                        .font(.system(size: 23))
                                        
                                }
                                .foregroundColor(Color("Color7"))
                                
                                // <-- show only bookmark -->
                                Button {
                                    store.showFavoritesOnly.toggle()
                                } label: {
                                    Image(systemName: "star")
                                        .font(.system(size: 23))
                                }
                                .foregroundColor(Color("Color7"))
                                
                                // <-- add voca -->
                                Button(action: {
                                    self.isPresented.toggle()
                                }, label: {
                                    Image(systemName: "plus.app")
                                        .font(.system(size: 23))
                                })
                                .foregroundColor(Color("Color7"))
                                
                            }.frame(width: 110, height: 70)
                        }
                    }
                }
                
                // <-- add voca -->
                AZAlert(message: "Add Voca", isShown: $isPresented, title: $title, mean: $mean, onDone: { _,_  in store.create(id: items.count, title: title, mean: mean, order: items.count) })
                
                NavigationLink(destination: Learning(items: store.items), tag: 1, selection: self.$tag) {}
            }
        }.navigationBarHidden(true)
    }
}
// ItemListView - Function
extension ItemListView {
    
    // <-- create voca -->
    private func create() {
        store.create(id: items.count, title: self.title, mean: self.mean, order: items.count)
        self.title = ""
        self.mean = ""
    }
    
    // <-- delete voca -->
    private func delete(offsets : IndexSet) {
        guard let index = offsets.first else {
            return
        }
        let deleteId = items[index].id
        let deleteOrder = items[index].order
        for i in (deleteOrder + 1)..<items.count {
            store.update(id: items[i].id, order: items[i].order - 1)
        }
        store.delete(id: deleteId)
    }
}
