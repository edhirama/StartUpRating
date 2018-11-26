//
//  RankingPresenter.swift
//  StartUpRating
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
    
    fileprivate weak var view: RankingView?
    
    var numberOfCriteriaRatingsLoaded: Int = 0 {
        didSet {
            if numberOfCriteriaRatingsLoaded == 3 {
                self.setView()
            }
        }
    }
    
    var numberOfCriterias: Int {
        return criterias?.count ?? 0
    }
    var criterias : [Criteria?]?
    
    func numberOfCriteriaRatings(criteriaIndex: Int) -> Int {
        return criterias?[criteriaIndex]?.ratings?.count ?? 0
    }
    
    func viewDidLoad() {
        RatingManager.getCriterias { [weak self] (criterias) in
            self?.criterias = criterias
            self?.loadCriteriaRatings()
        }
    }
    
    func loadCriteriaRatings() {
        RatingManager.getTopPitchRatings { [weak self] (ratings) in
            self?.criterias?[0]?.ratings = ratings
            self?.numberOfCriteriaRatingsLoaded += 1
        }
        
        RatingManager.getTopProposalRatings { [weak self] (ratings) in
            self?.criterias?[1]?.ratings = ratings
            self?.numberOfCriteriaRatingsLoaded += 1
        }
        
        RatingManager.getTopDevelopmentRatings { [weak self] (ratings) in
            self?.criterias?[2]?.ratings = ratings
            self?.numberOfCriteriaRatingsLoaded += 1
        }
    }
    
    func configure(cell: RankingCellView, section: Int, forRow row: Int) {
        if let criteria = self.criterias?[section], criteria.ratings != nil, criteria.ratings!.count > 0 {
            if let rating = criteria.ratings?[row] {
                
                cell.displayRank(rank: "\(row+1)º")
                cell.displayStartupName(name: rating.name)
//                cell.displa
//                ImageUtils.load(url: URL(string: startup.imageUrl)!) { (image) in
//                    cell.displayImage(image: image)
//                }
            }
        } else {

        }
        
    }
    
    func configure(header: CriteriaHeaderView, forSection section: Int) {
        header.displayCriteria(criteriaName: criterias?[section]?.name ?? "")
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
