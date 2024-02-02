//
//  ContentView.swift
//  CustomWordCards
//
//  Created by 游尚諺 on 2024/1/24.
//

import SwiftUI
import UIKit
import SwiftData

struct ContentView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor(red: 84/255, green: 86/255, blue: 115/255, alpha: 1.0)
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 139/255, green: 145/255, blue: 165/255, alpha: 1.0)
    }
    
    @Environment(\.modelContext) private var modelContext
    @Query private var word: [Word]
    
    var body: some View {
        TabView {
             NewWordView()
             .tabItem {
             Label("新增單字", systemImage: "pencil.circle")
             }
             QuizCardView()
             .tabItem {
             Label("複習單字", systemImage: "star.circle.fill")
             }
             DailyWordsView()
             .tabItem {
             Label("單字列表", systemImage: "list.bullet")
             }
        }
        
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Item.self, Word.self], inMemory: true)
}
