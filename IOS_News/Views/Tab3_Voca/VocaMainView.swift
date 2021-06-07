//
//  VocaView.swift
//  IOS_News
//
//  Created by uzzing on 2021/05/23.
//

import SwiftUI

struct VocaMainView: View {
    @EnvironmentObject var store: ItemStore
    
    var body: some View {
        ItemListView(items: store.items)
    }
}
