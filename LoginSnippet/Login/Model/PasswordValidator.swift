//
//  PasswordValidator.swift
//  testLogin
//
//  Created by Rostyslav Druzhchenko on 8/24/18.
//  Copyright © 2018 Rostyslav Druzhchenko. All rights reserved.
//

import Foundation

class PasswordValidator: Validator {
    
    func validate(text: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z0-9!@#$%^&*()\\-_=+{};:,<.>\\/?\\[\\]]{8,}")
        return passwordTest.evaluate(with: text)
    }
}
