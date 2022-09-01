//
//  Observable.swift
//  Sesac_Week9
//
//  Created by HeecheolYoon on 2022/08/31.
//

import Foundation

//양방향 바인딩
//didset같은걸 데이터바인딩이라고함. 데이터가 달라지면 코드실행 같은 느낌인듯 -> 한방향으로 흐름
class Observable<T> {
 
    //어떤 함수가 들어갈진 모르지만 매개변수로 지정
    private var listener: ((T) -> ())?
    
    var value: T {
        didSet {
            print("didSet", value)
            listener?(value) // 데이터 전달. 함수호출연산자를 didset안에 담겨있음
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    //외부에서 들어오는 기능을 한 번 실행시키고 앞으로도 들어오게끔 변수에 담아두고 변수가 바뀌면 didset에 의해 실행
    func bind(_ closure: @escaping (T) -> ()) {
        print("bind")
        closure(value) //최초 실행만 담당
        listener = closure // 리스너에 업데이트 -> 리로드하는 메서드를 갖게됨
    }
}
