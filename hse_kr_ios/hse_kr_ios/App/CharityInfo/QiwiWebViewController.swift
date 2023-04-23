//
//  QiwiWebViewController.swift
//  hse_kr_ios
//
//  Created by Al Stark on 15.04.2023.
//

import UIKit
import WebKit

class QiwiWebViewController: UIViewController {

    private var web = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWeb()
        view.backgroundColor = .white
    }
    
    private func setupWeb() {
        view.addSubview(web)
        web.translatesAutoresizingMaskIntoConstraints = false
        web.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        web.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        web.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        web.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configure(link: String) {
        print(link)
        let url = URL(string: link)
        let request = URLRequest(url: url ?? URL(string: "https://qiwi.com")!)
        web.load(request)
    }

}
