//
//  Items.swift
//  IOS_News
//
//  Created by uzzing on 2021/05/23.
//

import Foundation
import SwiftUI

struct Item: Identifiable {
    var id: Int
    var title: String
    var mean: String
    var order: Int
    var favorites: Bool
    var offset: CGFloat
}

extension Item {
    init(itemDB: ItemDB) {
        id = itemDB.id
        title = itemDB.title
        mean = itemDB.mean
        order = itemDB.order
        favorites = itemDB.favorites
        offset = CGFloat(itemDB.offset)
    }
}
