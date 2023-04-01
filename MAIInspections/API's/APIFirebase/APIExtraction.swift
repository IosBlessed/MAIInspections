//
//  APIExtraction.swift
//  MAIInspections
//
//  Created by Никита Данилович on 25.03.2023.
//

import Foundation
import FirebaseCore
import FirebaseDatabase
import FirebaseFirestore
import FirebaseStorage


class APIFirebase{
    
    static let shared = APIFirebase()
    
    // BAD PRACTICE
    func setupFieldsData(){
        
        let firestore = Firestore.firestore()
        
        let documentFields:[String:Any] = [
            "carNumber":"",
            "dateOfBirth":"",
            "firstName":"",
            "secondName":"",
            "personImagePath":"",
            "idnp":""
        ]
        
        firestore.collection("violatorsCard").addDocument(data: documentFields){
            error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            print("Initial fields for document been successfully added!")
            
        }
    }
    
    // Get whole documents from firestore ( in this case -> Violator)
    func broadcastFromFirestoreToCoreData(completion: @escaping([ViolatorModel]) -> Void){
        
        let firestore = Firestore.firestore()
        
        firestore.collection("violatorsCard").getDocuments{
            
            QuerySnapshot, error in
            
            guard error == nil else {print(error!.localizedDescription);return}
            
            let violators = QuerySnapshot?.documents
            
            var violatorsArray:[ViolatorModel] = []
            
            // Violators extraction from FirebaseFirestore
            for violatorsData in violators! {
                
                let violator = violatorsData.data()
                
                let personImagePath = violator["personImagePath"] as? String ?? "launchScreenImage.png"
                let firstName = violator["firstName"] as? String ?? "Unknown"
                let secondName = violator["secondName"] as? String ?? "Unknown"
                let carNumber = violator["carNumber"] as? String ?? "Unknown"
                let idnp = violator["idnp"] as? String ?? "0000000000000"
                let dateOfBirth = violator["dateOfBirth"] as? String ?? "00.00.00"
                
            
                let violatorModel = ViolatorModel(
                    personImagePath: personImagePath,
                    firstName: firstName,
                    secondName: secondName,
                    dateOfBirth: dateOfBirth,
                    idnp: idnp,
                    carNumber: carNumber
                )
                
                violatorsArray.append(violatorModel)
                
            
            }
           return completion(violatorsArray)
        }
        

        
    }
    
    
    // To avoind creation of objects
    private init(){}
    
}
