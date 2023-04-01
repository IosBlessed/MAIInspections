//
//  Extension + UIViewController.swift
//  MAIInspections
//
//  Created by Никита Данилович on 21.03.2023.
//

import UIKit
import SDWebImage

extension InspectionViewController:UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate{
    
    //MARK: - Initial Setup Section
    
    func createCustomNavigationBarAppearance() -> UINavigationBarAppearance{
        
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.configureWithDefaultBackground()
        
        navBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.font:UIFont.systemFont(ofSize: 22,weight: .bold)
        ]
        
        navBarAppearance.backgroundColor = UIColor(red: 230.0/255.0, green: 0.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        
        return navBarAppearance
    }
    
    func createAppendViolatorButton(selector:Selector) -> UIButton {
        
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let title = NSAttributedString(string: "Add Violator",attributes: [
            NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20, weight: .bold)
        ])
        
        button.setAttributedTitle(title, for: .normal)
        button.backgroundColor = UIColor(red: 60.0/255.0, green: 0.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        button.tintColor = .black
        
        button.addTarget(
            self,
            action: selector,
            for: .touchUpInside
        )
        
        return button
    }
    
    //MARK: - TableView Section
    
    func createViolatorsTableView() -> UITableView {
        
        let tableView = UITableView(frame: .zero)
        
        tableView.register(ViolatorsTableViewCell.self, forCellReuseIdentifier: "violatorsCell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        tableView.isScrollEnabled = true
        
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return violatorsArray.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let violatorsCell = violatorsTableView.dequeueReusableCell(withIdentifier: "violatorsCell") as? ViolatorsTableViewCell
        
        let violator = violatorsArray[indexPath.row]
        
        violatorsCell?.inititalizeCellCustomisation()
        
        violatorsCell?.setupFieldsDetails(violator:violator)
        
        violatorsCell?.setupTableViewCellContstraints()
        
            
        return violatorsCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    //MARK: - Search Controller Section
    func createCustomSearchBar() -> UISearchController {
        
        let searchController = UISearchController()
        
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchController.searchBar.searchTextField.backgroundColor = .white
        
        searchController.searchBar.setValue("Cancel", forKey: "cancelButtonText")
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(
            [
                NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20,weight: .bold)
            ],
            for: .normal)
            
        searchController.searchBar.tintColor = .black
        
        searchController.searchBar.placeholder = "Search for violators..."
        
        searchController.searchBar.delegate = self
    
        return searchController
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel button tapped")
        self.updateTableView(with: filteredArrayForSearchBar)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.inspectionViewModel?.processViolatorsFromLocalStorage(
            with: searchText,
            from: filteredArrayForSearchBar
        )
    }
    
    func updateSearchResults(for searchController: UISearchController) {
       
    }
    
}
