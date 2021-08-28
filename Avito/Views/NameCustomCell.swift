//
//  NameCustomCell.swift
//  Avito
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 28.08.2021.
//

import UIKit

class NameCustomCell: UITableViewCell {
    
    static let identifier = "nameCell"
    
    private let nameEmployeeLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let workPlaceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = .gray
        return label
    }()
    
    private let openButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("OPEN", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.titleLabel?.textColor = .white
        button.backgroundColor = #colorLiteral(red: 0.4075328112, green: 0.7300835252, blue: 0.6573699117, alpha: 1)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        self.addSubview(nameEmployeeLabel)
        self.addSubview(workPlaceLabel)
        self.addSubview(openButton)
        
        NSLayoutConstraint.activate([
            nameEmployeeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            nameEmployeeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
        ])
    }
    
    
    func setupUI(employee: Company, indexPath: IndexPath) {
        nameEmployeeLabel.text = employee.employees[indexPath.row].name
    }
}

//MARK: Setup Canvas
import SwiftUI

struct nameCellProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            ProfileViewController()
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
