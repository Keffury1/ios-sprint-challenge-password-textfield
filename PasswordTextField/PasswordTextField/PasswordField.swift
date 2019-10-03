//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    // States of the password strength indicators
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    private let image1 = UIImage(named: "eyes-closed")
    private let image2 = UIImage(named: "eyes-open")
    
    
    func setup() {
        
        // Lay out your subviews here
        
        backgroundColor = bgColor
        
        // Title Label
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        // Text Field
        textField.layer.cornerRadius = 8.0
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 2.0
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textFieldMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: textFieldMargin).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
      
        // Show Hide Button
        showHideButton.setImage(image1, for: .normal)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        textField.addSubview(showHideButton)
        showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -10.0).isActive = true
        showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor, constant: 0).isActive = true
     

        // Weak View
        
        weakView.backgroundColor = unusedColor
        weakView.layer.cornerRadius = 2.0
        weakView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weakView)
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15.0).isActive = true
        weakView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: 6.0).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
       

        // Medium View
        
        mediumView.backgroundColor = unusedColor
        mediumView.layer.cornerRadius = 2.0
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mediumView)
        mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15.0).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: 6.0).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
      

        // Strong View
        
        strongView.backgroundColor = unusedColor
        strongView.layer.cornerRadius = 2.0
        strongView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strongView)
        strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15.0).isActive = true
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: 6.0).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
       

        // Strength Description Label
        strengthDescriptionLabel.text = "Too Weak"
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10.0).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
        strengthDescriptionLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50.0).isActive = true

       
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        return true
    }
}
