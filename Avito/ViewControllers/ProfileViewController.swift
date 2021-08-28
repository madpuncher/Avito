//
//  ViewController.swift
//  Avito
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 28.08.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: CONSTANTS
    private let footerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        view.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        return view
    }()
    
    private let footerViewSecond: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        view.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        return view
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        let image = UIImage(systemName: "chevron.left")
        let tintImage = image?.withRenderingMode(.alwaysTemplate)
        button.tintColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        button.setImage(tintImage, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    private let scoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.8894023895, green: 0.8943144679, blue: 0.9438082576, alpha: 1)
        let image = UIImage(systemName: "star.fill")
        let tintImage = image?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintImage, for: .normal)
        button.tintColor = .orange
        button.setTitle("4.5", for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.setTitleColor(.orange, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true

        return button
    }()
    
    private let writteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.8894023895, green: 0.8943144679, blue: 0.9438082576, alpha: 1)
        let image = UIImage(systemName: "pencil")
        button.setImage(image, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true

        return button
    }()
    
    private let employeeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .black)
        label.textColor = .black
        return label
    }()
    
    private let workPlaceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .black)
        label.textColor = .gray
        return label
    }()
    
    private let buttonOpen: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("СВЯЗАТЬСЯ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.4075328112, green: 0.7300835252, blue: 0.6573699117, alpha: 1)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .heavy)
        return button
    }()
    
    private let skillsLabelName: UILabel = {
        let label = UILabel()
        label.text = "ПРОФЕССИОНАЛЬНЫЕ НАВЫКИ"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let skillsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 2
        label.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.7375849698)
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        setupConstraints()
        
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        dismissButton.layer.cornerRadius = dismissButton.frame.height / 2
        writteButton.layer.cornerRadius = dismissButton.frame.height / 2
        scoreButton.layer.cornerRadius = 10

    }
    
    //MARK: BACK BUTTON ACTION
    @objc private func dismissButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: SETUP UI
    func configure(employee: EmployeeViewModel) {
        nameLabel.text = employee.employeeName
        workPlaceLabel.text = "Работает в \(employee.companyName)"
        employeeImageView.image = UIImage(named: "Employee\(employee.image)")
        scoreButton.setTitle("\(employee.scoreFirst).\(employee.scoreSecond)", for: .normal)
        skillsLabel.text = "  \(employee.skills.joined(separator: ", "))  "
        
    }

    private func setupConstraints() {
        view.addSubview(employeeImageView)
        view.addSubview(nameLabel)
        view.addSubview(workPlaceLabel)
        view.addSubview(buttonOpen)
        view.addSubview(footerView)
        view.addSubview(skillsLabelName)
        view.addSubview(dismissButton)
        view.addSubview(writteButton)
        view.addSubview(scoreButton)
        view.addSubview(skillsLabel)
        view.addSubview(footerViewSecond)
        
        NSLayoutConstraint.activate([
            employeeImageView.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.2),
            employeeImageView.topAnchor.constraint(equalTo: view.topAnchor),
            employeeImageView.widthAnchor.constraint(equalToConstant: view.bounds.width)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: employeeImageView.bottomAnchor, constant: 30),
            
            workPlaceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            workPlaceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            
            buttonOpen.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonOpen.topAnchor.constraint(equalTo: employeeImageView.bottomAnchor, constant: 30),
            buttonOpen.widthAnchor.constraint(equalToConstant: 150),
            buttonOpen.heightAnchor.constraint(equalToConstant: 55),
            
            footerView.topAnchor.constraint(equalTo: buttonOpen.bottomAnchor, constant: 20),

            skillsLabelName.topAnchor.constraint(equalTo: footerView.bottomAnchor, constant: 20),
            skillsLabelName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            writteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            writteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            scoreButton.bottomAnchor.constraint(equalTo: employeeImageView.bottomAnchor, constant: -20),
            scoreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            skillsLabel.topAnchor.constraint(equalTo: skillsLabelName.bottomAnchor, constant: 20),
            skillsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            skillsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            skillsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-16),
            
            footerViewSecond.topAnchor.constraint(equalTo: skillsLabel.bottomAnchor, constant: 30),
        ])
        
    }
}


