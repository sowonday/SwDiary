//
//  Text.swift
//  SwDiary
//
//  Created by 김소원 on 2021/02/09.
//

import Foundation

class Diary {
    var content: String
    var contentDate: Date
    
    init(content: String) {
        self.content = content
        contentDate = Date()
    }
    
    static var dummyDiary = [
        Diary(content: "오늘의 일기🌝"),
        Diary(content: "내일의 계획🌞")
    ]
    
}
