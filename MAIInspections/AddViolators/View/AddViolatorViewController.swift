//
//  AddViolatorViewController.swift
//  MAIInspections
//
//  Created by Никита Данилович on 27.03.2023.
//

import UIKit
import FirebaseStorage

//MARK: - AddViolatorViewController

enum ViolatorImageSelectionState{
    case selected
    case notSelected
}


class AddViolatorViewController: UIViewController, AddViolatorViewProtocol {
    
    weak var addViolatorViewModel: AddViolatorViewModelProtocol?
    
    var violatorUserView: AddViolatorUserView!
    
    var violatorTextFieldDetails:ViolatorTextFieldDetails = [:]
    
    var violatorImageState:ViolatorImageSelectionState = .notSelected
    
    var violatorImagePickerController: UIImagePickerController?
    
    var activityIndicator:ActivityIndicatorUI! = nil
    
    func presentRootViewController(animated: Bool) {
        
        self.navigationController?.popToRootViewController(animated: animated)
        
    }
    
    func uploadViolatorImageToFBStorage(){

        let fbStorageRef = Storage.storage().reference()

        let violatorImageData = violatorUserView.selectImageButton.currentBackgroundImage!.pngData()

        let fileRef = fbStorageRef.child("violatorsImages/\(violatorTextFieldDetails["idnp"] ?? "UnknownIDNP").png")
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"


        let uploadImageTask = fileRef.putData(violatorImageData!,metadata: metadata){

            metadata, error in

            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimation(activity: .loading)
            }
            
            fileRef.downloadURL{
                url, error in

                guard error == nil else{
                    print(error!.localizedDescription)
                    return
                }
                DispatchQueue.main.async {
                    self.activityIndicator.startAnimation(activity: .success)
                }
                
                self.violatorTextFieldDetails[ViolatorDetails.personImagePath.rawValue] = url!.absoluteString
                
                self.addViolatorViewModel?.addViolatorToLocalStorage(add: self.violatorTextFieldDetails)

                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                    defer{
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    
                    self.activityIndicator.stopAnimation(activity: .success)
                    self.activityIndicator.removeFromSuperview()
                    self.activityIndicator = nil
                }
                
                
            }

        }
        
        uploadImageTask.resume()
    }
    
    func uploadViolatorToTheCoreData() {
        
        uploadViolatorImageToFBStorage()
        
    }
   

    private func initialSetupBackgroundView(){
        
        view.setupGradientBackgroundView()
        
    }
    
    private func initializeAddViolatorView(){
        
        violatorUserView = AddViolatorUserView()
        
        violatorUserView.frame = view.bounds
        
        violatorUserView.inititalSetupView()
        
        violatorUserView.createViolatorButton.addTarget(
            self,
            action: #selector(createViolatorButton),
            for: .touchUpInside)
        
        violatorUserView.selectImageButton.addTarget(
            self,
            action: #selector(getViolatorImage),
            for: .touchUpInside
        )
        
        view.addSubview(violatorUserView)
    }
    
    private func initializePickerController(){
        
        violatorImagePickerController = UIImagePickerController()
        
        violatorImagePickerController?.delegate = self
        
        violatorImagePickerController?.allowsEditing = true
        
        violatorImagePickerController?.modalPresentationStyle = .popover
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initialSetupBackgroundView()
        
        initializeAddViolatorView()
        
        DispatchQueue.main.async {
            self.initializePickerController()
        }
     
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = false
    }
    
    @objc func getViolatorImage(){
        
        guard violatorImagePickerController != nil else{
            print("Error!ImagePickerView instance is not found!")
            return
        }
        
        self.present(violatorImagePickerController!, animated: true)
    }
    
    @objc func createViolatorButton(){
        
        activityIndicator = ActivityIndicatorUI(bounds: view.bounds)
        
        self.navigationItem.hidesBackButton = true

                
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimation(activity: .loading)
        
        let firstname = violatorUserView.getViolatorTextFieldData(with: .firstname)
        let secondname = violatorUserView.getViolatorTextFieldData(with: .secondname)
        let idnp = violatorUserView.getViolatorTextFieldData(with: .idnp)
        let dateOfBirth = violatorUserView.getViolatorTextFieldData(with: .dateOfBirth)
        let carNumber = violatorUserView.getViolatorTextFieldData(with: .carNumber)
        
        violatorTextFieldDetails = [
            "firstname":firstname,
            "secondname":secondname,
            "idnp":idnp,
            "dateOfBirth":dateOfBirth,
            "carNumber":carNumber
        ]
        
        self.addViolatorViewModel?.processTextFieldsAndImage(with: violatorTextFieldDetails,imageState: violatorImageState)
    
        //self.navigationController?.popToRootViewController(animated: true)
    }
    
}
