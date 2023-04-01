//
//  InspectionProtocols.swift
//  MAIInspections
//
//  Created by Никита Данилович on 30.03.2023.
//

protocol InspectionViewModelProtocol:AnyObject{
    
    var inspectionView:InspectionViewProtocol? {get set}
    
    func getViolatorsFromLocalStorage()
    
    func processViolatorsFromLocalStorage(with carDetails:String, from violatorsArray:[Violator])
    
    func processPresentationOfViewController()
    
}

protocol InspectionViewProtocol:AnyObject{
    
    var inspectionViewModel:InspectionViewModelProtocol? {get set}
    
    func updateTableView(with violators:[Violator])
    
    func updateTableView(with error:String)
    
    func presentViewController()
    
}
