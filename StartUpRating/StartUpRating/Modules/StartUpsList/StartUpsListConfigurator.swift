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
        let presenter = StartUpListPresenterImplementation(view: startUpsListViewController)
        startUpsListViewController.presenter = presenter
    }
    
}
