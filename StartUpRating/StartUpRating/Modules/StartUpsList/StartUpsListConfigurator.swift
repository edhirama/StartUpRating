//
//  StartupsListConfigurator.swift
//  StartupRating
//
//  Created by Edgar Hirama on 22/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import Foundation

protocol StartupsListConfigurator {
    func configure(startupsListViewController: StartupsListViewController)
}

class StartupsListConfiguratorImplementation: StartupsListConfigurator {
    
    func configure(startupsListViewController: StartupsListViewController) {
        let router = StartupsListRouterImplementation(startupsListViewController: startupsListViewController)
        let presenter = StartupListPresenterImplementation(view: startupsListViewController, router: router)
        startupsListViewController.presenter = presenter
    }
    
}
