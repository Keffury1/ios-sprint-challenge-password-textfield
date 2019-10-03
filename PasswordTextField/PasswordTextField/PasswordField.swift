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
        
         // Text Field
        
        textField.layer.cornerRadius = 8.0
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 2.0
        textField.enablesReturnKeyAutomatically = true
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.bringSubviewToFront(showHideButton)
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textFieldMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -textFieldMargin).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true

         // Show Hide Button

        showHideButton.setImage(image1, for: .normal)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.addTarget(self, action: #selector(showHideTapped), for: .touchUpInside)
        textField.addSubview(showHideButton)
        showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -textFieldMargin).isActive = true
        showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor, constant: 0).isActive = true

        // Weak View

        weakView.backgroundColor = unusedColor
        weakView.layer.cornerRadius = 2.0
        weakView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weakView)
        weakView.heightAnchor.constraint(equalToConstant: 6.0).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true

        // Medium View

        mediumView.backgroundColor = unusedColor
        mediumView.layer.cornerRadius = 2.0
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mediumView)
        mediumView.heightAnchor.constraint(equalToConstant: 6.0).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true

        // Strong View

        strongView.backgroundColor = unusedColor
        strongView.layer.cornerRadius = 2.0
        strongView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strongView)
        strongView.heightAnchor.constraint(equalToConstant: 6.0).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [weakView, mediumView, strongView])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 2.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin).isActive = true
        

        // Strength Description Label
        strengthDescriptionLabel.text = "Too Weak"
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5.0).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
        strengthDescriptionLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50.0).isActive = true
        
        


    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // Method to determin the strength of the password
    
    func determineStrength(password: String) {
        
        if password.count == 0 {
            
            weakView.backgroundColor = unusedColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Too Weak"
            
        } else if password.count >= 1 && password.count <= 9 {
            
            weakView.backgroundColor = weakColor
            performFlare(view: weakView)
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Too Weak"

        } else if password.count >= 10 && password.count <= 19 {
            
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            performFlare(view: mediumView)
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Could be stronger"
            
        } else {
            
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            performFlare(view: strongView)
            strengthDescriptionLabel.text = "Strong password"
            
        }
        
        
    }
    
    
    // Method to perform flare on a certain view
    
    func performFlare(view: UIView) {
        func flare()   { view.transform = CGAffineTransform(scaleX: 1.6, y: 1.6) }
        func unflare() { view.transform = .identity }
      
        UIView.animate(withDuration: 0.3,
                     animations: { flare() },
                     completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
    }
    
    
    // Method to hide and unhide password
    
    @objc func showHideTapped() {
        if showHideButton.currentImage == image1 {
            showHideButton.setImage(image2, for: .normal)
            textField.isSecureTextEntry = false
        } else {
            showHideButton.setImage(image1, for: .normal)
            textField.isSecureTextEntry = true
        }
    }
    
    
    
    
}






extension PasswordField: UITextFieldDelegate {
    func textField(_ textFields: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        // Not sure if this is right
        password = newText
        determineStrength(password: password)
        
        return true
    }
}
