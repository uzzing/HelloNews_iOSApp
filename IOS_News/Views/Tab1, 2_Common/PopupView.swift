//
//  PopupView.swift
//  IOS_News
//
//  Created by uzzing on 2021/05/23.
//

import SwiftUI

struct PopupView: View {
    
    @Binding var showPopUp: Bool
    
    var body: some View {
        ZStack {
            //Color.white.opacity(showPopUp ? 1 : 0).edgesIgnoringSafeArea(.all)
            
            // PopUp Window
            VStack(alignment: .center, spacing: 0) {
                
                Text("The word is stored in your vocabulary!")
                    .multilineTextAlignment(.center)
                    .font(Font.system(size: 20, weight: .semibold))
                    .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                
                Button(action: {
                    // Dismiss the PopUp
                    withAnimation(.easeInOut(duration: 5)) {
                        showPopUp = false
                    }
                }, label: {
                    Text("Ok")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50, alignment: .center)
                        .foregroundColor(Color.white)
                        .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).opacity(3.0))
                        .font(Font.system(size: 17, weight: .semibold))
                }).buttonStyle(PlainButtonStyle())
            }
            .frame(maxWidth: 300)
            .background(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)).opacity(3.0))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
        }.opacity(50)
    }
}

