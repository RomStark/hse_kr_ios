//
//  CharityTableViewCell.swift
//  hse_kr_ios
//
//  Created by Al Stark on 05.04.2023.
//

import UIKit

class CharityTableViewCell: UITableViewCell {
    
    static var reuseIdentifier = "CharityTableViewCell"
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "title"
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.text = "decription"
        return label
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubviews(
            [titleLabel,
             descriptionLabel,
            ]
        )
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = UIColor(red: 245/255, green: 227/255, blue: 217/255, alpha: 1)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setupMainView()
        setupImage()
        setupStackView()
    }
    
    private func setupMainView() {
        contentView.addSubview(mainView)
        mainView.layer.cornerRadius = 8
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func setupImage() {
        mainView.addSubview(image)
        image.widthAnchor.constraint(equalToConstant: 100).isActive = true
        image.heightAnchor.constraint(equalTo: image.widthAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16).isActive = true
        image.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 24).isActive = true
        image.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -24).isActive = true
    }
    
    private func setupStackView() {
        mainView.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 24).isActive = true
        stackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -24).isActive = true
        stackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24).isActive = true
        
    }
    
    func configure(charity: Charity) {
        self.titleLabel.text = charity.name
        self.descriptionLabel.text = charity.description
//        guard let data = charity.data else {return}
//        image.image = UIImage(data: data)
        
        if (image.image == nil) {
            print(charity.photoURL)
            loadPhoto(urlString: charity.photoURL ?? "")
        }
    }
    
    func loadPhoto(urlString: String) {
        guard let url = URL(string: urlString) else {
            self.image.image = UIImage(named: "imageCharity")
            return
        }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image.image = image
                    }
                }
            }
        }
    }

}
