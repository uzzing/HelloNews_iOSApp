//
//  AZAlert.swift
//  IOS_News
//
//  Created by uzzing on 2021/05/29.
//

import SwiftUI

struct AZAlert: View {

    let screenSize = UIScreen.main.bounds
    var message: String = ""
    @Binding var isShown: Bool
    @Binding var title: String
    @Binding var mean: String
    var onDone: (String, String) -> Void = { _,_  in }
    var onCancel: () -> Void = { }
    
    @State private var myText : String = ""
    @State private var shouldShowAlert : Bool = false
    

    var body: some View {
        
        VStack(spacing: 20) {
            Text(message)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            
            TextField("Enter word", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .border(Color.white)
                .cornerRadius(5)
                .font(.system(size: 20))
                .padding(.bottom, -5)
            
            TextField("Enter meaning", text: $mean)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .border(Color.white)
                .cornerRadius(5)
                .font(.system(size: 20))
            
            HStack(spacing: 20) {
                Button(action: {
                    if (title == "" || mean == "") {
                        self.shouldShowAlert = true
                        self.isShown = false
                        return
                    }
                    self.onDone(self.title, self.mean)
                    self.isShown = false
                    self.mean = ""
                    self.title = ""
                }, label: {
                    Text("Done")
                        .foregroundColor(Color.white)
                        .font(.system(size: 20, weight: .bold))
                })
                
                Button(action: {
                    self.isShown = false
                    self.onCancel()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(Color.white)
                        .font(.system(size: 20, weight: .bold))
                })
            }
        }
        .alert(isPresented: $shouldShowAlert, content: {
            Alert(title: Text("Please enter all value"), message: Text("\(myText)"), dismissButton: .none)
        })
        .padding()
        .frame(width: screenSize.width * 0.7, height: screenSize.height * 0.3)
        .background(Color("Color3"))
        .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
        .offset(y: isShown ? 0 : screenSize.height)
        .animation(.spring())
        .shadow(color: Color(#colorLiteral(red: 0.8596749902, green: 0.854565084, blue: 0.8636032343, alpha: 1)), radius: 6, x: 5, y: 5)
    }
}
