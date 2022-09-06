//
//  LocalizableViewController.swift
//  Sesac_Week9
//
//  Created by HeecheolYoon on 2022/09/06.
//

import UIKit
import CoreLocation
import MessageUI // 메일보내기, 디바이스에서만 가능, 아이폰에 메일계정이 등록되어있어야함. 만약 메일계정없다면 아이폰 설정쪽에서 등록해달라는 얼럿을 띄우는 방향으로 하면됨.

class LocalizableViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sampleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "navigation_title".localized
        searchBar.placeholder = "search_placeholder".localized
        inputTextField.placeholder = "main_age_placeholder".localized
        let buttonTitle = "common_cancel".localized
        sampleButton.setTitle(buttonTitle, for: .normal)
        myLabel.text = String(format: NSLocalizedString("introduce", comment: ""), arguments: ["희철"])
        
        inputTextField.text = "introduce".localized(with: "또또또또또또ㄸ또또또또또ㄸㅇ")
        
        CLLocationManager().requestWhenInUseAuthorization()
    }
    
    func sendMail() {
        //사용자가 메일 보낼 수 있는 상태인지, 메일계정이 등록되어이있는지 확인하는것
        if MFMailComposeViewController.canSendMail() {
            //띄우기
            
            let mail = MFMailComposeViewController()
            mail.setToRecipients(["kkll135@gmail.com"])//수신자
            mail.setSubject("내 앱 다이어리 문의사항")
            mail.mailComposeDelegate = self
            self.present(mail, animated: true)
            
        } else {
            //알럿으로 메일 등록해주거나, 내 이메일로 문의를 직접달라는 메세지 띄우기
            print("Alert")
        }
        
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            <#code#>
        case .saved:
            <#code#>
        case .sent:
            <#code#>
        case .failed:
            <#code#>
        }
        controller.dismiss(animated: true)
    }
    
}
