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
    
    private let userDefaults = UserDefaults.standard
    
    private enum tags: Int, CaseIterable {
        case education
        case healthcare
        case poverty
        case science
        case children
        case art
        
        func getCurrentType() -> String {
            return tags.getType(number: rawValue)
        }
        
        static func getType(number: Int) -> String {
            switch number {
            case 0:
                return("Образование")
            case 1:
                return("здравоохранение")
            case 2:
                return("бедные")
            case 3:
                return("наука")
            case 4:
                return("дети")
            case 5:
                return("искусство")
                
            default:
                return("undefined")
            }
        }
    }
    
    private var recomendationDict: [String: Bool] = [:]
    
    private let imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        return imagePicker
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 245/255, green: 227/255, blue: 217/255, alpha: 1)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        setupTableView()
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
        let tapGesutre = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(tapGesutre)
        imageView.isUserInteractionEnabled = true
        imagePicker.delegate = self
    }
    
    @objc private func imageViewTapped() {
        let alert = UIAlertController(title: "Изображение", message: nil, preferredStyle: .actionSheet)
        let actionPhoto = UIAlertAction(title: "Галерея", style: .default) { [weak self] (alert) in
            guard let self else {return}
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(actionPhoto)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
    
    private func setupNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 360).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func setupLogoutbutton() {
        view.addSubview(logOutButton)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20).isActive = true
        logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logOutButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        logOutButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        logOutButton.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        
        
    }
    
    @objc private func logOutButtonTapped() {
        presenter?.logOut()
    }
    
    @objc private func switchValueChanged(_ sender: UISwitch) {
        recomendationDict[tags.getType(number: sender.tag)] = sender.isOn
        userDefaults.set(recomendationDict, forKey: "recomendationDict")
    }
    
}

//MARK: UITableViewDelegate
extension UserInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


//MARK: UITableViewDataSource
extension UserInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.allCases.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tags.init(rawValue: indexPath.row)?.getCurrentType()
        cell.backgroundColor = UIColor(red: 245/255, green: 227/255, blue: 217/255, alpha: 1)
        let switchView = UISwitch()
        switchView.setOn(false, animated: true)
        switchView.tag = indexPath.row
        switchView.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        
        cell.accessoryView = switchView
        return cell
    }
    
    
}

//MARK: UIImagePickerControllerDelegate
extension UserInfoViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
}

//MARK: UINavigationControllerDelegate
extension UserInfoViewController: UINavigationControllerDelegate {
    
}
