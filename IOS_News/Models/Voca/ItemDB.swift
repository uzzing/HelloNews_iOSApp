//
//  ItemDB.swift
//  IOS_News
//
//  Created by uzzing on 2021/05/23.
//

import RealmSwift

class ItemDB: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var mean = ""
    @objc dynamic var order = 0
    @objc dynamic var favorites = false
    @objc dynamic var offset = 0
    
    override class func primaryKey() -> String? {
        "id"
    }
}
