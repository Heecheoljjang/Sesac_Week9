//
//  PersonViewModel.swift
//  Sesac_Week9
//
//  Created by HeecheolYoon on 2022/08/31.
//

import Foundation

//모델을 통로역할을 하는 뷰모델이 담당
//전달만 하는 입장이기때문에 리로드같이 뷰와 연관된 코드는 지움
class PersonViewModel {
    
    //양방향으로 흐를수있게 옵저버블로 선언
    var list: Observable<Person> = Observable(Person(page: 0, totalPages: 0, totalResults: 0, results: []))
    
    func fetchPerson(query: String) {
        print("fetchPerson")
        PersonAPIManager.requestPerson(query: "kim") { person, error in
            guard let person = person else {
                return
            }
            self.list.value = person
        }
    }
    
    //찾기 쉽게 만든 변수명이지 바꿔도 ㄱㅊ
    var numberOfRowsInSection: Int {
        //리스트가 Person객체가 아니라 한번 담겨있음.그래서 한 칸 더 들어가서 value에서 results로 접근
        return list.value.results.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> Result {
        return list.value.results[indexPath.row]
    }
    
}
