//
//  Service + ViolatorExtraction.swift
//  MAIInspections
//
//  Created by Никита Данилович on 25.03.2023.
//

import Foundation
import UIKit
import CoreData


struct CoreDataError:LocalizedError{
    
    var title:String?
    var errorDescription: String? {return description}
    
    private var description:String?
    
    init(title:String?, description:String){
        self.title = title
        self.description = description
    }
}

class APIDBViolators{
    
    
    static let shared = APIDBViolators()
    
    // To avoid creation of object
    private init(){}
    
    private func getDatabaseAppDelegate()->AppDelegate{
        
        return UIApplication.shared.delegate as! AppDelegate
        
    }
    
    private func getDatabaseContext()->NSManagedObjectContext{
        
        return getDatabaseAppDelegate().persistentContainer.viewContext
    }
    
 

    private func getDatabaseEntityDescription(entity entityName:String) -> NSEntityDescription {
        
        let context = getDatabaseContext()
        
        guard let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            fatalError("No such entity as you mentioned: \(entityName)")
        }
        
        return entityDescription
    }
    
    func extractViolatorsFromLocalDB() -> [Violator]{
        
        let context = getDatabaseContext()
        
        let fetchRequest = Violator.fetchRequest()
        
        
            do{
                let violatorsArray = try context.fetch(fetchRequest)
                
                return violatorsArray
                
            }catch let error as NSError {
                fatalError(error.localizedDescription)
            }
        
    }
    
    func removeViolatorFromCoreData(idnp idnpData:String, completion: (String?,Error?) -> Void){
        
        let success = "Violator successfully deleted from Database!"
        
        let violators = extractViolatorsFromLocalDB()
        let appDelegate = getDatabaseAppDelegate()
        let context = getDatabaseContext()
        
        let violatorBeRemoved = violators.filter{
            violator in
            violator.idnp == idnpData
        }
       
        if violatorBeRemoved.count > 0{
            context.delete(violatorBeRemoved.first!)
            appDelegate.saveContext()
            return completion(success,nil)
        }
        else{
            
            let error = CoreDataError(title: nil, description: "Can't find violator with selected idnp: \(idnpData)") as NSError
            
            return completion(nil,error)
            
        }
    }
    
    func showViolators(){
        
        let violators = extractViolatorsFromLocalDB()
            
            for violator in violators {
                print("\(violator.firstName ?? "Unknown") => \(violator.secondName ?? "Unknown ")")
            }
            
        
    }
    
    
    // MARK: - Test Functions
    
    func addViolatorToLocalStorage(
        personImagePath:String,
        firstName:String,
        secondName:String,
        dateOfBirth:String,
        idnp:String,
        carNumber:String
    ){
        
        let violators = extractViolatorsFromLocalDB()
        
        for violator in violators {
            if violator.idnp == idnp{
                    return
            }
        }
            
        
        let appDelegate = getDatabaseAppDelegate()
        let context = getDatabaseContext()
        
        let entityDescription = getDatabaseEntityDescription(entity: "Violator")
        let managedObject = Violator(entity: entityDescription, insertInto: context)
        
        managedObject.personImagePath = personImagePath
        managedObject.firstName = firstName
        managedObject.secondName = secondName
        managedObject.dateBirth = dateOfBirth
        managedObject.idnp = idnp
        managedObject.carNumber = carNumber
        
        appDelegate.saveContext()
    
    }
    
}

