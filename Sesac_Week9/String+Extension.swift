//
//  String+Extension.swift
//  Sesac_Week9
//
//  Created by HeecheolYoon on 2022/09/06.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(with: String) -> String {
        return String(format: self.localized, with)
    }
    
    func localized(number: String) -> String {
        return String(format: self.localized, number)
    }
}
