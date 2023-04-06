//
//  AuthViewController.swift
//  hse_kr_ios
//
//  Created by Al Stark on 31.03.2023.
//

import UIKit


protocol AuthViewable: AnyObject {
    func showAlert(error: Errors)
}

class AuthViewController: UIViewController {
    

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
    
    private var signInButton: UIButton = {
        var button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        return button
    }()
    
    private var changePasswordButton: UIButton = {
        var button = UIButton()
        button.setTitle("Не помню пароль", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 255, alpha: 1), for: .normal)
        
        return button
    }()
    
    private var changeToRegPasswordButton: UIButton = {
        var button = UIButton()
        button.setTitle("Нет аккаунта", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 255, alpha: 1), for: .normal)
        
        return button
    }()
    
    var presenter: AuthPresentable?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

}


//MARK: AuthViewable
extension AuthViewController: AuthViewable {
    func showAlert(error: Errors) {
        showErrorAlert(error: error)
    }
    
    
}

private extension AuthViewController {
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
        setupEmailTextFiled()
        setupPasswordTextFiled()
        setupChangePasswordButton()
        setupSignInButton()
        setupChangeToRegPasswordButton()
    }
    
    private func setupEmailTextFiled() {
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupPasswordTextFiled() {
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor).isActive = true
    }
    
    private func setupSignInButton() {
        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 60).isActive = true
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signInButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }
    
    @objc private func signInButtonTapped() {
        presenter?.signInButtonTapped(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    private func setupChangePasswordButton() {
        view.addSubview(changePasswordButton)
        changePasswordButton.translatesAutoresizingMaskIntoConstraints = false
        changePasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10).isActive = true
        changePasswordButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor).isActive = true
        changePasswordButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        changePasswordButton.addTarget(self, action: #selector(changePasswordButtonTapped), for: .touchUpInside)
    }
    
    @objc private func changePasswordButtonTapped() {
        showResetAlert()
    }
    private func showResetAlert() {
        let alert = UIAlertController(title: "Сброс пароля", message: "Введите вашу почту", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default){ [weak self] (action) in
            let email = alert.textFields?.first?.text
            self?.presenter?.resetpassword(email: email ?? "")
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        alert.addTextField { loginTF in
            loginTF.placeholder = "Введите почту"
        }
        
        present(alert, animated: true)
        
    }
    
    private func setupChangeToRegPasswordButton() {
        view.addSubview(changeToRegPasswordButton)
        changeToRegPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        changeToRegPasswordButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        changeToRegPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        changeToRegPasswordButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        changeToRegPasswordButton.addTarget(self, action: #selector(changeToRegPasswordButtonTapped), for: .touchUpInside)
    }
    
    @objc private func changeToRegPasswordButtonTapped() {
        presenter?.changeToRegPasswordButtonTapped()
    }
    
    private func showErrorAlert(error: Errors) {
        switch error {
        case .wrongLoginPassword:
            showAlert(title: "Ошибка", message: "Заполните все поля корректно")
        case .emailNotExist:
            showAlert(title: "Ошибка", message: "Аккаунт с такой почтой не существует")
        case .emailNotVerified:
            showAlert(title: "Ошибка", message: "Почта не подтверждена, мы уже отправили письмо на вашу почту")
            presenter?.confirmEmail()
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
