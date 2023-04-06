//
//  UserInfoViewController.swift
//  hse_kr_ios
//
//  Created by Al Stark on 06.04.2023.
//

import UIKit
import Kingfisher

protocol UserInfoViewable: AnyObject {
    
}


final class UserInfoViewController: UIViewController {
    
    
    private enum tags: Int {
        case education
        case healthcare
        case poverty
        case science
        case children
        case art
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 245/255, green: 227/255, blue: 217/255, alpha: 1)
        return tableView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.text = "Имя"
        return label
    }()
    
    private let logOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выйти", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 255, alpha: 1), for: .normal)
        return button
    }()
    
    var presenter: UserInfoPresentation?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 245/255, green: 227/255, blue: 217/255, alpha: 1)
        setupUI()
        getUserInfo()
    }
    
}

//MARK: UserInfoViewable
extension UserInfoViewController: UserInfoViewable{
    
}

//MARK: private extension
private extension UserInfoViewController {
    private func getUserInfo() {
        presenter?.getUserInfo(completion: { [weak self] user in
            self?.nameLabel.text = user.name
            if let urlString = user.photoURL,
               let url = URL(string: urlString) {
                self?.imageView.kf.setImage(with: url)
            } else {
                self?.imageView.image = UIImage(systemName: "person")
            }
        })
        
    }
    private func setupUI() {
        setupImageView()
        setupNameLabel()
        setupLogoutbutton()
    }
    
    private func setupImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        imageView.layer.cornerRadius = 40
        imageView.sizeToFit()
    }
    
    private func setupNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupLogoutbutton() {
        view.addSubview(logOutButton)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logOutButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        logOutButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        logOutButton.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
    }
    
    @objc private func logOutButtonTapped() {
        presenter?.logOut()
    }
    
    
}
