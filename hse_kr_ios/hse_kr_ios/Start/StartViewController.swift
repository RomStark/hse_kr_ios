//
//  StartViewController.swift
//  hse_kr_ios
//
//  Created by Al Stark on 29.03.2023.
//

import UIKit

/// Протокол управления View - слоем в модуле Start
protocol StartViewable: AnyObject {
    
}

final class StartViewController: UIViewController {
    
    var presenter: StartPresentation?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.readyForLoadAndRoute()
        print("ready")
    }
}

// MARK: - StartViewable
extension StartViewController: StartViewable {
    
}

