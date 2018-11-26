//
//  RankingRouter.swift
//  StartupRating
//
//  Created by Edgar Hirama on 25/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import Foundation

protocol RankingRouter {
    func presentDetailsView(forStartup: StartupDetails)
}

class RankingRouterImplementation: RankingRouter {
    var rankingViewController: RankingViewController!
    
    init(rankingViewController: RankingViewController) {
        self.rankingViewController = rankingViewController
    }
    
    func presentDetailsView(forStartup: StartupDetails) {
        
    }
}
