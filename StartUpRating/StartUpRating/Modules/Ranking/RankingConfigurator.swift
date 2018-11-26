//
//  RankingConfigurator.swift
//  StartupRating
//
//  Created by Edgar Hirama on 24/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import Foundation

protocol RankingConfigurator {
    func configure(rankingViewController: RankingViewController)
}

class RankingConfiguratorImplementation: RankingConfigurator {
    
    func configure(rankingViewController: RankingViewController) {
        let router = RankingRouterImplementation(rankingViewController: rankingViewController)
        let presenter = RankingPresenterImplementation(view: rankingViewController, router: router)
        rankingViewController.presenter = presenter
    }
    
}
