//
//  AppDelegate.swift
//  hse_kr_ios
//
//  Created by Al Stark on 29.03.2023.
//

import UIKit
import CoreData
import FirebaseCore
import FirebaseAuth
import GoogleSignIn


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        FirebaseApp.configure()
//        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if user == nil  {
                self?.showAuth()
            } else {
                self?.showApp()
            }
        }
        
        return true
    }
    
    private func showAuth() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = AuthViewController()
        let navcontroller = UINavigationController(rootViewController: vc)
        window?.rootViewController = navcontroller
        AuthAssembly(navigationController: navcontroller).assembly(viewController: vc)
        window?.makeKeyAndVisible()
    }
    
    private func showApp() {
        window = UIWindow(frame: UIScreen.main.bounds)
//        let vc = CharityTableViewController()
//        let navcontroller = UINavigationController(rootViewController: vc)
        let tabBarVC = TabViewController()
        window?.rootViewController = tabBarVC
//        CharityTableAssembly(navigationController: navcontroller).assembly(viewController: vc)
        window?.makeKeyAndVisible()
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
}
