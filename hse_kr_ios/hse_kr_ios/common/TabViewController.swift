//
//  TabViewController.swift
//  hse_kr_ios
//
//  Created by Al Stark on 05.04.2023.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        tabBar.backgroundColor = .white
        
    }
    
    enum assemblyType {
        case charutyTable
        case userInfo
    }
    
    func generateTabBar() {
        viewControllers = [
            generateVC(viewcontroller: CharityTableViewController(), assembly: .charutyTable,  image: UIImage(systemName: "magnifyingglass")),
            generateVC(viewcontroller: UserInfoViewController(), assembly: .userInfo, image: UIImage(systemName: "person.fill"))
            //                generateVC(viewcontroller: MapViewController(), title: "карта", image: UIImage(systemName: "map.circle")),
            //                generateVC(viewcontroller: UINavigationController(rootViewController: AccauntViewController()) , title: "профиль", image: UIImage(systemName: "person")),
        ]
    }
    
    func generateVC(viewcontroller: UIViewController, assembly: assemblyType, image: UIImage?) -> UIViewController {
        let navVC = UINavigationController(rootViewController: viewcontroller)
        switch assembly {
        case .charutyTable:
            CharityTableAssembly(navigationController: navVC).assembly(viewController: viewcontroller)
        case .userInfo:
            UserInfoAssembly(navigationController: navVC).assembly(viewController: viewcontroller)
        }
        viewcontroller.tabBarItem.image = image
        return navVC
    }
    
    
}
