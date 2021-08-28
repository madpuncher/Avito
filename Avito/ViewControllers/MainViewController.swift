//
//  MainViewController.swift
//  Avito
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 28.08.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - CONSTANTS
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(EmployeesCustomCell.self, forCellReuseIdentifier: EmployeesCustomCell.identifier)
        
        return table
    }()
    
    private var viewModels = [EmployeeViewModel]() {
        didSet {
            viewModels.sort(by: <)
        }
    }
    
    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Наши специалисты"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        
        settingUI()
        getDataEmployees()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //MARK: - Layout and UI
    private func settingUI() {
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.separatorColor = .gray
        
    }
    
    //MARK: - Download news with NetworkManager
    private func getDataEmployees() {
        NetworkManager.shared.getData() { [weak self] result in
            switch result {
            case .success(let employee):
                self?.viewModels = employee.employees.compactMap({
                    EmployeeViewModel(companyName: employee.name, employeeName: $0.name, phoneNumber: $0.phoneNumber, skills: $0.skills, image: 0, scoreFirst: 0, scoreSecond: 0)
                })
                
                //MARK: GENERATE RANDOM ID FOR CUSTOM PHOTO
                for index in 1...7 {
                    let randomScore1 = Int.random(in: 3...4)
                    let randomScore2 = Int.random(in: 0...9)
                    self?.viewModels[index - 1].image = index
                    self?.viewModels[index - 1].scoreFirst = randomScore1
                    self?.viewModels[index - 1].scoreSecond = randomScore2
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
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeesCustomCell.identifier, for: indexPath) as! EmployeesCustomCell
        
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondVC = ProfileViewController()
        secondVC.configure(employee: viewModels[indexPath.row])
        secondVC.modalPresentationStyle = .fullScreen
        present(secondVC, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
}

