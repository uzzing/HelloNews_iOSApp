//
//  CardView_1.swift
//  IOS_News
//
//  Created by uzzing on 2021/05/30.
//

import SwiftUI

struct CardView : View {

    var reader : GeometryProxy
    @Binding var swiped : Int
    
    // <-- the data received -->
    @State var item: Item
    @State var items: [Item]
    
    var body: some View {
        
        VStack{
            
            Spacer(minLength: 0) //middle position
            
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
                
                VStack{
                    
                    HStack{
                        VStack(alignment: .center, spacing: 10) {
                            
                            Text("\(item.title)")
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding(.bottom, -10)
                            
                            Text("\(item.mean)")
                                .font(.system(size: 30))
                                .foregroundColor(.black)
                            
                            HStack {
                                
                                (Text(Image(systemName: "arrowshape.turn.up.backward"))
                                    + Text("  Know"))
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.blue.opacity(0.2))
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                    .cornerRadius(10)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                                    .padding()
                                    .offset(x: 20)
                                
                                Spacer()
                                
                                (Text("Pass  ") +
                                    Text(Image(systemName: "arrowshape.turn.up.right")))
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.red.opacity(0.3))
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                    .cornerRadius(10)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                                    .padding()
                                    .offset(x: -20.0)
                            }
                        }
                        Spacer(minLength: 0)
                        
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 15)
                    .padding(.top, 25)
                }
            }
            )
            .padding(.vertical,10)
            .background(Color.white)
            .cornerRadius(25)
            .shadow(color: Color.black.opacity(0.12), radius: 5, x: 0, y: 5)
           
            Spacer(minLength: 0)
        }
    }
}
