//
//  ViewController.swift
//  MAIInspections
//
//  Created by Никита Данилович on 21.03.2023.
//

import UIKit

class InspectionViewController: UIViewController,InspectionViewProtocol {
    
    //MARK: - Parameters Section
    weak var inspectionViewModel: InspectionViewModelProtocol?{
        didSet{
            inspectionViewModel?.getViolatorsFromLocalStorage()
        }
    }
    
    var addViolatorsButton:UIButton!
    
    var searchController:UISearchController!
    
    var violatorsTableView:UITableView!
    
    var violatorsArray:[Violator]!
    
    var filteredArrayForSearchBar:[Violator]!
    
    
    //MARK: - InspectionView Delegate
    
    func presentViewController() {
        
        let addViolatorsViewController = Configurator.shared.inititalizeAddViolatorViewController()
        
        addViolatorsViewController.modalPresentationStyle = .fullScreen
        
        let backButtonItem = UIBarButtonItem()
        
        backButtonItem.title = "back"
        backButtonItem.tintColor = .black
        backButtonItem.setTitleTextAttributes(
            [
                NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18, weight: .bold)
            ],
            for: .normal
        )
        
        self.navigationItem.backBarButtonItem = backButtonItem
        
        show(addViolatorsViewController, sender: self)
        
        
    }
    
    func updateTableView(with violators: [Violator]) {
        
        self.violatorsArray = violators
        
        violatorsTableView?.reloadData()
    }
    
    func updateTableView(with error: String) {
        
        print(error)
        
    }

    //MARK: - Violator's Button setup
    private func setupAddViolatorsButton(){
            
        addViolatorsButton = createAppendViolatorButton(selector: #selector(addViolatorsButtonTapped))
        
        view.addSubview(addViolatorsButton)
        
    }
    //MARK: - Violator's TableView setup
    private func setupViolatorsTableView(){
        
        violatorsTableView = createViolatorsTableView()
        
        view.addSubview(violatorsTableView)
        
    }
    
    //MARK: - Navigation Bar setup
    private func setupNavigationBar(){
        
        title = "Violators"
        
        let customAppearance = createCustomNavigationBarAppearance()
        searchController = createCustomSearchBar()
        
    
        navigationItem.standardAppearance = customAppearance
        navigationItem.scrollEdgeAppearance = customAppearance
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

    }
    
    //MARK: - Selector's actions functions
    @objc func addViolatorsButtonTapped(){
        
        self.inspectionViewModel?.processPresentationOfViewController()
    
    }
    
    @objc func cancelButtonTapped(){
        
        print("Text Field touched")
    }
    
    private func setupBackgroundView(){
        
        view.setupGradientBackgroundView()
        
    }
    
    
//MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupBackgroundView()
        
        setupNavigationBar()
        
        setupViolatorsTableView()
        
        setupAddViolatorsButton()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        filteredArrayForSearchBar = violatorsArray
    }
    
    override func viewDidLayoutSubviews() {
        
        //TableView constraints section
        violatorsTableView.heightAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.owningView!.bounds.height - 80).isActive = true
        
        violatorsTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        
        violatorsTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        
        
        // Add Violators button constraints section
        addViolatorsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        addViolatorsButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        
        addViolatorsButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        addViolatorsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
     }
    
}

