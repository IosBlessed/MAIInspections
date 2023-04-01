//
//  ActivityIndicator.swift
//  MAIInspections
//
//  Created by Никита Данилович on 31.03.2023.
//

import Foundation
import UIKit

extension ActivityIndicatorUI{
    
    enum ActivityState:String{
        
        case loading = "loading"
        case success = "success"
        case error = "error"
        
    }
    
}


@MainActor open class ActivityIndicatorUI : UIView{
    
    var activityIndicatorSectionView:UIView! = nil
    
    var sectionViewBounds:CGRect! = CGRect(x: 0, y: 0, width: 150, height: 150)
    
    fileprivate func initializeBackgroundView(bounds:CGRect){
        
        self.frame = bounds
        
        self.backgroundColor = .darkGray.withAlphaComponent(0.6)
        
    }
    
    init(bounds:CGRect){
        
        super.init(frame: .zero)

        initializeBackgroundView(bounds: bounds)
        
    }
    
   private lazy var loadingIndicatorView:UIActivityIndicatorView = {
        
       let activityIndicator = UIActivityIndicatorView()
       
       activityIndicator.hidesWhenStopped = true
       
       activityIndicator.isHidden = false
       
       activityIndicator.center = self.center
       
       activityIndicator.backgroundColor = .lightGray
        
       activityIndicator.style = .large
       
       activityIndicator.layer.masksToBounds = true
       activityIndicator.layer.cornerRadius = 10
        
       return activityIndicator
    }()
    
    private lazy var successIndicatorView:UIView = {
        
        let activityIndicator = UIImageView(frame: .zero)
        
        activityIndicator.center = self.center
        
        activityIndicator.backgroundColor = .lightGray
        
        activityIndicator.contentMode = .scaleAspectFit
        
        activityIndicator.image = UIImage(named:"checkmark.png")
        
        activityIndicator.layer.masksToBounds = true
        activityIndicator.layer.cornerRadius = 10
        
        return activityIndicator
        
    }()
   
    func startAnimation(activity activityState:ActivityState){
       
        switch activityState{
            
        case .loading:
            
            self.addSubview(loadingIndicatorView)

            UIView.animate(withDuration: 0.7){
                
                [weak self] in
                
                self?.loadingIndicatorView.startAnimating()
                self?.loadingIndicatorView.bounds = self!.sectionViewBounds
            }
            
            break;
        case .success:
            
            self.addSubview(successIndicatorView)
            
            UIView.animate(withDuration: 0.7){
                [weak self] in
                
                self?.successIndicatorView.bounds = self!.sectionViewBounds
            }
            
        case .error:
            
            print("error")

        }
       
    }
    
    
    func stopAnimation(activity activityState:ActivityState){
        
        switch activityState{
            
        case .loading:
            
            UIView.animate(
                withDuration: 0.7,
                animations: {
                    self.loadingIndicatorView.bounds = CGRect(x: 0, y: 0, width: 0, height: 0)
                }, completion: { _ in
                    
                    self.loadingIndicatorView.stopAnimating()
                    self.loadingIndicatorView.removeFromSuperview()
                    
                })
           
        case .success:
            print("success")
            UIView.animate(
                withDuration: 0.7,
                animations: {
                    self.successIndicatorView.bounds = CGRect(x: 0, y: 0, width: 0, height: 0)
                }, completion: { _ in
                    
                    self.successIndicatorView.removeFromSuperview()
                    
                })
        case .error:
            print("error")
            
        }
    }
    
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
