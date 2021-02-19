//
//  text.swift
//  SwDiary
//
//  Created by 김소원 on 2021/02/18.
//

import Foundation
class Diary {
    var content: String
    var datecontent: Date
 // dummydata 생성
    
    init(content:String) {
        self.content = content
        self.datecontent = Date()
    }

    static var dummyDiary = [
        Diary(content: "오늘의 일기🌝"),
        Diary(content: "내일의 계획🌞")
]
}
