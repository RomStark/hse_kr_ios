//
//  CharityTableViewController.swift
//  hse_kr_ios
//
//  Created by Al Stark on 03.04.2023.
//

import UIKit

protocol CharityTableViewable: AnyObject {
    
}

final class CharityTableViewController: UIViewController {
    
    private var signOutButton: UIButton = {
        var button = UIButton()
        button.setTitle("Выйти", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 255, alpha: 1), for: .normal)
        
        return button
    }()
    
    var presenter: CharityTablePresentation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        setupUI()
    }
    
}

//MARK: CharityTableViewable
extension CharityTableViewController: CharityTableViewable {
    
}

private extension CharityTableViewController {
    private func setupUI() {
        setupSignOutButton()
    }
    
    private func setupSignOutButton() {
        view.addSubview(signOutButton)
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
        
    }
    
    @objc private func signOutButtonTapped() {
        presenter?.signOut()
    }
}
