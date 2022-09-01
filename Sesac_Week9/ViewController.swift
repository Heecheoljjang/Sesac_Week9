//
//  ViewController.swift
//  Sesac_Week9
//
//  Created by HeecheolYoon on 2022/08/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = PersonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        let example = User("하이")
//        example.value = "바보"
//        example.bind { name in
//            print("이름이 \(name)로 바뀜")
//        }
//
//        let eaa = User([123,124])
//        eaa.value = [12,3]
//        eaa.bind { arr in
//            print(arr)
//        }
//
//        viewModel.fetchPerson(query: "kim")
//
//        viewModel.list.bind { person in //여기 클로저구문이 리스너에 들어가있음. bind를 실행해야 리스너에 들어감
//            print("person \(person)")
//            print("viewcontroller bind")
//            self.tableView.reloadData()
//        }

    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let data = viewModel.cellForRowAt(at: indexPath)
        
        cell.textLabel?.text = data.name
        cell.detailTextLabel?.text = data.knownForDepartment
        
        return cell
    }
    
}
