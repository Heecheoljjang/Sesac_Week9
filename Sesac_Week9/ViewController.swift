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
    
    var list: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        LottoAPIManager.requestLotto(drwNo: 1000) { lotto, error in
            guard let lotto = lotto else {
                return
            }
            self.resultLabel.text = lotto.drwNoDate
        }
        
        PersonAPIManager.requestPerson(query: "kim") { person, error in
            guard let person = person else {
                return
            }
            self.list = person
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list == nil ? 0 : list!.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = list?.results[indexPath.row].name
        cell.detailTextLabel?.text = list?.results[indexPath.row].knownForDepartment
        
        return cell
    }
    
}
