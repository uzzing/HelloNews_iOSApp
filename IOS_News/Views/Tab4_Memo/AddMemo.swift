//
//  AddMemo.swift
//  IOS_News
//
//  Created by uzzing on 2021/06/02.
//

import SwiftUI


struct AddMemo: View {
    
    @EnvironmentObject var formatter: DateFormatter
    
    @State var id = UUID()
    @State var contents = ""
    @State var date = Date()
    var memo: Memo? = nil
    
    // <-- cancel make new memo -->
    @Binding var showAddMemo: Bool
    
    // <-- store new memo -->
    let onComplete: (UUID, String, Date) -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(date, formatter: formatter)")
                    .font(.subheadline)
                    .padding(10)
                
                TextView(text: $contents)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle("New memo", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: { self.showAddMemo = false }
                           ,label: { Text("cancel").foregroundColor(Color("Color8")) }),
                trailing:
                    Button(action: addMemoAction
                           ,label: { Text("Done").foregroundColor(Color("Color8")) })
            )
        }
        .onAppear {
            self.contents = memo?.contents ?? ""
        }
    }
    
    func addMemoAction() {
        onComplete(
            id,
            contents.isEmpty ? "" : contents,
            date)
    }
}
