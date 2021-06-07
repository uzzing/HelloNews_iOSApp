//
// Learning.swift
// IOS_News
//
// Created by PCW on 2021/05/26.
//
import SwiftUI

// <-- view -->

struct Learning : View {

    @State var item: [Item]
    @State var swiped = 0

    @ObservedObject var function: functionOfLearning


    var body: some View {
        VStack {

            GeometryReader { reader in

                ForEach(item.reversed()) { items in
                    CardView(reader: reader, swiped: $swiped, tool: items, function: function)
                        .offset(x: items.offset)
                        .rotationEffect(.init(degrees: function.getRotation(offset: items.offset)))
                        .gesture(
                            DragGesture()
                                .onChanged({ (value) in

                                    withAnimation(.default){
                                        item[items.order].offset = value.translation.width
                                    }
                                    print("order \(items.order) when onchanged")
                                })
                                .onEnded({ (value) in
                                    withAnimation(.easeIn) {

                                        if item[items.order].offset > 150 { // go to right
                                            item[items.order].offset = 500
                                        }
                                        else if item[items.order].offset < -150 { // go to left
                                            item[items.order].offset = -500
                                            swiped = items.order + 1
                                            function.restoreCard(order: items.order)
                                        }
                                        else {

                                            item[items.order].offset = 0
                                        }
                                    }
                                    print("order \(items.order) when onended")
                                    print("done\n")
                                })
                )}.offset(y: -25)
            }
        }
    }
}

//extension Learning {
class functionOfLearning: ObservableObject {

    @Published var item: [Item]

    init(item: [Item]) {
        self.item = item
    }

    func restoreCard(order: Int) {

        // tool.order
        var currentCard = item[order] // error : index out of range
        // appending last..
        currentCard.order = item.endIndex
        item[0] = item[order + 1]
        item.append(currentCard)

        // Going Back Effect...
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                // last one we appended..'
                self.item[self.item.count - 1].offset = 0
            }
        }
    }

    func getRotation(offset: CGFloat)->Double{
       let value = offset / 150
       // you can give your own angle here...
       let angle : CGFloat = 5
       let degree = Double(value * angle)
       return degree
    }
}
