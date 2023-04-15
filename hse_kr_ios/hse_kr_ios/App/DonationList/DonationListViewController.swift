//
//  DonationListViewController.swift
//  hse_kr_ios
//
//  Created by Al Stark on 13.04.2023.
//

import UIKit

class DonationListViewController: UIViewController {

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Список пожертвований"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor(red: 245/255, green: 227/255, blue: 217/255, alpha: 1)
    }
    

}

extension DonationListViewController {
    private func setupUI() {
        setupTitle()
    }
    
    private func setupTitle() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
}
