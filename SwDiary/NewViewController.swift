//
//  NewViewController.swift
//  SwDiary
//
//  Created by 김소원 on 2021/02/17.
//

import UIKit

class NewViewController: UIViewController {
    
    
    var editTatget: Diary?
    
    
    @IBAction func cancel(_ sender: Any) {
        		
        let cancelalert = UIAlertController(title: "CANCEL", message: "저장되지않습니다.", preferredStyle: UIAlertController.Style.alert)
        
        let clokaction = UIAlertAction(title: "OK", style: .destructive) { (action:UIAlertAction)-> Void in self.dismiss(animated: true, completion: nil)
        }
        cancelalert.addAction(clokaction)
        self.present(cancelalert, animated: true, completion: nil)
    } //취소 alert
    
    
    @IBOutlet weak var newdiary: UITextView!
    

    @IBAction func save(_ sender: Any) {
        guard let diary = newdiary.text, diary.count>0 else{
            alert()
            return
        } //다이어리 아무것도 입력하지 않았을때 경고창 기능 사용

//        let new = Diary(content: newtext)
//        Diary.dummyDiary.append(new) //새로운 다이어리 더미리스트에 추가입력
        
        if let target = editTatget {
            target.content = diary
            DataStorage.shared.saveContext()
            NotificationCenter.default.post(name: NewViewController.eidtdiaryDidInsert, object: nil)
        } //편집 후 데이터 새롭게 저장 및 옵져버를 사용하여 알려준다
        else{
            DataStorage.shared.addnewdiary(diary)
            NotificationCenter.default.post(name: NewViewController.newdiaryDidInsert, object: nil) //노피피케이션
        }
        
        
      let savealert = UIAlertController(title: "SAVE", message: "저장됩니다.", preferredStyle: UIAlertController.Style.alert)

      let svokaction = UIAlertAction(title: "OK", style:.default){
        (action:UIAlertAction)-> Void in self.dismiss(animated: true, completion: nil)
       }
        savealert.addAction(svokaction)
    
        self.present(savealert, animated: true, completion: nil)
       
    } //새로운 다이어리 저장누르면 alert
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let diary = editTatget{
            navigationItem.title = "편집"
            newdiary.text = diary.content
            
        }
        else{
            navigationItem.title = "Today❓"
            newdiary.text = ""
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewViewController{
    static let newdiaryDidInsert = Notification.Name(rawValue: "newdiaryDidInsert")
    static let eidtdiaryDidInsert = Notification.Name(rawValue: "editdiaryDidInsert")
} //notificationcenter name 등록
