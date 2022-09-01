//
//  Sample.swift
//  Sesac_Week9
//
//  Created by HeecheolYoon on 2022/09/01.
//

import Foundation

class User<T> {
    
    private var listener: ((T) -> ())?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ completionHandler: @escaping (T) -> ()) {
        completionHandler(value)
        listener = completionHandler
    }
    
}
