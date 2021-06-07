//
//  ModifyMemo.swift
//  IOS_News
//
//  Created by uzzing on 2021/06/02.
//


import SwiftUI


struct ModifyMemo: View {
    
    @EnvironmentObject var formatter: DateFormatter
    @Environment(\.presentationMode) var presentation
    
    @State var id = UUID()
    @State var contents = ""
    @State var date = Date()
    var memo: Memo
    
    // <-- cancel make new memo -->
    @Binding var isPresented: Bool
    
    // <-- store new memo -->
    let onComplete: (UUID, String, Date) -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                memo.date.map { Text(self.formatter.string(from: $0))}
                    .font(.subheadline)
                    .padding(10)
                
                TextView(text: $contents)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle("Memo", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }, label: {
                        Text("cancel").foregroundColor(Color("Color8")) }),
                trailing:
                    Button(action: {
                        addMemoAction()
                        self.presentation.wrappedValue.dismiss()
                    }, label: {
                        Text("Done").foregroundColor(Color("Color8")) })
            )
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .onAppear {
            self.contents = memo.contents ?? ""
        }
    }
    
    func addMemoAction() {
        onComplete(
            id,
            contents.isEmpty ? "" : contents,
            date)
    }
}
