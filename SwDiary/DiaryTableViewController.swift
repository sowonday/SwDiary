//
//  DiaryTableViewController.swift
//  SwDiary
//
//  Created by 김소원 on 2021/02/17.
//

import UIKit

class DiaryTableViewController: UITableViewController {
    
    let date: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .long
        df.timeStyle = .medium
        df.locale = Locale(identifier: "ko-kr")
           return df
       }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        DataStorage.shared.fetchDiary() //배열이 데이터로 채워짐
        tableView.reloadData() //배열에 저장된 데이터로 테이블뷰 업데이트
    }
    
    var token: NSObjectProtocol? //token으로 observer해제
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell){
            if let vc = segue.destination as? DetailViewController{
                vc.diary = DataStorage.shared.diaryList[indexPath.row]
            } // segue로 이전 화면에 있는 메모를 보내줌
            //segue가 연결된 화면을 생성하고 화면을 전환하기 직전에 호출
            // indexpath로 몇번째 cell인지 계산한다
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NewViewController.newdiaryDidInsert, object: nil, queue: OperationQueue.main) {[weak self] (noti) in
            self?.tableView.reloadData()
        } //observer추가

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
      
        return DataStorage.shared.diaryList.count
    } //dummyDiary 카운트
        
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let target = DataStorage.shared.diaryList[indexPath.row]
        cell.textLabel?.text = target.content
        cell.detailTextLabel?.text = date.string(for: target.datecontent)
        
        return cell
        }
        
        
       


    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true //편집기능 활성화
    }
    //편집스타일 지정
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            let target = DataStorage.shared.diaryList[indexPath.row]
            DataStorage.shared.trashdairy(target) //데이터베이스에서 메모삭제
            DataStorage.shared.diaryList.remove(at: indexPath.row) //배열에서 삭제
            
            tableView.deleteRows(at: [indexPath], with: .fade) //테이블뷰에서 셀을 삭제
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


    }
