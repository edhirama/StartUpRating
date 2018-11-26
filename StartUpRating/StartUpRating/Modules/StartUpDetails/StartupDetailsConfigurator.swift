//
//  StartupDetailsConfigurator.swift
//  StartupRating
//
//  Created by Edgar Hirama on 22/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import Foundation

protocol StartupDetailsConfigurator {
    func configure(startupDetailsViewController: StartupDetailsViewController)
}

class StartupDetailsConfiguratorImplementation: StartupDetailsConfigurator {
    
    let startup: StartupDetails

    init(startup: StartupDetails) {
        self.startup = startup
    }
    
    func configure(startupDetailsViewController: StartupDetailsViewController) {
        let presenter = StartupDetailsPresenterImplementation(view: startupDetailsViewController,
                                                              startup: startup)
        startupDetailsViewController.presenter = presenter
    }
    
}
