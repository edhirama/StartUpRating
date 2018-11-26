//
//  StartupsListRouter.swift
//  StartupRating
//
//  Created by Edgar Hirama on 22/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import Foundation
import UIKit

protocol StartupsListRouter : ViewRouter {
    func presentDetailsView(forStartup: StartupDetails)
}

class StartupsListRouterImplementation: StartupsListRouter {
    
    fileprivate let showStartupDetailsSegue = "showStartupDetails"
    fileprivate weak var startupsListViewController : StartupsListViewController?
    fileprivate var startup: StartupDetails!
    
    init(startupsListViewController: StartupsListViewController) {
        self.startupsListViewController = startupsListViewController
    }
    
    func presentDetailsView(forStartup startup: StartupDetails) {
        self.startup = startup
        self.startupsListViewController?.performSegue(withIdentifier: showStartupDetailsSegue, sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let startupDetailsViewController = segue.destination as? StartupDetailsViewController {
            startupDetailsViewController.configurator = StartupDetailsConfiguratorImplementation(startup: startup)
        }
    }
}
