//
//  BottomCardView.swift
//  IOS_News
//
//  Created by uzzing on 2021/05/23.
//

import SwiftUI
import WebKit
import AVFoundation

/*------------ translation ----------------*/
struct QuoteData: Decodable {
    var translated_text: [[String]]
}


// <-- View -->
struct CardContent: View {
    
    // <-- for receive data -->
    @State var quotedata: QuoteData?
    @State var inputValue: String = ""
    @State var meanValue: String = ""
    
    // <-- for request dictionary api -->
    @State private var a: String = ""
    @State var tag: Int? = nil
    let characterLimit = 0
    @State var showMoreSpecific = false
    
    // <-- for voca DB -->
    @EnvironmentObject var store: ItemStore
    @State var title = ""
    @State var mean = ""
    var items: [Item]
    
    // <-- for popup -->
    @State private var shouldShowAlert : Bool = false
    @State private var myText : String = ""
    
    var body: some View{
        VStack{
            HStack {
                // <-- receive the word entered -->
                TextField("Enter word", text: $inputValue)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding([.leading, .trailing], 3)
                    .font(.system(size: 22))
                    .padding([.leading, .trailing], 3)
                
                
                // <-- search -->
                Button(action: {
                    self.getMeaning()
                    a = inputValue
                    self.tag = 1
                    self.showMoreSpecific.toggle()
                }){
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 28, height: 29)
                        .font(.system(size: 25))
                        .foregroundColor(.secondary)
                }.padding(5)
                
                // <-- delete -->
                Button(action: {
                    self.inputValue = ""
                    self.quotedata?.translated_text[0][0] = ""
                    self.meanValue = ""
                    self.showMoreSpecific = false
                }){
                    Image(systemName: "multiply.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .font(.system(size: 25))
                        .foregroundColor(.secondary)
                }.padding(8)
            }
            
            HStack {
                // <-- translate -->
                TextField("\(quotedata?.translated_text[0][0] ?? "")", text: $meanValue)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(meanValue.count > (characterLimit - 1))
                    .padding([.leading, .trailing], 3)
                    .font(.system(size: 22))
                    .padding([.leading, .trailing], 3)
                
                // <-- save -->
                Button(action: {
                    self.create()
                    shouldShowAlert = true
                }) { // function
                    Image(systemName: "bookmark.circle") // view
                        .resizable()
                        .frame(width: 30, height: 30)
                        .font(.system(size: 25))
                        .foregroundColor(.secondary)
                }.padding(5)
                
                // <-- sound -->
                Button(action: {
                    let utterance = AVSpeechUtterance(string: inputValue)
                    utterance.voice = AVSpeechSynthesisVoice(language: "en-Us")
                    utterance.rate = 0.5
                    let synthesizer = AVSpeechSynthesizer()
                    synthesizer.speak(utterance)
                }){
                    Image(systemName: "speaker.wave.2")
                        .frame(width: 30, height: 30)
                        .font(.system(size: 30))
                        .foregroundColor(.secondary)
                }.padding(7)
            }
            .padding(.bottom, 10)
            
            // <-- load the dictionary site -->
            // used in 'search'
            if showMoreSpecific {
                let space = inputValue.filter {!$0.isWhitespace} //remove white space
                
                VStack {
                    NavigationView {
                        NavigationLink(destination: DicWebView(urlToLoad: "https://en.dict.naver.com/#/search?range=example&shouldSearchVlive=false&query=\(space)").navigationBarHidden(true), tag: 1, selection: self.$tag) {}
                    }
                }
            } // the end point of showMoreSpecific
            
        }.alert(isPresented: $shouldShowAlert, content: {
            Alert(title: Text("The word is stored in your vocabulary!"), message: Text("\(myText)"), dismissButton: .default(Text("Ok")))
        })
    }
}


// <-- Function -->
extension CardContent {
    
    func create() {
        meanValue = quotedata?.translated_text[0][0] ?? ""
        store.create(id: items.count, title: self.inputValue, mean: meanValue, order: items.count)
    }
    
    func getMeaning() { // get meaning of words
        let white = inputValue.filter {!$0.isWhitespace} //remove white space
        
        let token = "8995e2de40ee9b465734713e5a0d2ac5"
        guard let url = URL(string: "https://dapi.kakao.com/v2/translation/translate?src_lang=en&target_lang=kr&query=\(white)") else {
            fatalError("Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("KakaoAK"+" "+"\(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else{ return }
            do{
                let decodedData =  try JSONDecoder().decode(QuoteData.self, from: data)
                DispatchQueue.main.async {
                    self.quotedata = decodedData
                }
            } catch let error{
                print(error)
            }
        }.resume()
    }
}
