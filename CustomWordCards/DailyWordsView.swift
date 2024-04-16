// DailyWordsView.swift
// 所有測驗單字列表

import SwiftUI
import SwiftData

struct DailyWordsView: View {
    @Environment(\.modelContext) private var modelContext
    // 依照字母升冪排列（在這裡效果是日期越小（類型為字串）越前面）
    @Query(sort: \Word.nextTimeReview, order: .forward) private var words: [Word]
    
    let partOfSpeechArray = Word.partOfSpeechArray

    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                if words.isEmpty {
                    // 防呆
                    Text("你尚未輸入任何單字！")
                        .font(.title)
                } else {
                    NavigationStack {
                        List {
                            ForEach(words) { word in
                                VStack {
                                    HStack {
                                        Text(word.english)
                                            .font(.largeTitle)
                                            .padding()
                                        Text(partOfSpeechArray[word.partOfSpeech])
                                            .font(.system(size: 18))
                                        Spacer()
                                    }
                                    Divider()
                                        .overlay(Color(red: 129/255,green: 130/255, blue: 154/255))
                                    HStack {
                                        Spacer()
                                        VStack(alignment: .center) {
                                            Text("下次複習：")
                                            Text(word.nextTimeReview)
                                                .font(.system(size: 16))
                                        }
                                        
                                        Spacer()
                                        
                                        Divider()
                                            .overlay(Color(red: 129/255,green: 130/255, blue: 154/255))
                                        
                                        Spacer()
                                        Text("已複習次數:")
                                        Text("\(word.reviewCount)")
                                        Spacer()
                                    }
                                }
                                .listRowBackground(Color(red: 84/255, green: 86/255, blue: 115/255))
                                .listRowSeparator(.hidden)
                            }
                            .onDelete(perform: removeWord)
                        }
                        .scrollContentBackground(.hidden)
                        .background(Color(red: 58/255, green: 63/255, blue: 89/255))
                    }
                }
                
                Spacer()
            }
            .foregroundStyle(.white)
            
            Spacer()
        }
        .background(Color(red: 58/255, green: 63/255, blue: 89/255))
    }

    // （手動）刪除單字
    private func removeWord(_ indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(words[index])
        }
    }
}
