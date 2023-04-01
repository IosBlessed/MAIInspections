//
//  AddViolatorViewModel.swift
//  MAIInspections
//
//  Created by Никита Данилович on 31.03.2023.
//

import Foundation

typealias ViolatorTextFieldDetails = [String:String]

protocol AddViolatorViewModelProtocol:AnyObject{
    
    var inspectionViewModel:InspectionViewModelProtocol? {get set }
    
    var addViolatorView:AddViolatorViewProtocol? {get set}
    
    func processTextFieldsAndImage(with details:ViolatorTextFieldDetails, imageState:ViolatorImageSelectionState)
    
    func addViolatorToLocalStorage(add violator:ViolatorTextFieldDetails)
    
}

protocol AddViolatorViewProtocol:AnyObject{
    
    var addViolatorViewModel:AddViolatorViewModelProtocol? {get set}
    
    func presentRootViewController(animated:Bool)
    
    func uploadViolatorToTheCoreData()
    
}

class AddViolatorViewModel:AddViolatorViewModelProtocol{
    
    weak var inspectionViewModel: InspectionViewModelProtocol?
    
    weak var addViolatorView: AddViolatorViewProtocol?
    
    func addViolatorToLocalStorage(add violator: ViolatorTextFieldDetails) {
        
        let personImagePath = violator[ViolatorDetails.personImagePath.rawValue] ?? "accountIceon.png"
        
        let firstname = violator[ViolatorDetails.firstname.rawValue] ?? "FirstName"
        
        let secondname = violator[ViolatorDetails.secondname.rawValue] ?? "SecondName"
        
        let idnp = violator[ViolatorDetails.idnp.rawValue] ?? "IDNP"
        
        let dateOfBirth = violator[ViolatorDetails.dateOfBirth.rawValue] ?? "DateOfBirth"
        
        let carNumber = violator[ViolatorDetails.carNumber.rawValue]?.uppercased() ?? "CarNumber"
        
        APIDBViolators.shared.addViolatorToLocalStorage(
            personImagePath: personImagePath,
            firstName: firstname,
            secondName: secondname,
            dateOfBirth: dateOfBirth,
            idnp: idnp,
            carNumber: carNumber
        )
        self.inspectionViewModel?.getViolatorsFromLocalStorage()
        
    }
    
    func processTextFieldsAndImage(with details: ViolatorTextFieldDetails, imageState:ViolatorImageSelectionState) {
        
        guard imageState == .selected else {
            // show alert message for image of violator
            return
        }
        
        let emptyFields = details.filter({
            key, value in
            value == ""
        })
        
        guard emptyFields.isEmpty else{
            
            //show alert message of empty text fields in AddViolatorViewController
            
            return
        }
        self.addViolatorView?.uploadViolatorToTheCoreData()
        
        
    }
    
}
