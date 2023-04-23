//
//  AddCharityViewController.swift
//  hse_kr_ios
//
//  Created by Al Stark on 10.04.2023.
//

import UIKit

protocol AddCharityViewable: AnyObject {
    
}

final class AddCharityViewController: UIViewController, UINavigationControllerDelegate {
    var presenter: AddCharityPresentation?
    var coordinate = [Double]()
    private lazy var nameTextField: UITextField = {
        let textField = generateTextField(title: "Введите название благотворительности")
        return textField
    }()
    
    private let imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        return imagePicker
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        return imageView
    }()
    
    
    private lazy var descriptionTextField: UITextField = {
        let textFIeld = generateTextField(title: "Введите описание благотворительности")
        return textFIeld
    }()
    
    private lazy var qiwiTextField: UITextField = {
        let textFIeld = generateTextField(title: "Введите ссылку на Qiwi - кошелек")
        return textFIeld
    }()
    private lazy var adressTextField: UITextField = {
        let textFIeld = generateTextField(title: "Введите адресс")
        return textFIeld
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubviews([
            nameTextField,
            descriptionTextField,
            qiwiTextField,
            adressTextField,
        ])
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private var addAdressButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить адресс", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить благотворительность", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }


}

private extension AddCharityViewController {
    private func setupUI() {
        setupImageView()
        setupStackView()
        setupAddAdressButton()
        setupNextButton()
    }
    private func setupImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
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
    
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
   
    private func setupAddAdressButton() {
        view.addSubview(addAdressButton)
        addAdressButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30).isActive = true
        addAdressButton.widthAnchor.constraint(equalToConstant: 280).isActive = true
        addAdressButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addAdressButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addAdressButton.addTarget(self, action: #selector(addAdressButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addAdressButtonTapped() {
        
        presenter?.confirmAdress(adress: adressTextField.text ?? "", completion: { [weak self] result in
            switch result {
            case .success(let success):
                self?.coordinate = success
                self?.showAlert(title: "Успех", message: "Адресс добавлен")
            case .failure(let failure):
                self?.showAlert(title: "Ошибка", message: "Ошибка")
            }
        })
    }
    
    private func setupNextButton() {
        view.addSubview(nextButton)
        nextButton.topAnchor.constraint(equalTo: addAdressButton.bottomAnchor, constant: 30).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 280).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc private func nextButtonTapped() {
        
        guard let name = nameTextField.text else {
            errorsAlert(error: .nameNotExist)
            return
        }
        guard let description = descriptionTextField.text else {
            errorsAlert(error: .descriptionNotExist)
            return
        }
       
        guard let imageData = imageView.image?.jpegData(compressionQuality: 0.4) else {return}
        presenter?.addCharity(name: name,
                              description: description,
                              qiwiLink: qiwiTextField.text ?? "",
                              adress: coordinate,
                              imageData: imageData,
                              completion: { [weak self] result in
            switch result {
            case .success(let success):
                self?.showAlert(title: "Успех", message: "Данные добавлены")
                
            case .failure(let error):
                self?.errorsAlert(error: error)
            }
        })
    }
 
    private func errorsAlert(error: Errors) {
        switch error {
        case .adressNotExist:
            showAlert(title: "Ошибка" , message: "Такого адреса не существует")
        case .adressNotSpecified:
            showAlert(title: "Ошибка" , message: "Вы не указали адресс")
        case .descriptionNotExist:
            showAlert(title: "Ошибка" , message: "Вы не ввели описание")
        case .nameNotExist:
            showAlert(title: "Ошибка" , message: "Вы не ввели название")
        default:
            showAlert(title: "Ошибка" , message: "Неизвестная ошибка")
        }
    }
    
    private func showAlert(title: String , message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        
        present(alert, animated: true)
    }
    
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
        //        textField.isSecureTextEntry = true
        return textField
    }

}

//MARK: UIImagePickerControllerDelegate
extension AddCharityViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
}

//MARK: AddCharityViewable
extension AddCharityViewController: AddCharityViewable {
    
}
