// NewWordView.swift
// 新增單字頁面

import SwiftUI
import SwiftData

struct NewWordView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var word: [Word]
    
    @State private var isShowWarnning = false
    
    @State private var englishWord = ""
    @State private var chineseWord = ""
    let partOfSpeechArray = Word.partOfSpeechArray
    @State private var partOfSpeech = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            Section {
                Section {
                    TextField("", text: $englishWord, prompt: Text("英文").foregroundStyle(Color(red: 129/255,green: 130/255, blue: 154/255)), axis: .vertical)
                    TextField("", text: $chineseWord, prompt: Text("中文").foregroundStyle(Color(red: 129/255,green: 130/255, blue: 154/255)), axis: .vertical)
                    HStack {
                        Text("詞性")
                            .foregroundStyle(Color(red: 129/255,green: 130/255, blue: 154/255))
                        Picker("", selection: $partOfSpeech) {
                            ForEach(Array(partOfSpeechArray.indices)) { index in
                                Text(partOfSpeechArray[index]).tag(index)
                            }
                        }
                    }
                }
                .padding(.horizontal, 35)
                .frame(minHeight: 70)
                .foregroundStyle(.white)
                .font(.system(size: 35, design: .monospaced))
                
                Section {
                    Button("保存") {
                        if englishWord == "" || chineseWord == "" {
                            isShowWarnning = true
                        }else {
                            saveWordToSwiftData()
                        }
                    }
                    
                }
                .frame(width: 110, height: 45)
                .font(.system(size: 20, design: .monospaced))
                .foregroundStyle(.blue)
                .alert(
                    // 防呆
                    "輸入不能為空！",
                    isPresented: $isShowWarnning
                ) {
                    
                } message: {}
            }
            .background(Color(red: 84/255, green: 86/255, blue: 115/255))
            .cornerRadius(7)
            
            Spacer()
        }
        .padding(.horizontal, 25)
        .background(Color(red: 58/255, green: 63/255, blue: 89/255))
        .onTapGesture {
            // 開啟鍵盤時點擊畫面（VStack範圍內）就會收起鍵盤
            hideKeyboard()
        }
    }
    
    // 儲存新輸入的單字
    private func saveWordToSwiftData() {
        let newWord = Word(english: englishWord, chinese: chineseWord, partOfSpeech: partOfSpeech, inputDate: Date.dateToString(Date()), lastTimeReview: Date.dateToString(Date()), nextTimeReview: Date.dateToString(Date()), reviewCount: 0)

        modelContext.insert(newWord)
        clearFields()
    }

    // 重置（清空）單字輸入匡
    private func clearFields() {
        englishWord = ""
        chineseWord = ""
        partOfSpeech = 0
    }
}
