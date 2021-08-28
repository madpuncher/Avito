//
//  MainViewController.swift
//  Avito
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 28.08.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: CONSTANTS
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(EmployeesCustomCell.self, forCellReuseIdentifier: EmployeesCustomCell.identifier)
        table.tableFooterView = UIView()
        return table
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        searchController.isActive && !searchBarIsEmpty
    }
    
    private var viewModels = [EmployeeViewModel]() {
        didSet {
            viewModels.sort(by: <)
        }
    }
    private var filteredEmployees = [EmployeeViewModel]()
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Наши специалисты"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        
        settingUI()
        getDataEmployees()
        setupSearchBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    
    //MARK: LAYOUT AND UI
    private func settingUI() {
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.separatorColor = .gray
        
        navigationController?.navigationBar.tintColor = .black
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gobackward"), style: .done, target: self, action: #selector(reloadTable))
        
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Введите имя работника"
        definesPresentationContext = true
    }
    
    
    //MARK: RELOAD TABLE VIEW AND FETCH DATA ACTION
    @objc private func reloadTable() {
        if viewModels.isEmpty && filteredEmployees.isEmpty {
            getDataEmployees()
        }
        tableView.reloadData()
    }
    
    //MARK: DOWNLOAD DATA FROM DATA MANAGER
    private func getDataEmployees() {
        NetworkManager.shared.getData() { [weak self] result in
            switch result {
            case .success(let employee):
                self?.viewModels = employee.employees.compactMap({
                    EmployeeViewModel(companyName: employee.name, employeeName: $0.name, phoneNumber: $0.phoneNumber, skills: $0.skills, image: 0, scoreFirst: 0, scoreSecond: 0)
                })
                
                //MARK: GENERATE RANDOM ID FOR CUSTOM PHOTO
                if self?.viewModels.isEmpty == false {
                    //MARK: SAFE UNWRAP ( 0 OR 100 ALWAYS WILL BE WORK )
                    for index in 1...(self?.viewModels.count)! {
                        let randomScore1 = Int.random(in: 3...4)
                        let randomScore2 = Int.random(in: 0...9)
                        self?.viewModels[index - 1].image = index
                        self?.viewModels[index - 1].scoreFirst = randomScore1
                        self?.viewModels[index - 1].scoreSecond = randomScore2
                    }
                }
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Ошибка", message: error.localizedDescription)
                }
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Хорошo", style: .default, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

//MARK: DELEGATE AND DATA SOURCE TABLE VIEW
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredEmployees.count
        }
        
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeesCustomCell.identifier, for: indexPath) as! EmployeesCustomCell
        
        if isFiltering {
            cell.configure(with: filteredEmployees[indexPath.row])
        } else {
            cell.configure(with: viewModels[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondVC = ProfileViewController()
        let employee: EmployeeViewModel
        employee = isFiltering ? filteredEmployees[indexPath.row] : viewModels[indexPath.row]
        secondVC.configure(employee: employee)
        secondVC.modalPresentationStyle = .fullScreen
        present(secondVC, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
}

extension MainViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredText(searchController.searchBar.text ?? "")
    }
    
    private func filteredText(_ searchText: String) {
        filteredEmployees = viewModels.filter({ $0.employeeName.lowercased().contains(searchText.lowercased())})
        tableView.reloadData()
    }
}
