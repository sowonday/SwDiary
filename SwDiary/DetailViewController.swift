//
//  DetailViewController.swift
//  SwDiary
//
//  Created by 김소원 on 2021/02/18.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    var diary: Diary? //이전 메뉴에 있는 값 전달받기

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        return 1
    } //표시할 cell의 개수
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {//표시할 셀의 종류
        case 0://첫번째 셀
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell", for: indexPath)
            return cell
        default:
            fatalError() //더이상 리턴할 셀이 없을 때 경고메세지
        }
    }
    
    
    
}
