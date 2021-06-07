//
//  JsonVIew.swift
//  IOS_News
//
//  Created by uzzing on 2021/05/23.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
import WebKit
import SlideOverCard
import AVFoundation
import Combine

struct BBC: View {
    @ObservedObject var list = getBBCData()
    
    var body: some View {
        
        List(list.datas) { i in
            
            NavigationLink(destination: SecondView(url: i.url).edgesIgnoringSafeArea(.all)) {
                HStack(spacing: 15) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(i.title).fontWeight(.heavy)
                        Text(i.desc).lineLimit(2)
                    }
                    
                    if i.image != "" {
                        WebImage(url: URL(string: i.image)!, options: .highPriority, context: nil)
                            .resizable()
                            .frame(width: 110, height: 135)
                            .cornerRadius(20)
                    }
                }.padding(.vertical, 15)
            }.navigationTitle("BBC")
        }
    }
}


class getBBCData : ObservableObject {
    @Published var datas = [dataType]()
    
    init() {
        let source = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=22ee37347318450da68a58c083093933"
        
        let url = URL(string: source)!
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { (data, _, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            
            for i in json["articles"] {
                
                let title = i.1["title"].stringValue
                let description = i.1["description"].stringValue
                let url = i.1["url"].stringValue
                let image = i.1["urlToImage"].stringValue
                let id = i.1["publishedAt"].stringValue
                
                DispatchQueue.main.async {
                    self.datas.append(dataType(id: id, title: title, desc: description, url: url, image: image))
                }
            }
        }.resume()
    }
}
