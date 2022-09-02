//
//  GCDViewController.swift
//  Sesac_Week9
//
//  Created by HeecheolYoon on 2022/09/02.
//

import UIKit

class GCDViewController: UIViewController {

    let url1 = URL(string: "https://apod.nasa.gov/apod/image/2201/OrionStarFree3_Harbison_5000.jpg")!
    let url2 = URL(string: "https://apod.nasa.gov/apod/image/2112/M3Leonard_Bartlett_3843.jpg")!
    let url3 = URL(string: "https://apod.nasa.gov/apod/image/2112/LeonardMeteor_Poole_2250.jpg")!

    
    @IBOutlet weak var view1: UIImageView!
    @IBOutlet weak var view2: UIImageView!
    @IBOutlet weak var view3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func serialSync(_ sender: Any) {
        for i in 1...100 {
            print(i, terminator: " ")
        }
        DispatchQueue.main.sync {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        print("END")
    }
    @IBAction func serialAsync(_ sender: Any) {
        DispatchQueue.main.async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        for i in 101...200 {
            print(i, terminator: " ")
        }
        print("END")
    }
    @IBAction func globalSync(_ sender: Any) {
        DispatchQueue.global().sync {
            for i in 1...100 {
                print(i, terminator: " ")
                
            }
        }
        for i in 101...200 {
            print(i, terminator: " ")
        }
        print("END")
    }
    @IBAction func globalAsync(_ sender: Any) {
        print("START \(Thread.isMainThread)")
        
            for i in 1...100 {
                DispatchQueue.global().async {
                    print(i, terminator: " ")

                }
                
            }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        print("END \(Thread.isMainThread)")
    }
    @IBAction func qos(_ sender: Any) {
        
        let customQueue = DispatchQueue(label: "heeQueue", qos: .userInteractive, attributes: .concurrent)

        for i in 1...100 {
            DispatchQueue.global(qos: .background).async {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            DispatchQueue.global(qos: .userInteractive).async {
                print(i, terminator: " ")
            }
        }
        for i in 201...300 {
            DispatchQueue.global(qos: .utility).async {
                print(i, terminator: " ")
            }
        }

        
    }
    @IBAction func dispatchGroup(_ sender: Any) {
        //아래의 상태로 프린트하면 끝이 먼저 출력됨
//        DispatchQueue.global().async {
//            for i in 1...100 {
//                print(i, terminator: " ")
//            }
//        }
//        DispatchQueue.global().async {
//            for i in 101...200 {
//                print(i, terminator: " ")
//            }
//        }
//        DispatchQueue.global().async {
//            for i in 201...300 {
//                print(i, terminator: " ")
//            }
//        }
//        print("꾸ㅡㅌ")
        
        //그룹으로 만들어줌
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        DispatchQueue.global().async(group: group) {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        
        group.notify(queue: .main) {
            print("끝")
        }
    }
    func request(url: URL, completionHandler: @escaping (UIImage?) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completionHandler(UIImage(systemName: "star"))
                return
            }
            
            let image = UIImage(data: data)
            completionHandler(image)
            
        }.resume()
    }
    @IBAction func dispatchGroupNASA(_ sender: Any) {
//
//        request(url: url1) { image in
//            print("1")
//            self.request(url: self.url2) { image in
//                print("2")
//
//                self.request(url: self.url3) { image in
//                    print("3")
//                }
//            }
//        }
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url1) { image in
                print("1")
            }
        }
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url2) { image in
                print("2")
            }
        }
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url3) { image in
                print("3")
            }
        }
        group.notify(queue: .main) {
            print("완료")
        }
    }
    @IBAction func enterLeave(_ sender: Any) {
        let group = DispatchGroup()
        var imageList: [UIImage] = []
        
        group.enter()
        request(url: url1) { image in
            imageList.append(image!)
            group.leave()
        }
        
        group.enter()
        request(url: url2) { image in
            
            imageList.append(image!)
            group.leave()
        }
        
        group.enter()
        request(url: url3) { image in
            imageList.append(image!)
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.view1.image = imageList[0]
            self.view2.image = imageList[1]
            self.view3.image = imageList[2]
        }
        
    }
    @IBAction func raceCondition(_ sender: Any) {
        let group = DispatchGroup()
        
        var nickname = "고래밥"
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "고래밥"
            print("first: \(nickname)")
        }
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "dkdk"
            print("second: \(nickname)")
        }
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "aaaa"
            print("third: \(nickname)")
        }
        group.notify(queue: .main) {
            print("result: \(nickname)")
        }
    }
}
