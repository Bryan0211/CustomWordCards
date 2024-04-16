// WordModel.swift
// 單字儲存格式

import Foundation
import SwiftData

@Model
final class Word {
    var english: String = ""
    var chinese: String = ""
    var partOfSpeech: Int = 0
    var inputDate: String = Date.dateToString(Date())
    var lastTimeReview: String
    var nextTimeReview: String
    var reviewCount: Int = 0
    
    init(english: String, chinese: String, partOfSpeech: Int, inputDate: String, lastTimeReview: String, nextTimeReview: String, reviewCount: Int) {
        self.english = english
        self.chinese = chinese
        self.partOfSpeech = partOfSpeech
        self.inputDate = inputDate
        self.lastTimeReview = lastTimeReview
        self.nextTimeReview = nextTimeReview
        self.reviewCount = reviewCount
    }
}
