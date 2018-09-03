//
//  LoginFormController.swift
//  LoginSnippet
//
//  Created by Rostyslav Druzhchenko on 8/30/18.
//  Copyright © 2018 Rostyslav Druzhchenko. All rights reserved.
//

import UIKit

class LoginFormController: NSObject {

    // MARK: - Public properties
    
    var isLoginButtonEnabled: Bool {
        get {
            return loginButton.isEnabled
        }
    }
    
    var email: String {
        get {
            return ""
        }
    }
    
    var password: String {
        get {
            return ""
        }
    }
    
    var emailValidationState: ValidationState {
        get {
            return emailFromView.validationState
        }
    }
    
    var passwordValidationState: ValidationState {
        get {
            return passwordFormView.validationState
        }
    }
    
    // MARK: - Private
    
    fileprivate var emailFromView: FormView
    
    fileprivate var passwordFormView: FormView
    
    fileprivate var loginButton: UIButton
    
    // MARK: - Init
    
    init(emailFromView: FormView, passwordFormView: FormView, loginButton: UIButton) {
        self.emailFromView = emailFromView
        self.passwordFormView = passwordFormView
        self.loginButton = loginButton
        super.init()
        self.emailFromView.textField.delegate = self
        self.emailFromView.validator = EmailValidator()
        self.passwordFormView.textField.delegate = self
        self.passwordFormView.validator = PasswordValidator()
        updateLoginButtonEnabled()
    }

    // MARK: - Private
    
    func updateLoginButtonEnabled() {
        loginButton.isEnabled = emailValidationState == .correct && passwordValidationState == .correct
    }
}

extension LoginFormController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isEqual(emailFromView.textField) {
            emailFromView.validationState = emailFromView.validate() ? .correct : .wrong
            passwordFormView.textField.becomeFirstResponder()
        } else {
            passwordFormView.validationState = passwordFormView.validate() ? .correct : .wrong
            passwordFormView.textField.resignFirstResponder()
        }
        updateLoginButtonEnabled()
        return true
    }

}
