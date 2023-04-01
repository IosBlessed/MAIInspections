//
//  Extension + AddViolatorViewController.swift
//  MAIInspections
//
//  Created by Никита Данилович on 31.03.2023.
//

import Foundation
import UIKit

extension AddViolatorViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.editedImage] as! UIImage
        
        self.violatorUserView.selectImageButton.setBackgroundImage(image, for: .normal)
        
        self.violatorImageState = .selected
        
        dismiss(animated: true)
    }
    
}
