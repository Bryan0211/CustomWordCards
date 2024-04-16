// QuizView.swift
// 單字測試頁面

import SwiftUI
import SwiftData

struct QuizCardView: View {
    @Environment(\.modelContext) var modelContext
    // 今天以前（包括今天）要複習的單字
    // 依照字母升冪排列（在這裡效果是日期越小（類型為字串）越前面）
    @Query(filter: Word.lessOrSameAsCurrentPredicate(), sort: \Word.nextTimeReview, order: .forward) private var words: [Word]
    
    let partOfSpeechArray = Word.partOfSpeechArray
    let reviewDayGap = Word.reviewDayGap
    @State private var isShowingAnswer = false
    // 完成了該單字每次的複習，可以不用再複習了
    @State private var isShowingEndReviewForever = false
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                ZStack {
                    if words.isEmpty {
                        Text("今天沒有單字！")
                            .font(.title)
                    } else {
                        if isShowingAnswer {
                            VStack {
                                Text(words[0].english)
                                    .frame(maxWidth: 300)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.vertical, 25)
                                    .font(.largeTitle)
                                Text("\(words[0].chinese) \(partOfSpeechArray[words[0].partOfSpeech])")
                                    .font(.title)
                                HStack {
                                    // 錯誤
                                    Button("Wrong") {
                                        handleWrongAnswer()
                                    }
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(7)
                                    
                                    Spacer()
                                    
                                    // 正確
                                    Button("Correct") {
                                        handleCorrectAnswer()
                                    }
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(7)
                                }
                                .padding(.top, 30)
                            }
                        } else {
                            VStack {
                                Text(words[0].english)
                                    .frame(maxWidth: 300)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.vertical, 25)
                                    .font(.largeTitle)
                                    .foregroundStyle(.white)
                                
                                Text(partOfSpeechArray[words[0].partOfSpeech])
                                    .frame(maxWidth: 300)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.vertical, 25)
                                    .font(.title)
                                    .foregroundStyle(.white)
                                Button("顯示答案") {
                                    // 變true顯示答案
                                    isShowingAnswer.toggle()
                                }
                                .frame(width: 110, height: 45)
                                .background(Color(red: 84/255, green: 86/255, blue: 115/255))
                                .cornerRadius(7)
                            }
                            .frame(maxHeight: 250)
                        }
                    }
                    
                    if isShowingEndReviewForever {
                        Color.gray.overlay {
                            VStack {
                                Text("恭喜你已經長久地背起這個單字！")
                                    .font(.title)
                                Text("以後不用再複習該單字..")
                                    .font(.system(size: 18))
                                Button("確認") {
                                    isShowingEndReviewForever.toggle()
                                }
                            }
                        }
                        .frame(width: 200, height: 140)
                    }
                }
                .foregroundStyle(.white)
                
                Spacer()
            }
            
            Spacer()
        }
        .padding(.horizontal, 25)
        .background(Color(red: 58/255, green: 63/255, blue: 89/255))
    }

    // 處理單字測驗正確
    private func handleCorrectAnswer() {
        let word = words[0]
        var reviewCount = word.reviewCount
        
        // 成功複習了8次（近乎變長期記憶），因此刪掉並退出function
        if reviewCount == 8 {
            modelContext.delete(words[0])
            
            return
        }
        
        let current = Date()
        // 重設下次複習日期
        word.nextTimeReview = Date.dateToString( current.addingTimeInterval( TimeInterval(reviewDayGap[reviewCount].day) ) )
        word.lastTimeReview = Date.dateToString(Date())
        
        // 成功複習次數加1
        reviewCount += 1
        
        // 變false不顯示答案
        isShowingAnswer.toggle()
    }

    // 處理單字測驗錯誤
    private func handleWrongAnswer() {
        let word = words[0]
        var reviewCount = word.reviewCount
        // 成功複習次數歸0
        reviewCount = 0
        
        let current = Date()
        // 重設下次複習日期
        word.nextTimeReview = Date.dateToString( current.addingTimeInterval( TimeInterval(reviewDayGap[reviewCount].day) ) )
        word.lastTimeReview = Date.dateToString(Date())
        
        // 變false不顯示答案
        isShowingAnswer.toggle()
    }
}

