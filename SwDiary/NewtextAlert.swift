//
//  NewtextAlert.swift
//  SwDiary
//
//  Created by 김소원 on 2021/02/17.
//

import UIKit

extension NewViewController{
    
    func alert(title:String="경고", message:String="입력해주세요!"){
        let alert = UIAlertController(title: "경고", message: "입력해주세요!", preferredStyle:UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil) //다이어리 아무것도 입력하지 않았을때 경고창 기능선언
        
    }
    
    
}
