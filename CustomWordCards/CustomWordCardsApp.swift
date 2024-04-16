// CustomWordCardsApp.swift
// 主程式與extension

import SwiftUI
import UIKit
import SwiftData

@main
struct CustomWordCardsApp: App {
    // 設定注入進視圖的model
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            Word.self
        ])
        // 持久化保存資料
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        // 若有錯誤則打印出來
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
