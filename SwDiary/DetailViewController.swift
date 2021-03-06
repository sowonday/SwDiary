//
//  DetailViewController.swift
//  SwDiary
//
//  Created by 김소원 on 2021/02/18.
//
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var uptableview: UITableView!
    var diary: Diary? //이전 메뉴에 있는 값 전달받기
    
    let date: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .long
        df.timeStyle = .medium
        df.locale = Locale(identifier: "ko-kr")
           return df
       }()
    
    
    @IBAction func deleteDiary(_ sender: Any) {
    
        
        
        let trashalert = UIAlertController(title: "정말로 삭제하시겠습니까?", message:"삭제됩니다.", preferredStyle: UIAlertController.Style.alert)
        
        let trashaction = UIAlertAction(title: "OK", style: .destructive) {[weak self] (action) in
            DataStorage.shared.trashdairy(self?.diary)
            //화면을 닫고 이전화면으로 가려면 화면을 팝해야한다.
            self?.navigationController?.popViewController(animated: true)
            
        }
        trashalert.addAction(trashaction)
        self.present(trashalert, animated: true, completion: nil)
    } //삭제 기능
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.children.first as? NewViewController{
            vc.editTatget = diary
        }
    }
    
    var token : NSObjectProtocol?
    deinit {
        if let token = token{
            NotificationCenter.default.removeObserver(token)
        }
    }
    
   
   
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(forName: NewViewController.eidtdiaryDidInsert, object: nil, queue: OperationQueue.main, using:{ [weak self] (noti) in
            self?.uptableview.reloadData()
        })
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

extension DetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    } //표시할 cell의 개수
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 누르면 다이어리내용을 볼 수 있음. 첫줄에는 다이어리 내용, 두번째 줄에는 날짜
        switch indexPath.row {//표시할 셀의 종류
        case 0://첫번째 셀
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell", for: indexPath)
            cell.textLabel?.text = diary?.content //데이터 받기
            
            return cell
        case 1: //두번째 셀
            let cell = tableView.dequeueReusableCell(withIdentifier: "datecell", for: indexPath)
            cell.textLabel?.text = date.string(for: diary?.datecontent)
            return cell
            
        default:
            fatalError() //더이상 리턴할 셀이 없을 때 경고메세지
        }
    }
    
    
    
}
