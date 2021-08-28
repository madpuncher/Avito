//
//  EmployeesCustomCell.swift
//  Avito
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 28.08.2021.
//

import UIKit

class EmployeesCustomCell: UITableViewCell {
    
    //MARK: - Const
    static let identifier = "mainCell"
    
    private let companyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.numberOfLines = 3
        label.textColor = .black
        return label
    }()
            
    private let nameTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.numberOfLines = 3
        label.textColor = .black
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let skillLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    
    //MARK: - Initialisation
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameTitleLabel.text = nil
        newsImageView.image = nil
        skillLabel.text = nil
    }
    
    //MARK: - Setup constraints
    private func setupConstraints() {
        
        let chevronRight = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevronRight.tintColor = .black
        
        let stackView = UIStackView(arrangedSubviews: [companyLabel ,nameTitleLabel, phoneLabel, skillLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        
        contentView.addSubview(newsImageView)
        contentView.addSubview(chevronRight)
        contentView.addSubview(stackView)
        
        self.backgroundColor = .white

        stackView.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        skillLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        chevronRight.translatesAutoresizingMaskIntoConstraints = false
        
        let rectangleOne = UIView()
        rectangleOne.backgroundColor = .gray
        
        NSLayoutConstraint.activate([
            newsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            newsImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            newsImageView.heightAnchor.constraint(equalToConstant: 90),
            newsImageView.widthAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 10),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            chevronRight.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            chevronRight.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    //MARK: - Get data
    func configure(with viewModel: EmployeeViewModel) {
        companyLabel.text = "Компания: \(viewModel.companyName)"
        nameTitleLabel.text =  "Имя: \(viewModel.employeeName) "
        skillLabel.text = "Навыки: подробнее в профиле"
        phoneLabel.text = "Телефон: \(viewModel.phoneNumber)"
        newsImageView.image = UIImage(named: "Employee\(viewModel.image)")
    }
}

//MARK: Setup Canvas
import SwiftUI

struct CellProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            MainViewController()
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}

