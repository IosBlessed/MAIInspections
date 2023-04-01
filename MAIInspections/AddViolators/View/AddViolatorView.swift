//
//  AddViolatorView.swift
//  MAIInspections
//
//  Created by Никита Данилович on 30.03.2023.
//

import Foundation
import UIKit

enum ViolatorDetails:String{
    case personImagePath = "personImagePath"
    case firstname = "firstname"
    case secondname = "secondname"
    case idnp = "idnp"
    case dateOfBirth = "dateOfBirth"
    case carNumber = "carNumber"
}

final class AddViolatorUserView:UIView{
    
    
    private func setupViewConstraints(){
        
        // Main View constraints section
        mainViewView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        
        mainViewView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        
        mainViewView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        
        mainViewView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -120).isActive = true
        
        //Inside Main View constraints sections
        
        //ImagePickerButton constraints section
        
        selectImageButton.topAnchor.constraint(equalTo: mainViewView.topAnchor, constant: 100).isActive = true
        
        selectImageButton.leftAnchor.constraint(equalTo: mainViewView.leftAnchor, constant: 20).isActive = true
        
        selectImageButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        selectImageButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        //StackView with TextFields constraints section
        
        stackViewTextFields.topAnchor.constraint(equalTo: selectImageButton.topAnchor).isActive = true
        
        stackViewTextFields.leftAnchor.constraint(equalTo: selectImageButton.rightAnchor, constant: 15).isActive = true
        
        stackViewTextFields.rightAnchor.constraint(equalTo: mainViewView.rightAnchor, constant: -10).isActive = true
        
        stackViewTextFields.bottomAnchor.constraint(equalTo: mainViewView.bottomAnchor, constant: -250).isActive = true
        
        // Create Violator button constraints section
        
        createViolatorButton.topAnchor.constraint(equalTo: stackViewTextFields.bottomAnchor, constant: 50).isActive = true
        
        createViolatorButton.leftAnchor.constraint(equalTo: mainViewView.leftAnchor, constant: 100).isActive = true
        
        createViolatorButton.rightAnchor.constraint(equalTo: mainViewView.rightAnchor, constant: -100).isActive = true
        
        createViolatorButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func generateCustomUITextField(placeholder placeholderText:String) -> UITextField{
        
        let textField = UITextField(frame: .zero)
        
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [
                NSAttributedString.Key.foregroundColor:UIColor.black
            ]
        )
        
        textField.tintColor = .black
        textField.textColor = .black
        
        textField.borderStyle = .line
        
        textField.textAlignment = .center
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
        
        textField.backgroundColor = UIColor(displayP3Red: 51/255, green: 102/255, blue: 153/255, alpha: 1.0)
        
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        
        return textField
    }
    
    private lazy var mainViewView:UIView = {
        
        let mainView = UIView()
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.layer.borderWidth = 2.0
        mainView.layer.borderColor = UIColor.yellow.cgColor
        
        mainView.layer.masksToBounds = true
        mainView.layer.cornerRadius = 10
        
        return mainView
    }()
    
    
    lazy var selectImageButton:UIButton = {
      
        let selectionButton = UIButton(type: .system)
        
        selectionButton.translatesAutoresizingMaskIntoConstraints = false
        
        let backgroundImage = UIImage(named: "accountIcon.png")
    
        selectionButton.setBackgroundImage(backgroundImage, for: .normal)
        
        selectionButton.backgroundColor = UIColor(displayP3Red: 51/255, green: 102/255, blue: 153/255, alpha: 1.0)

        
        selectionButton.layer.masksToBounds = true
        selectionButton.layer.cornerRadius = 10
      
        return selectionButton
    }()
    
   private lazy var firstNameTextField:UITextField = {
        
       let placeholder = "First name..."
       
       let textField = generateCustomUITextField(placeholder: placeholder)
        
       return textField
    }()
    
    private lazy var secondNameTextField:UITextField = {
        
        let placeholder = "Second name..."
        
        let textField = generateCustomUITextField(placeholder: placeholder)
        
        return textField
    }()
    
    private lazy var idnpTextField:UITextField = {
        
        let placeholder = "Idnp..."
        
        let textField = generateCustomUITextField(placeholder: placeholder)
        
        return textField
    }()
    
    private lazy var carNumberTextField:UITextField = {
        
        let placeholder = "Car number..."
        
        let textField = generateCustomUITextField(placeholder: placeholder)
        
        return textField
    }()
    
    private lazy var dateOfBirthTextField:UITextField = {
        
        let placeholder = "Date of birth..."
        
        let textField = generateCustomUITextField(placeholder: placeholder)
        
        return textField
    }()
    
   private lazy var stackViewTextFields: UIStackView = {
        
       let stackView = UIStackView()
        
       stackView.translatesAutoresizingMaskIntoConstraints = false
        
       stackView.contentMode = .scaleAspectFill
       
       stackView.spacing = 10
        
       stackView.axis = .vertical
       stackView.distribution = .fillEqually
        
       stackView.backgroundColor = .clear
        
        
       stackView.addArrangedSubview(firstNameTextField)
       stackView.addArrangedSubview(secondNameTextField)
       stackView.addArrangedSubview(idnpTextField)
       stackView.addArrangedSubview(dateOfBirthTextField)
       stackView.addArrangedSubview(carNumberTextField)
        
        
       return stackView
    }()
    
    lazy var createViolatorButton:UIButton = {
        
        let button = UIButton(type: .system)
        
        let title = "Create"
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle(title, for: .normal)
        
        button.titleLabel?.attributedText = NSAttributedString(
            string: title,
            attributes:[
            NSAttributedString.Key.font:UIFont.systemFont(ofSize: 23)
        ])
        
        
        button.tintColor = .black
        button.backgroundColor = UIColor(displayP3Red: 51/255, green: 102/255, blue: 153/255, alpha: 1.0)
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        
        
        return button
    }()
    
    func inititalSetupView(){
        
        self.addSubview(mainViewView)
        
        mainViewView.addSubview(selectImageButton)
        
        mainViewView.addSubview(stackViewTextFields)
        
        mainViewView.addSubview(createViolatorButton)
        
        setupViewConstraints()

    }
    
    func getViolatorTextFieldData(with data:ViolatorDetails) -> String{
        
        switch data{
        case .personImagePath:
            return "accountIcon.png"
        case .firstname:
            return firstNameTextField.text ?? ""
           
        case .secondname:
            return secondNameTextField.text ?? ""
           
        case .idnp:
            return idnpTextField.text ?? ""
           
        case .dateOfBirth:
            return dateOfBirthTextField.text ?? ""
           
        case .carNumber:
            return carNumberTextField.text ?? ""
    
        }
        
    }
    
    
}


