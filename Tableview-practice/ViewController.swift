//
//  ViewController.swift
//  Tableview-practice
//
//  Created by MrsBok on 2021/02/18.
//

import UIKit


class ExpandCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // 테이블뷰의 구조를 먼저 잡는 것이 중요하다 -> 나중에 하는 어려운 작업에 대한 대응을 쉽게 할 수 있다.
        // 필요한 텍스트가 포함.
        // 셀의 expand 한 상태를 생각해두어야함.
    
    // Model
    struct ExpandDataModel {
        var description: String
        var isExpand: Bool
    }
    
    var dataModels: [ExpandDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textArray = ["short Text",
                         "long long long long long long long long long long long long long long long long long long long long long",
                         "short Text",
                         "long long long long long long long long long long long long long long long long long long long long long",
                         "short Text",
                         "long long long long long long long long long long long long long long long long long long long long long"]
        
        // 정리!
        for (_, value) in textArray.enumerated() {
            dataModels.append(ExpandDataModel.init(description: value, isExpand: false))
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ExpandCell else { return UITableViewCell() }
        cell.descriptionLabel.text = dataModels[indexPath.row].description
        
        if dataModels[indexPath.row].isExpand == true {
            // 정리!
            // numberOfLines의 값이 1이면 한 줄, 2이면 두 줄, 3이면 세 줄, ---> 0 이면 다 표현한다는 뜻.
            cell.descriptionLabel.numberOfLines = 0
        } else {
            cell.descriptionLabel.numberOfLines = 1
        }
        
        
        cell.selectionStyle = .none
        
        print("~~~> cellForRowAt")
        return cell
    }
    
    // 애니메이션을 주었을때 각 셀이 다양한 높이로 대응해야하는 상황 1 -> 정확한 높이를 주어야 하는 상황
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return isExpand = 150 : 50
    //    }
    
    // 애니메이션을 주었을때 각 셀이 다양한 높이로 대응해야하는 상황 2 -> 주어진 컨텐츠에 따라 높이가 대응되어야 하는 상황
    // -> func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { tableView.reloadData() } --> 어느정도 해결
    // 애니메이션을 주었을때 각 셀이 다양한 높이로 대응해야하는 상황 3 -> 2가 안될땐,
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 내코드
        //        if dataModels[indexPath.row].isExpand == false {
        //            dataModels[indexPath.row].isExpand = true
        //        } else {
        //            dataModels[indexPath.row].isExpand = false
        //        }
        
        // 강의코드
        dataModels[indexPath.row].isExpand = !dataModels[indexPath.row].isExpand
        
        
        // 3. 어느정도 해결
        //        tableView.estimatedSectionHeaderHeight = 0
        //        tableView.estimatedSectionFooterHeight = 0
        
        // 4. 애니메이션 효과 없애는 방법 -> 거의 확실히 해결
        //        UIView.setAnimationsEnabled(false)
        //        tableView.reloadRows(at: [indexPath], with: .none)
        //        UIView.setAnimationsEnabled(true)
        
        
        // 테이블 갱신
        // 테이블 전체 데이터를 바꿀때
        //        tableView.reloadData()
        
        // 원하는 row의 데이터만 바꿀때
        //        tableView.reloadRows(at: [indexPath], with: .none)
        
        UIView.setAnimationsEnabled(false)
        tableView.reloadRows(at: [indexPath], with: .none)
        UIView.setAnimationsEnabled(true)
        print("~~~> didSelectRowAt")
    }
    
    
    
}

