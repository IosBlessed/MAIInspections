//
//  ConfiguratorApp.swift
//  MAIInspections
//
//  Created by Никита Данилович on 21.03.2023.
//

import Foundation
import UIKit

class Configurator{
    
    static var shared = Configurator()
    
    var inspectionViewModel:InspectionViewModelProtocol?
    var inspectionView:InspectionViewProtocol?
    
    var addViolatorViewModel:AddViolatorViewModelProtocol?
    var addViolatorView:AddViolatorViewProtocol?
    
    func initialSetup(window:UIWindow){
        
        // Inspection Interaction Section
        inspectionViewModel = InspectionViewModel()
        inspectionView = InspectionViewController()
        
        inspectionViewModel!.inspectionView = inspectionView
        inspectionView!.inspectionViewModel = inspectionViewModel
        
        // Add Violator Section
        addViolatorView = AddViolatorViewController()
        addViolatorViewModel = AddViolatorViewModel()
        
        addViolatorView?.addViolatorViewModel = addViolatorViewModel
        addViolatorViewModel?.addViolatorView = addViolatorView
        
        addViolatorViewModel?.inspectionViewModel = inspectionViewModel
        
        // Launch Screen section
        let launchScreenStoryboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        
        let launchScreeenVC = launchScreenStoryboard.instantiateInitialViewController()
        
        launchScreeenVC?.view.setupGradientBackgroundView()
        
        let imageView = UIImageView(image: UIImage(named: "launchScreenImage.png"))
        
        imageView.bounds = CGRect(x: 0, y: 0, width: 190, height: 180)
        
        imageView.center = launchScreeenVC!.view.center
        
        launchScreeenVC!.view.addSubview(imageView)
        
        // Main Storyboard section
        
        let mainNavVC = UINavigationController(rootViewController: inspectionView as! InspectionViewController)
        
        window.rootViewController = launchScreeenVC
        
      DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            
            window.rootViewController = mainNavVC
          
            }
        
        window.makeKeyAndVisible()
        
    }
    
    func inititalizeAddViolatorViewController() -> AddViolatorViewController{
        
        return addViolatorView as! AddViolatorViewController
    }
    
    private init(){}
    
    
}
