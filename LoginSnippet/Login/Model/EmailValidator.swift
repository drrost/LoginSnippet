//
//  EmailValidator.swift
//  testLogin
//
//  Created by Rostyslav Druzhchenko on 8/24/18.
//  Copyright © 2018 Rostyslav Druzhchenko. All rights reserved.
//

import Foundation

class EmailValidator: Validator {
    
    func validate(text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: text)
    }

}
