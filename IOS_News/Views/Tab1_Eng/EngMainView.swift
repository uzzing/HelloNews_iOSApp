//
//  EngView.swift
//  IOS_News
//
//  Created by uzzing on 2021/05/23.
//

import SwiftUI

struct EngMainView : View {
    
    var body: some View {
        ZStack {
            Color("Color1").edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    // bbc
                    NavigationLink(destination: BBC()){
                        VStack {
                            Image("BBC")
                                .resizable()
                                .frame(width: 97, height: 97, alignment: .center)
                                .aspectRatio(1, contentMode: .fit) // 배율
                                .cornerRadius(20)
                            
                            Text("BBC")
                                .font(.title3)
                                
                        }
                        .padding()
                        .foregroundColor(Color("Color5"))
                        .background(Color.white)
                        .font(.largeTitle)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 4)
                        .padding()
                    }
                    
                    // cnn
                    NavigationLink(destination: CNN()) {
                        VStack {
                            Image("CNN")
                                .resizable()
                                .frame(width: 97, height: 97, alignment: .center)
                                .aspectRatio(1, contentMode: .fit) // 배율
                            
                            Text("CNN")
                                .font(.title3)
                        }
                        .padding()
                        .foregroundColor(Color("Color5"))
                        .background(Color.white)
                        .font(.largeTitle)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 4)
                        .padding()
                        
                    }
                }
                
                HStack {
                    // google
                    NavigationLink(destination: Google()) {
                        VStack {
                            Image("google")
                                .resizable()
                                .frame(width: 97, height: 97, alignment: .center)
                                .aspectRatio(1, contentMode: .fit) // 배율
                            
                            Text("Google")
                                .font(.title3)
                        }
                        .padding()
                        .foregroundColor(Color("Color5"))
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 4)
                        .padding()
                    }
                    
                    // fox
                    NavigationLink(destination: Fox()){
                        VStack {
                            Image("FOX")
                                .resizable()
                                .frame(width: 95, height: 95, alignment: .center)
                                .aspectRatio(1, contentMode: .fit) // 배율
                            
                            Text("FOX")
                                .font(.title3)
                        }
                        .padding()
                        .foregroundColor(Color("Color5"))
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 4)
                        .padding()
                    }
                }
                
            }
        }
    }
}
