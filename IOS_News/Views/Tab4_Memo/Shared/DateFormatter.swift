//
//  DateFormatter+Memo.swift
//  SwiftUIMemo
//
//  Created by PCW on 2021/05/06.
//

import Foundation

extension DateFormatter {
  
  static let memoDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    formatter.locale = Locale(identifier: "Ko_kr")
    formatter.dateFormat = "yyyy/MM/dd hh:mm a"
    
    formatter.amSymbol = "AM"
    formatter.pmSymbol = "PM"
    
    return formatter
  }()
}

extension DateFormatter: ObservableObject {
    
}
