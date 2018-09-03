//
//  LoginFromTests.swift
//  LoginSnippetTests
//
//  Created by Rostyslav Druzhchenko on 8/30/18.
//  Copyright © 2018 Rostyslav Druzhchenko. All rights reserved.
//

import XCTest

@testable import LoginSnippet

class LoginFromTests: XCTestCase {
    
    // MARK: - Private variables
    
    var loginFromController: LoginFormController!
    
    var emaiFormView: FormView!
    var passwordFormView: FormView!
    var loginButton: UIButton!
    
    var emaiTextFieldMock: UITextFieldMock!
    var passwordTextFieldMock: UITextFieldMock!
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        emaiFormView = FormView()
        emaiTextFieldMock = UITextFieldMock()
        emaiFormView.textField = emaiTextFieldMock
        passwordFormView = FormView()
        passwordTextFieldMock = UITextFieldMock()
        passwordFormView.textField = passwordTextFieldMock
        loginButton = UIButton()
        loginFromController = LoginFormController(emailFromView: emaiFormView,
                                                  passwordFormView: passwordFormView,
                                                  loginButton: loginButton)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Unit tests
    
    func testCase1() {
        // Land to login screen
        
        // Check fields are empty
        XCTAssertTrue(loginFromController.email.count == 0)
        XCTAssertTrue(loginFromController.password.count == 0)
        
        // Check fields are gray
        XCTAssertTrue(loginFromController.emailValidationState == .normal)
        XCTAssertTrue(loginFromController.passwordValidationState == .normal)
        
        // Check login button disabled
        XCTAssertFalse(loginFromController.isLoginButtonEnabled)
    }
    
    func testCase2() {
        // Type "aaa" for email
        emaiTextFieldMock.activate()
        emaiTextFieldMock.typeSymbol(symbol: "a")
        XCTAssertTrue(emaiTextFieldMock.isFirstResponder)
        emaiTextFieldMock.typeSymbol(symbol: "a")
        emaiTextFieldMock.typeSymbol(symbol: "a")
        XCTAssertTrue(emaiTextFieldMock.text == "aaa")
        
        // Tap "Next"
        emaiTextFieldMock.tapReturn()
        XCTAssertTrue(passwordTextFieldMock.isFirstResponder)
        XCTAssertTrue(loginFromController.emailValidationState == .wrong)
        XCTAssertFalse(loginFromController.isLoginButtonEnabled)

        // Type "bbb" for password
        passwordTextFieldMock.typeSymbol(symbol: "b")
        passwordTextFieldMock.typeSymbol(symbol: "b")
        passwordTextFieldMock.typeSymbol(symbol: "b")
        XCTAssertTrue(passwordTextFieldMock.text == "bbb")
        XCTAssertTrue(passwordTextFieldMock.isFirstResponder)
        
        // Tap "Done"
        passwordTextFieldMock.tapReturn()
        XCTAssertTrue(loginFromController.passwordValidationState == .wrong)
        XCTAssertFalse(loginFromController.isLoginButtonEnabled)
    }
    
    func testCase3() {
        // Tap on `email` text field
        emaiTextFieldMock.activate()
        XCTAssertTrue(emaiTextFieldMock.isFirstResponder)
        XCTAssertFalse(passwordTextFieldMock.isFirstResponder)
        
        // Tap "Next"
        emaiTextFieldMock.tapReturn()
        XCTAssertTrue(loginFromController.emailValidationState == .wrong)
        XCTAssertFalse(emaiTextFieldMock.isFirstResponder)
        XCTAssertTrue(passwordTextFieldMock.isFirstResponder)
        XCTAssertTrue(loginFromController.passwordValidationState == .normal)
        XCTAssertFalse(loginFromController.isLoginButtonEnabled)
        
        // Tap "Done"
        passwordTextFieldMock.tapReturn()
        XCTAssertTrue(loginFromController.emailValidationState == .wrong)
        XCTAssertFalse(emaiTextFieldMock.isFirstResponder)
        XCTAssertTrue(loginFromController.passwordValidationState == .wrong)
        XCTAssertFalse(passwordTextFieldMock.isFirstResponder)
        XCTAssertFalse(loginFromController.isLoginButtonEnabled)
    }
    
    func testCase4() {
        // Type correct email
        emaiTextFieldMock.activate()
        emaiTextFieldMock.typeSymbol(symbol: "some@some.com")
        
        // Tap "Next"
        emaiTextFieldMock.tapReturn()
        XCTAssertTrue(loginFromController.emailValidationState == .correct)
        XCTAssertTrue(loginFromController.passwordValidationState == .normal)
        XCTAssertTrue(passwordTextFieldMock.isFirstResponder)
        XCTAssertFalse(loginFromController.isLoginButtonEnabled)
        
        // Type correct password
        passwordTextFieldMock.typeSymbol(symbol: "12345678")
        passwordTextFieldMock.tapReturn()
        XCTAssertTrue(loginFromController.emailValidationState == .correct)
        XCTAssertTrue(loginFromController.passwordValidationState == .correct)
        XCTAssertFalse(passwordTextFieldMock.isFirstResponder)
        XCTAssertTrue(loginFromController.isLoginButtonEnabled)
    }
    
    // MARK: - Private API
    
}

class UITextFieldMock : UITextField {
    
    // MARK: - Public API
    
    func activate() {
        _ = becomeFirstResponder()
    }
    
    func typeSymbol(symbol: String) {
        text = (text ?? "") + symbol
        _isFirstResponder = true
    }
    
    func tapReturn() {
        _ = delegate?.textFieldShouldReturn!(self)
    }
    
    // MARK: - Private properties
    
    fileprivate var _isFirstResponder: Bool = false
    
    fileprivate static var lastActiveTextField: UITextFieldMock!
    
    // MARK: - Overrriden
    
    override var isFirstResponder: Bool {
        get {
            return _isFirstResponder
        }
        set {
            _isFirstResponder = newValue
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        if UITextFieldMock.lastActiveTextField != nil {
            UITextFieldMock.lastActiveTextField.isFirstResponder = false
        }
        UITextFieldMock.lastActiveTextField = self
        self.isFirstResponder = true
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        _isFirstResponder = false
        return true
    }

}
