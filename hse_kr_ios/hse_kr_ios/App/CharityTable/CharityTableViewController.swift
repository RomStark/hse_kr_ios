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
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Лента"
        label.font = UIFont.boldSystemFont(ofSize: 44)
        label.numberOfLines = 1
        return label
    }()
    
    
    private var segmentController: UISegmentedControl = {
        let segmentController = UISegmentedControl(items: ["Все организации", "Рекомендации"])
        
        return segmentController
    }()
    
    
    private var tableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = UIColor(red: 245/255, green: 227/255, blue: 217/255, alpha: 1)
        return tableview
    }()
    
    
    
    private var charities = [Charity]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var presenter: CharityTablePresentation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 245/255, green: 227/255, blue: 217/255, alpha: 1)
        
        setupUI()
    }
    
}

//MARK: CharityTableViewable
extension CharityTableViewController: CharityTableViewable {
    
}

private extension CharityTableViewController {
    private func setupUI() {
        setupTitleLabel()
        setupSegmentController()
        setupTableView()
    }
    
    
    
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
    private func setupSegmentController() {
        view.addSubview(segmentController)
        segmentController.selectedSegmentIndex = 0
        fetchCharities()
        segmentController.addUnderlineForSelectedSegment()
        segmentController.translatesAutoresizingMaskIntoConstraints = false
        segmentController.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        segmentController.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentController.addTarget(self, action: #selector(segmentControllerValueChanged), for: .valueChanged)
    }
    
    @objc private func segmentControllerValueChanged(target: UISegmentedControl) {
        if target == self.segmentController {
            target.changeUnderlinePosition()
            fetchCharities()
        }
    }
    
    private func fetchCharities() {
        presenter?.getCharityModels(completion: { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let charity):
                self?.charities = charity
            }
        })
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: segmentController.bottomAnchor, constant: 30).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.register(CharityTableViewCell.self, forCellReuseIdentifier: CharityTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
   
}

//MARK: UITableViewDataSource
extension CharityTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.charities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharityTableViewCell.reuseIdentifier, for: indexPath) as? CharityTableViewCell
        cell?.configure(charity: self.charities[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    
}

//MARK: UITableViewDelegate
extension CharityTableViewController: UITableViewDelegate {
    
}

