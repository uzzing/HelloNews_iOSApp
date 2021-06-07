//
//  Learning_1.swift
//  IOS_News
//
//  Created by uzzing on 2021/05/30.
//

import SwiftUI


struct Learning: View {

    @EnvironmentObject var store: ItemStore
    @Environment(\.presentationMode) var presentation
    
    @State var items: [Item]
    @State var swiped = 1
    
    var body: some View {
        
        ZStack {
            Color("Color3").edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("\(swiped)/\(cardCount())")
                    .padding()
                    .font(.system(size: 25, weight: .regular, design: .default))
                
                GeometryReader { reader in
                    
                    ForEach(items.reversed()) { item in
                        CardView(reader: reader, swiped: $swiped, item: item, items: items)
                            .offset(x: item.offset)
                            .gesture(DragGesture()
                                        .onChanged({ (value) in
                                            withAnimation(.default){
                                                if value.translation.width > 0 {
                                                    items[item.id].offset = value.translation.width
                                                }
                                            }
                                        })
                                        .onEnded({ (value) in
                                            withAnimation(.easeIn) {
                                                if value.translation.width > 150 {
                                                    items[item.id].offset = 1000
                                                    restoreCard(id: item.id)
                                                    
                                                    if (swiped == cardCount() + 1) {
                                                        self.presentation.wrappedValue.dismiss()
                                                    }
                                                }
                                                else if value.translation.width < -150 {
                                                    items[item.id].offset = -1000
                                                    swiped = swiped + 1
                                                    
                                                    if (swiped == cardCount() + 1) {
                                                        self.presentation.wrappedValue.dismiss()
                                                    }
                                                }
                                                else {
                                                    items[item.id].offset = 0
                                                }
                                            }
                                        })
                            )
                        
                    }
                    .offset(y: -80)
                }
            }
        }
    }
}

extension Learning {

    // restore this id of card
    func restoreCard(id: Int) {
        
        var currentCard = items[id]
        currentCard.id = items.count
        items.append(currentCard)
        
        print(items)
        print("\n")
        
        // Going Back Effect...
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                // last one we appended..'
                items[items.count - 1].offset = 0
            }
        }
    }
    
    func cardCount() -> Int {
        var maxOrder = items[0].order
        
        for item in items {
            if item.order > maxOrder {
                maxOrder = item.order
            }
        }
        return maxOrder + 1
    }
}
