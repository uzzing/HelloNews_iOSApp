//
//  JpnView.swift
//  IOS_News
//
//  Created by uzzing on 2021/05/23.
//

import SwiftUI

struct JpnMainView : View {
    
    var body: some View {
        ZStack {
            
            Color("Color2").edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    // Yahoo
                    NavigationLink(destination: Yahoo()){
                        VStack {
                            Image("Yahoo")
                                .resizable()
                                .frame(width: 95, height: 95, alignment: .center)
                                .aspectRatio(1, contentMode: .fit) // 배율
                                .cornerRadius(20)
                            
                            Text("Yahoo")
                                .font(.title3)
                        }
                        .padding()
                        .foregroundColor(Color("Color6"))
                        .background(Color.white)
                        .font(.largeTitle)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 4)
                        .padding()
                    }
                    
                    // Oricon
                    NavigationLink(destination: Oricon()){
                        VStack {
                            Image("Oricon")
                                .resizable()
                                .frame(width: 95, height: 95, alignment: .center)
                                .aspectRatio(1, contentMode: .fit) // 배율
                            
                            Text("Oricon")
                                .font(.title3)
                        }
                        .padding()
                        .foregroundColor(Color("Color6"))
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 4)
                        .padding()
                    }
                }
                
                HStack {
                    // Mainichi
                    NavigationLink(destination: Mainichi()) {
                        VStack {
                            Image("Mainichi")
                                .resizable()
                                .frame(width: 95, height: 95, alignment: .center)
                                .aspectRatio(1, contentMode: .fit) // 배율
                            
                            Text("Mainichi")
                                .font(.title3)
                        }
                        .padding()
                        .foregroundColor(Color("Color6"))
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 4)
                        .padding()
                    }
                    
                    // Nikkei
                    NavigationLink(destination: Nikkei()) {
                        VStack {
                            Image("Nikkei")
                                .resizable()
                                .frame(width: 95, height: 95, alignment: .center)
                                .aspectRatio(1, contentMode: .fit) // 배율
                            
                            Text("Nikkei")
                                .font(.title3)
                        }
                        .padding()
                        .foregroundColor(Color("Color6"))
                        .background(Color.white)
                        .font(.largeTitle)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 4)
                        .padding()
                        
                    }
                }
                
            }
        }
    }
}
