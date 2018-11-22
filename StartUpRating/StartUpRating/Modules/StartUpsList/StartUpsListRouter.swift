//
//  StartUpsListRouter.swift
//  StartUpRating
//
//  Created by Edgar Hirama on 22/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import Foundation
import UIKit

protocol StartUpsListRouter : ViewRouter {
    func presentDetailsView(forStartup: StartupDetails)
}

class StartUpsListRouterImplementation: StartUpsListRouter {
    
    fileprivate let showStartupDetailsSegue = "showStartupDetails"
    fileprivate weak var startUpsListViewController : StartUpsListViewController?
    fileprivate var startup: StartupDetails!
    
    init(startUpsListViewController: StartUpsListViewController) {
        self.startUpsListViewController = startUpsListViewController
    }
    
    func presentDetailsView(forStartup startup: StartupDetails) {
        self.startup = startup
        self.startUpsListViewController?.performSegue(withIdentifier: showStartupDetailsSegue, sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let startupDetailsViewController = segue.destination as? StartupDetailsViewController {
            startupDetailsViewController.configurator = StartupDetailsConfiguratorImplementation(startup: startup)
        }
    }
}
