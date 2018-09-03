//
//  HelloViewController.swift
//  LoginSnippet
//
//  Created by Rostyslav Druzhchenko on 8/30/18.
//  Copyright © 2018 Rostyslav Druzhchenko. All rights reserved.
//

import UIKit

class HelloViewController: UIViewController {

    // MARK: - Public properties
    
    // MARK: - Outlets
    
    // MARK: - Private properties
    
    // MARK: - View controller view's lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    // MARK: - Navigation
    
    // MARK: - Actions
    
    // MARK: - Private API
}
