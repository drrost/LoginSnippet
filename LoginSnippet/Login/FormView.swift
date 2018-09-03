//
//  FormView.swift
//  testLogin
//
//  Created by Rostyslav Druzhchenko on 8/28/18.
//  Copyright © 2018 Rostyslav Druzhchenko. All rights reserved.
//

import UIKit

class FormView: UIView {
    
    // MARK: - Public properties
    
    var validator: Validator?
    
    var validationState: ValidationState = .normal {
        didSet {
            updateValidationState()
        }
    }
    
    var errorText: String {
        set {
            errorLabel.text = newValue
        }
        get {
            return errorLabel.text ?? ""
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet fileprivate(set) weak var textFieldContainerView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet fileprivate(set) weak var errorLabel: UILabel!

    // MARK: - Private properties
    
    weak var validationStateIndicatorView: UIView!
    fileprivate var normalStateColor = UIColor.lightGray
    fileprivate var wrongStateColor = UIColor.red
    fileprivate var correctStateColor = UIColor.green

    // MARK: - From base classes

    override func awakeFromNib() {
        super.awakeFromNib()
        errorLabel.textColor = .red
        
        validationStateIndicatorView = textFieldContainerView
        
        textField.becomeFirstResponder()
        textFieldContainerView.layer.borderWidth = 1.0
        textFieldContainerView.layer.cornerRadius = 3.0
        
        validationState = .normal
    }
    
    // MARK: - Actions
    
    // MARK: - Public API
    
    func validate() -> Bool {
        guard let validator = self.validator else {
            return false
        }
        
        return validator.validate(text: textField.text ?? "")
    }
    
    // MARK: - Private API
    
    func updateValidationState() {
        guard validationStateIndicatorView != nil else { return }
        
        switch validationState {
        case .normal:
            validationStateIndicatorView.layer.borderColor = normalStateColor.cgColor
        case .wrong:
            validationStateIndicatorView.layer.borderColor = wrongStateColor.cgColor
        case .correct:
            validationStateIndicatorView.layer.borderColor = correctStateColor.cgColor
        }
    }

}
