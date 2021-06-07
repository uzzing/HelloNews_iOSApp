//
//  ItemStore.swift
//  IOS_News
//
//  Created by uzzing on 2021/05/23.
//

import RealmSwift

final class ItemStore: ObservableObject {
    
    @Published var showFavoritesOnly = false
    
    private var itemResults: Results<ItemDB>
    
    init(realm: Realm) {
        itemResults = realm.objects(ItemDB.self)
            .sorted(byKeyPath: "id")
    }
    
    var items: [Item] {
        itemResults.map(Item.init)
    }
}

extension ItemStore {

    func updateOffset(id: Int, newOffset: CGFloat) {
        objectWillChange.send()
        do {
            let realm = try Realm()
            try realm.write {
                realm.create(ItemDB.self,
                             value: ["id": id,
                                     "offset": newOffset],
                             update: .modified)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func updateFav(id: Int, favorites: Bool) {
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.create(ItemDB.self,
                             value: ["id": id,
                                     "favorites": favorites],
                             update: .modified)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func create(id: Int, title: String, mean: String, order: Int) {
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            
            let itemDB = ItemDB()
            itemDB.id = id
            itemDB.title = title
            itemDB.mean = mean
            itemDB.order = order
            itemDB.favorites = false
            
            try realm.write {
                realm.add(itemDB)
            }
            
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func delete(id: Int) {
        objectWillChange.send()
        
        guard let itemDB = itemResults.first(where: { $0.id == id }) else {
            return
        }
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(itemDB)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func update(id: Int, order: Int) {
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.create(ItemDB.self,
                             value: ["id": id,
                                     "order": order],
                             update: .modified)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func move(sourceIndexSet: IndexSet, destination: Int) {
        guard let source = sourceIndexSet.first else {
            return
        }
        
        let moveId = items[source].id
        
        if source < destination {
            for i in (source + 1)...(destination - 1) {
                update(id: items[i].id, order: items[i].order - 1)
            }
            update(id: moveId, order: destination - 1)
            
        } else if destination < source {
            for i in (destination...(source - 1)).reversed() {
                update(id: items[i].id, order: items[i].order + 1)
            }
            update(id: moveId, order: destination)
            
        } else {
            return
        }
    }
    
    func printRealm() {
        print(itemResults)
    }
}
