//
//  LoginViewController.swift
//  LoginSnippet
//
//  Created by Rostyslav Druzhchenko on 8/30/18.
//  Copyright © 2018 Rostyslav Druzhchenko. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Public properties
    
    // MARK: - Outlets
    
    @IBOutlet fileprivate(set) weak var emailView: FormView!
    @IBOutlet fileprivate(set) weak var passwordView: FormView!
    @IBOutlet fileprivate(set) weak var loginButton: UIButton!
    
    // MARK: - Private properties
    
    fileprivate var loginFormController: LoginFormController!
    
    // MARK: - View controller view's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        loginFormController = LoginFormController(emailFromView: emailView,
                                                  passwordFormView: passwordView,
                                                  loginButton:loginButton)
    }
        
    // MARK: - Navigation
    
    // MARK: - Actions
    
    // MARK: - Private API
}
