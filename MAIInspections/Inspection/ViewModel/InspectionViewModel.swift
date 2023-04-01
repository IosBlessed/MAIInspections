//
//  InspectionViewModel.swift
//  MAIInspections
//
//  Created by Никита Данилович on 27.03.2023.
//

import Foundation

final class InspectionViewModel:InspectionViewModelProtocol{
    
    weak var inspectionView: InspectionViewProtocol?
    
    func getViolatorsFromLocalStorage() {
        
        let violators = APIDBViolators.shared.extractViolatorsFromLocalDB()
        
        self.inspectionView?.updateTableView(with: violators)
        
    }
    func processViolatorsFromLocalStorage(with carDetails:String, from violatorsArray:[Violator]) {
        
        let uppercasedCarNumber = carDetails.uppercased()
        
        var filteredArray:[Violator] = []
        
        if uppercasedCarNumber != ""{
            filteredArray = violatorsArray.filter({
                
                violator in
                
                violator.carNumber!.contains(uppercasedCarNumber)
            })
        }else{
            
            filteredArray = violatorsArray
            
        }
        
        self.inspectionView?.updateTableView(with: filteredArray)
        
    }
    
    func processPresentationOfViewController() {
        
       self.inspectionView?.presentViewController()
        
    }
    
}

