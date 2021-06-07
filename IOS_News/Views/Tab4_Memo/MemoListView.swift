//
//  MemoListView.swift
//  IOS_News
//
//  Created by uzzing on 2021/06/02.
//

import SwiftUI

struct MemoList: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        
        entity: Memo.entity(),
        
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Memo.date
                             ,ascending: false)
        ]
        
    ) var memos: FetchedResults<Memo>
    
    @State var isPresented = false
    @State var showAddMemo = false
    @State var isNavBarHidden = false
    
    var body: some View {
        NavigationView {
                List {
                    ForEach(memos, id: \.date) { memo in
                        // the view of modifying memo
                        NavigationLink(destination: ModifyMemo(memo: memo, isPresented: $isPresented)
                        { id, contents, date in
                            self.addMemo(contents: contents, date: date)
                            self.managedObjectContext.delete(memo)
                        })
                        {
                            MemoRow(memo: memo)
                        }
                    }
                    .onDelete(perform: deleteMemo)
                }
                .navigationBarTitle(Text("Memo"))
                .navigationBarItems(
                    trailing:
                        // the view of adding memo
                        Button(action: { self.showAddMemo = true }) {
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 22))
                                .foregroundColor(Color("Color8"))
                        }
                        .sheet(isPresented: $showAddMemo) { //add memo sheet
                            AddMemo(showAddMemo: $showAddMemo) { id, contents, date in
                                self.addMemo(contents: contents, date: date)
                                self.showAddMemo = false
                            }
                        }
                )
        }.navigationBarHidden(true)
    }
}


// <-- function -->
extension MemoList {
    
    func deleteMemo(at offsets: IndexSet) {
        offsets.forEach { index in
            let memo = self.memos[index]
            self.managedObjectContext.delete(memo)
        }
        saveContext()
    }
    
    func addMemo(contents: String, date: Date) {
        let newMemo = Memo(context: managedObjectContext)
        
        newMemo.contents = contents
        newMemo.date = date
        
        saveContext()
    }
    
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error: \(error)")
        }
    }
}
