// ContentView.swift
// 整體介面控制

import SwiftUI
import UIKit
import SwiftData

struct ContentView: View {
    // 修改UITabBar的底色
    init() {
        UITabBar.appearance().backgroundColor = UIColor(red: 84/255, green: 86/255, blue: 115/255, alpha: 1.0)
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 139/255, green: 145/255, blue: 165/255, alpha: 1.0)
    }
    
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

// 測試用preview
#Preview {
    ContentView()
        .modelContainer(for: [Item.self, Word.self], inMemory: true)
}
