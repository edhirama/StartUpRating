//
//  RankingPresenter.swift
//  StartupRating
//
//  Created by Edgar Hirama on 24/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore

protocol RankingView : class {
    func refreshRankingView()
    func displayRankingRetrievalError(title: String, message: String)
}

protocol RankingCellView {
    func displayRank(rank: String)
    func displayStartupName(name: String)
    func displaySegment(segmentName: String)
    func displayRatingString(rating: String)
    func displayRatingValue(value: Double)
    func displayStartupImage(image: UIImage)
}

protocol CriteriaHeaderView {
    func displayCriteria(criteriaName: String)
}

protocol RankingPresenter {
    
    var router: RankingRouter { get }
    var numberOfCriterias: Int { get }
    func numberOfCriteriaRatings(criteriaIndex: Int) -> Int
    func viewDidLoad()
    func configure(cell: RankingCellView, section: Int, forRow row: Int)
    func configure(header: CriteriaHeaderView, forSection section: Int)
    func didSelect(row: Int)
}

class RankingPresenterImplementation: RankingPresenter {
    
    var router: RankingRouter
    var rankings : [Ranking] = [Ranking]()
    fileprivate weak var view: RankingView?
    
    var numberOfCriteriaRatingsLoaded: Int = 0 {
        didSet {
            if numberOfCriteriaRatingsLoaded == 3 {
                self.setView()
            }
        }
    }
    
    var numberOfCriterias: Int {
        return RatingManager.criterias.count
    }

    
    func numberOfCriteriaRatings(criteriaIndex rankingIndex: Int) -> Int {
        if rankingIndex < rankings.count {
            return rankings[rankingIndex].startups?.count ?? 0
        } else {
            return 0
        }
    }
    
    func viewDidLoad() {
        self.loadCriteriaRatings()
    }
    
    func loadCriteriaRatings() {
        RatingManager.getTopPitchRatings { [weak self] (startups) in
            self?.rankings.append(Ranking(type: .pitchRating, startups: startups))
            self?.numberOfCriteriaRatingsLoaded += 1
        }
        
        RatingManager.getTopProposalRatings { [weak self] (startups) in
            self?.rankings.append(Ranking(type: .proposalRating, startups: startups))
            self?.numberOfCriteriaRatingsLoaded += 1
        }
        
        RatingManager.getTopDevelopmentRatings { [weak self] (startups) in
            self?.rankings.append(Ranking(type: .developmentRating, startups: startups))
            self?.numberOfCriteriaRatingsLoaded += 1
        }
    }
    
    func configure(cell: RankingCellView, section: Int, forRow row: Int) {
        if section < self.rankings.count {
            let criteria = self.rankings[section]
            if  criteria.startups != nil, criteria.startups!.count > 0 {
                if let startup = criteria.startups?[row] {
                    let rating = startup.getRating(type: criteria.type)
                    cell.displayRank(rank: "\(row+1)º")
                    cell.displayStartupName(name: startup.name)
                    cell.displaySegment(segmentName: startup.segment)
                    cell.displayRatingValue(value: rating)
                    cell.displayRatingString(rating: "\(rating) / 5")
                    ImageUtils.load(url: URL(string: startup.imageURL)!) { (image) in
                        cell.displayStartupImage(image: image)
                    }
                }
            } else {

            }
        }
        
    }
    
    func configure(header: CriteriaHeaderView, forSection section: Int) {
        if section < rankings.count {
            let criteriaName: String
            switch (rankings[section].type) {
            case .proposalRating:
                criteriaName = "Proposta"
                break
            case .pitchRating:
                criteriaName = "Apresentação/Pitch"
                break
            case .developmentRating:
                criteriaName = "Desenvolvimento"
                break
            }
            header.displayCriteria(criteriaName: criteriaName)
        }
    }
    
    
    func didSelect(row: Int) {
//        if let startup = criterias?[row] {
//            self.router.presentDetailsView(forStartup: startup)
//        }
    }
    

    
    init(view: RankingView, router: RankingRouter) {
        self.view = view
        self.router = router
    }
    
    func setView() {
        self.view?.refreshRankingView()
    }
    
    func setErrorView() {
        //TODO
    }
}
