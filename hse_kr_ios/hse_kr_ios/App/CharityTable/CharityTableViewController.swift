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
    
    private let charityStorage = CharityStorage.shared
    private let myRefreshontrol: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
        return refresh
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Лента"
        label.font = UIFont.boldSystemFont(ofSize: 44)
        label.numberOfLines = 1
        return label
    }()
    
    private let addCharityButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
//        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.setBackgroundImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        
        button.sizeToFit()
        return button
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
        setupAddButton()
    }
    
    
    
    private func setupAddButton() {
        view.addSubview(addCharityButton)
        addCharityButton.translatesAutoresizingMaskIntoConstraints = false
        addCharityButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        addCharityButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        addCharityButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        addCharityButton.heightAnchor.constraint(equalTo: addCharityButton.widthAnchor).isActive = true
        addCharityButton.layer.cornerRadius = 40
        addCharityButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addButtonTapped() {
        presenter?.addCharityButtonTapped()
        
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
        fetchCharities(isRecomendet: false)
        segmentController.addUnderlineForSelectedSegment()
        segmentController.translatesAutoresizingMaskIntoConstraints = false
        segmentController.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        segmentController.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentController.addTarget(self, action: #selector(segmentControllerValueChanged), for: .valueChanged)
    }
    
    @objc private func segmentControllerValueChanged(target: UISegmentedControl) {
        if target == self.segmentController {
            target.changeUnderlinePosition()
            switch target.selectedSegmentIndex {
            case 0:
                fetchCharities(isRecomendet: false)
            case 1:
                fetchCharities(isRecomendet: true)
            default:
                print("")
            }
        }
    }
    @objc private func refreshData(sender: UIRefreshControl) {
        fetchCharities(isRecomendet: false)
        sender.endRefreshing()
    }
    private func fetchCharities(isRecomendet: Bool) {
        presenter?.getCharityModels(isRecomended: isRecomendet, completion: { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let charities):
                for charity in charities {
                    self?.charityStorage.charities[charity.id] = charity
                }
                self?.charities = charities
            }
        })
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.refreshControl = myRefreshontrol
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let charityVC = CharityInfoViewController()
        charityVC.configure(charity: self.charities[indexPath.row])
        navigationController?.pushViewController(charityVC, animated: true)
        
    }
    
}

