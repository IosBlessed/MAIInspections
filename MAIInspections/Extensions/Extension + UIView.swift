//
//  Extension + UICol.swift
//  MAIInspections
//
//  Created by Никита Данилович on 21.03.2023.
//

import Foundation
import UIKit


extension UIView{
    
    
    func setupGradientBackgroundView(){
        
        let gradient = CAGradientLayer()
        
        let colorTop =  UIColor(red: 230.0/255.0, green: 0.0/255.0, blue: 50.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 50.0/255.0, green: 0.0/255.0, blue: 230.0/255.0, alpha: 1.0).cgColor
        
        gradient.colors = [colorTop, colorBottom]
        gradient.locations = [0.0,1.0]
        
        gradient.frame = self.bounds
        
        self.layer.addSublayer(gradient)
    }
    
}
