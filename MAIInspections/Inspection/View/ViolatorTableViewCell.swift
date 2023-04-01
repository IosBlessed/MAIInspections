//
//  ViolatorTableViewCell.swift
//  MAIInspections
//
//  Created by Никита Данилович on 27.03.2023.
//

import UIKit
import SDWebImage

class ViolatorsTableViewCell:UITableViewCell{
    
    func setupTableViewCellContstraints(){
        
        // CellView constraints section
        cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        // PersonImage constraints section
        personImage.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10).isActive = true
        personImage.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 10).isActive = true
        personImage.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10).isActive = true
        personImage.widthAnchor.constraint(equalToConstant: 130).isActive = true
        
        // loadingIndicator( used inside personImage frame ) constraints section
        loadingIndicator.topAnchor.constraint(equalTo: personImage.topAnchor,constant: 5).isActive = true
        loadingIndicator.leftAnchor.constraint(equalTo: personImage.leftAnchor, constant: 5).isActive = true
        loadingIndicator.rightAnchor.constraint(equalTo: personImage.rightAnchor, constant: -5).isActive = true
        loadingIndicator.bottomAnchor.constraint(equalTo: personImage.bottomAnchor, constant: -5).isActive = true
        
        // DetailsView constraints section
        detailsView.topAnchor.constraint(equalTo: personImage.topAnchor).isActive = true
        
        detailsView.leftAnchor.constraint(equalTo: personImage.rightAnchor, constant: 10).isActive = true
        
        detailsView.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -10).isActive = true
                
        detailsView.bottomAnchor.constraint(equalTo: personImage.bottomAnchor).isActive = true
        
        // StackView with details constraints section
        
        detailsStackView.topAnchor.constraint(equalTo: detailsView.topAnchor, constant:10).isActive = true
        detailsStackView.leftAnchor.constraint(equalTo: detailsView.leftAnchor, constant: 10).isActive = true
        detailsStackView.rightAnchor.constraint(equalTo: detailsView.rightAnchor, constant: -10).isActive = true
        detailsStackView.bottomAnchor.constraint(equalTo: detailsView.bottomAnchor, constant: -10).isActive = true
        
    }
    
    func inititalizeCellCustomisation(){
        
        self.selectedBackgroundView = selectedCellView
        
        self.backgroundColor = .none
        
        personImage.addSubview(loadingIndicator)
        
        cellView.addSubview(personImage)
        
        cellView.addSubview(detailsView)
        
        self.addSubview(cellView)
        
    }
    
    func setupFieldsDetails(violator:Violator){
        
        loadingIndicator.startAnimating()
        
        DispatchQueue.main.async{
            
            let urlImage = URL(string: violator.personImagePath ?? "accountIcon.png")
            self.personImage.sd_setImage(with:urlImage)
            self.loadingIndicator.stopAnimating()
            
        }
        
        firstNameLabel.text = violator.firstName
        secondNameLabel.text = violator.secondName
        carNumberLabel.text = violator.carNumber
        idnpLabel.text = violator.idnp
        dateOfBirthLabel.text = violator.dateBirth
        
    }
    
    private lazy var loadingIndicator:UIActivityIndicatorView = {
        
        let indicator = UIActivityIndicatorView()
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        indicator.color = .gray
        indicator.backgroundColor = .clear
        indicator.hidesWhenStopped = true
        indicator.style = .large
        
        return indicator
    }()
    
    private lazy var selectedCellView:UIView = {
        
        let view = UIView(frame: .zero)
        
        view.backgroundColor = .clear
        
        return view
    }()
    
    private lazy var cellView:UIView = {
        
        let cellView = UIView()
        
        cellView.translatesAutoresizingMaskIntoConstraints = false
        
        cellView.backgroundColor = .lightGray
        
        cellView.layer.cornerRadius = 10
        
        return cellView
    }()
    
    private lazy var personImage:UIImageView = {
            
        let personImageView = UIImageView()
            
        personImageView.translatesAutoresizingMaskIntoConstraints = false
        
        personImageView.contentMode = .scaleAspectFit
        personImageView.backgroundColor = .clear
        
        personImageView.layer.masksToBounds = true
        personImageView.layer.cornerRadius = 30
            
        return personImageView
            
    }()
    
    private lazy var firstNameLabel:UILabel = {
        
        let label = UILabel(frame: .zero)
        
        return label
    }()
    
    private lazy var secondNameLabel:UILabel = {
        
        let label = UILabel(frame: .zero)
        
        return label
    }()
    
    private lazy var dateOfBirthLabel:UILabel = {
        
        let label = UILabel(frame: .zero)
        
        return label
    }()
    
    private lazy var idnpLabel:UILabel = {
        
        let label = UILabel(frame: .zero)
        
        return label
    }()
    
    private lazy var carNumberLabel:UILabel = {
        
        let label = UILabel(frame: .zero)
        
        return label
    }()
    
    private lazy var detailsStackView:UIStackView = {
        
        let stackView = UIStackView(frame: .zero)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.backgroundColor = .clear
        stackView.alignment = .center
        
        stackView.axis = .vertical
        stackView.contentMode = .scaleAspectFill
        stackView.distribution = .fillEqually
        
        stackView.addArrangedSubview(firstNameLabel)
        stackView.addArrangedSubview(secondNameLabel)
        stackView.addArrangedSubview(dateOfBirthLabel)
        stackView.addArrangedSubview(idnpLabel)
        stackView.addArrangedSubview(carNumberLabel)
        
        
        return stackView
    }()
    
    private lazy var detailsView:UIView = {
        
        let details = UIView()
       
        details.translatesAutoresizingMaskIntoConstraints = false
       
        details.backgroundColor = .clear
        details.layer.cornerRadius = 10
        
        details.addSubview(detailsStackView)
       
        return details
    }()
    
}

