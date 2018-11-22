//
//  StartUpsListConfigurator.swift
//  StartUpRating
//
//  Created by Edgar Hirama on 22/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import Foundation

protocol StartUpsListConfigurator {
    func configure(startUpsListViewController: StartUpsListViewController)
}

class StartUpsListConfiguratorImplementation: StartUpsListConfigurator {
    
    func configure(startUpsListViewController: StartUpsListViewController) {
        let router = StartUpsListRouterImplementation(startUpsListViewController: startUpsListViewController)
        let presenter = StartUpListPresenterImplementation(view: startUpsListViewController, router: router)
        startUpsListViewController.presenter = presenter
    }
    
}
