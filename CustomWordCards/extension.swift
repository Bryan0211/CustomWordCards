import SwiftUI
import UIKit
import SwiftData


//-----以下為型別與物件擴展-----//

extension Int {
    public var minute: Int {
        // 數字分鐘的秒數
        return self*60
    }
    
    public var hour: Int {
        // 數字小時的秒數
        return self*60*60
    }
    
    public var day: Int {
        // 數字天的秒數
        return self*60*60*24
    }
    
    public var month: Int {
        // 數字月的秒數(平均)
        return self*(60*60*24)*30
    }
    
    public var year: Int {
        // 數字年的秒數(平均)
        return self*((60*60*24)*30)*365
    }
}

// 提取出的數組的值若會變動，在ForEach裡需要id來辨別
extension String: Identifiable {
    public var id: String {
        self
    }
}

// 提取出的數組的值若會變動，在ForEach裡需要id來辨別
// 專門給Foreach需要index（index類型為Int）時用，並請配合使用Foreach(Array(somthingArray.indices))（ 或Foreach(Array(0..<somthingArray.count)) ）
extension Int: Identifiable {
    public var id: Int {
        self
    }
}

extension Date {
    // date實例轉字串
    static func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let string = formatter.string(from: date)
        
        return string
    }
    
    // 字串轉date實例（可能值為nil空值）
    static func stringToDate(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: dateString)
        
        return date
    }
}

// 手動添加隱藏鍵盤擴展
extension View {
    func hideKeyboard() {
        // 在這裡resignFirstResponder為正在響應用戶輸入者
        // target值為nil（空值）時，會將訊息給resignFirstResponder其響應者鏈中有最高控制事件權者（在此處為UIApplication，能控制旗下元件的事件）上處理，停止使用鍵盤
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// Word SwiftData模型的擴展
extension Word {
    // 新增單字時的詞性選項
    static let partOfSpeechArray = ["n.名詞", "v.動詞", "adj.形容詞", "adv.副詞", "conj.連接詞", "prep.介系詞", "phr.片語", "pron.代名詞", "num 數詞", "abbr.縮寫", "int.感嘆詞", "det.限定詞"]
    
    // 不同複習次數對應不同間隔天數（參照艾賓豪斯記憶法）
    static let reviewDayGap = [1, 2, 4, 7, 15, 30, 90, 180]
    
    // 目前#Predicate內不支持使用Date()，因此改用日期字串比較
    static func lessOrSameAsCurrentPredicate() -> Predicate<Word> {
        let currentDate = Date.dateToString(Date())
        
        return #Predicate<Word> { word in
            word.nextTimeReview <= currentDate
        }
    }
}
