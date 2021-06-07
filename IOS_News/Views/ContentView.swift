
//  ContentView.swift
//  IOS_News
//
//  Created by pcw on 2021/06/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    @State var selectedtab = "eng"
    init() {
        UITabBar.appearance().isHidden = true
    }
    // Location For each Curve...
    @State var xAxis: CGFloat = 0
    @Namespace var animation
    var body: some View{
        NavigationView {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
                TabView(selection: $selectedtab){
                    
                    EngMainView()
                        .ignoresSafeArea(.all, edges: .all)
                        .tag("eng")
                    
                    JpnMainView()
                        .ignoresSafeArea(.all, edges: .all)
                        .tag("jpn")
                    
                    VocaMainView()
                        .ignoresSafeArea(.all, edges: .all)
                        .tag("voca")
                    
                    MemoMainView()
                        .ignoresSafeArea(.all, edges: .all)
                        .tag("memo")
                }
                
                // Custom tab Bar...
                HStack(spacing: 0) {
                    ForEach(tabs, id: \.self) { image in
                        GeometryReader { reader in
                            Button(action: {
                                withAnimation(.spring()){
                                    selectedtab = image
                                    xAxis = reader.frame(in: .global).minX
                                }
                            }, label: {
                                Image(image)
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 37, height: 37)
                                    .foregroundColor(selectedtab == image ? getColor(image: image) : Color.gray)
                                    .padding(selectedtab == image ? 17 : 0)
                                    .background(Color.white.opacity(selectedtab == image ? 1 : 0).clipShape(Circle()))
                                    .matchedGeometryEffect(id: image, in: animation)
                                    .offset(x: selectedtab == image ? (reader.frame(in: .global).minX - reader.frame(in: .global).midX) : 0, y: selectedtab == image ? -50 : -8)
                            })
                            .onAppear(perform: {
                                if image == tabs.first {
                                    xAxis = reader.frame(in: .global).minX
                                }
                            })
                        }
                        .frame(width: 30, height: 40)
                        if image != tabs.last{Spacer(minLength: 0)}
                    }
                }
                .offset(x: -6, y: 8)
                .padding(.horizontal, 40)
                .padding(.vertical, 15)
                .background(Color.white.clipShape(CustomShape(xAxis: xAxis)).cornerRadius(15))
                .padding(.horizontal)
                // Bottom Edge...
                .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
    
    // getting Image Color....
    func getColor(image: String) -> Color {
        
        // switch must include default
        switch image {
        case "eng":
            return Color("Color1")
        case "jpn":
            return Color("Color2")
        case "voca":
            return Color("Color3")
        default:
            return Color("Color4")
        }
    }
}


var tabs = ["eng","jpn","voca","memo"]


// Curve
struct CustomShape: Shape {
    
    var xAxis: CGFloat
    
    // Animating Path
    var animatableData: CGFloat {
        get { return xAxis }
        set { xAxis = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let center = xAxis
            path.move(to: CGPoint(x: center - 50, y: 0))
            
            let to1 = CGPoint(x: center, y: 35)
            let control1 = CGPoint(x: center - 25, y: 0)
            let control2 = CGPoint(x: center - 25, y: 40)
            
            let to2 = CGPoint(x: center + 50, y: 0)
            let control3 = CGPoint(x: center + 25, y: 50)
            let control4 = CGPoint(x: center + 25, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}

