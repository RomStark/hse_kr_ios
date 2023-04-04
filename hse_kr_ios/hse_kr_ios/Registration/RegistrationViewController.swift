//
//  RegistrationViewController.swift
//  hse_kr_ios
//
//  Created by Al Stark on 03.04.2023.
//

import UIKit

protocol RegistrationViewable: AnyObject {
    
}

class RegistrationViewController: UIViewController {
    
    private lazy var nameTextField: UITextField = {
        let textFiled = self.generateTextField(title: "Введите имя")
        return textFiled
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = generateTextField(title: "email")
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    private lazy var passwordTextField: UITextField = {
        let textField = generateTextField(title: "Введите пароль")
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        return textField
    }()
    private lazy var stackView: UIStackView =  {
        var stackView = UIStackView()
        stackView.addArrangedSubviews(
            [
                nameTextField,
                emailTextField,
                passwordTextField,
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private var regButton: UIButton = {
        var button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        return button
    }()
    var presenter: RegistrationPresentable?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
}

//MARK: RegistrationViewable
extension RegistrationViewController: RegistrationViewable {
    
}

private extension RegistrationViewController {
    private func generateTextField(title: String) -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = .white
        
        let placeholderText = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.attributedPlaceholder = placeholderText
        textField.borderStyle = .bezel
        textField.backgroundColor = .white
        textField.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        textField.layer.borderWidth = 1.0
        textField.textColor = .black
        textField.layer.cornerRadius = 10.0
        textField.borderStyle = .roundedRect
        return textField
    }
    
    private func setupUI() {
        setupStackView()
        setupRegButton()
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
    }
    private func setupRegButton() {
        view.addSubview(regButton)
        regButton.translatesAutoresizingMaskIntoConstraints = false
        regButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30).isActive = true
        regButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        regButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        regButton.widthAnchor.constraint(equalToConstant: 220).isActive = true
        regButton.addTarget(self, action: #selector(regButtonTapped), for: .touchUpInside)
    }
    
    @objc private func regButtonTapped() {
        presenter?.registration(name: nameTextField.text ?? "", email: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: { [weak self] result in
            switch result {
            case .failure(let error):
                self?.showErrorAlert(error: error)
            case .success(let id):
                print(id)
            }
        })
    }
    
    private func showErrorAlert(error: Errors) {
        switch error {
        case .wrongLoginPassword:
            showAlert(title: "Ошибка", message: "Заполните все поля корректно")
        case .emailExist:
            showAlert(title: "Ошибка", message: "Аккаунт с такой почтой уже существует")
        case .unknownError:
            showAlert(title: "Ошибка", message: "Неизвестваня ошибка, повторите еще раз")
        default:
            showAlert(title: "Ошибка", message: "Неизвестваня ошибка, повторите еще раз")

        }
    }
    
    func showAlert(title: String , message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        
        present(alert, animated: true)
    }
}
