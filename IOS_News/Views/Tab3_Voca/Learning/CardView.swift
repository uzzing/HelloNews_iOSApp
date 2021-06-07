//
//import SwiftUI
//
//struct CardView : View {
//    var reader : GeometryProxy
//    @Binding var swiped : Int
//
//    // <-- the data received -->
//    @State var tool : Item
//
//    // <-- the functino received -->
//    @ObservedObject var function: functionOfLearning
//    
//    var body: some View {
//        VStack{
//            Spacer(minLength: 0) //middle position
//
//            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
//                VStack{
//                    HStack{
//                        VStack(alignment: .center, spacing: 10) {
//                            Text("\(tool.title)")
//                                .font(.system(size: 40))
//                                .fontWeight(.bold)
//                                .foregroundColor(.black)
//
//                            Text("\(tool.mean)")
//                                .padding()
//                                .font(.system(size: 30))
//                                .foregroundColor(.black)
//
//
//                            HStack {
//
//                                // left button "I don't know"
//                                Button(action: {
//
//                                    withAnimation(Animation.easeIn(duration: 0.8)){
//                                        tool.offset = 500
//                                    }
//                                    function.restoreCard(order: tool.order)
//
//                                }, label: {
//                                    Text("I don't know")
//                                    Image(systemName: "arrowshape.turn.up.backward")
//                                })
//                                .padding()
//                                .foregroundColor(.white)
//                                .background(Color.red.opacity(0.3))
//                                .font(.system(size: 20, weight: .heavy, design: .default))
//                                .cornerRadius(10)
//                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
//                                .padding()
//                                .offset(x: -5.0)
//
//
//                                Spacer()
//
//                                // right button "I know"
//                                Button(action: {
//                                    withAnimation(Animation.easeIn(duration: 0.8)){
//                                        tool.offset = -500
//                                    }
//                                }, label: {
//                                    Image(systemName: "arrowshape.turn.up.right")
//                                    Text("I know")
//                                })
//                                .padding()
//                                .foregroundColor(.white)
//                                .background(Color.yellow.opacity(0.5))
//                                .font(.system(size: 20, weight: .heavy, design: .default))
//                                .cornerRadius(10)
//                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
//                                .padding()
//                                .offset(x: 15)
//
//                            }
//                        }
//                        Spacer(minLength: 0)
//                    }
//                    .padding(.horizontal, 30)
//                    .padding(.bottom, 15)
//                    .padding(.top, 25)
//                }
//            }
//            )
//            .padding(.vertical,10)
//            .background(Color.white)
//            .cornerRadius(25)
//            .shadow(color: Color.black.opacity(0.12), radius: 5, x: 0, y: 5)
//
//            Spacer(minLength: 0)
//        }
//    }
//}
