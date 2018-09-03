//
//  Validator.swift
//  testLogin
//
//  Created by Rostyslav Druzhchenko on 8/24/18.
//  Copyright © 2018 Rostyslav Druzhchenko. All rights reserved.
//

import Foundation

enum ValidationState {
    case normal
    case wrong
    case correct
}

protocol Validator {
    
    func validate(text: String) -> Bool
}
