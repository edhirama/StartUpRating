//
//  StartupDetailsPresenter.swift
//  StartUpRating
//
//  Created by Edgar Hirama on 22/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import Foundation
import Apollo

protocol StartupDetailsView : class {
    func displayName(name: String)
    func displaySegment(segment: String)
    func displayDescription(description: String)
    func loadImage(image: UIImage)
}

protocol StartupDetailsPresenter {
    func viewDidLoad()
    func didRateProposal(rating: Double)
    func didRatePitch(rating: Double)
    func didRateDevelopment(rating: Double)
    
}

class StartupDetailsPresenterImplementation : StartupDetailsPresenter {

    
    fileprivate weak var view: StartupDetailsView?
    fileprivate let startup: StartupDetails
    
    init(view: StartupDetailsView, startup: StartupDetails) {
        self.view = view
        self.startup = startup
    }
    
    func viewDidLoad() {
        setupView()
        RatingManager.getTopPitchRatings { (ratings) in
            print(ratings)
        }
    }
    
    func setupView() {
        self.view?.displayName(name: startup.name)
        self.view?.displaySegment(segment: startup.segment?.name ?? "")
        self.view?.displayDescription(description: startup.description)
        
        ImageUtils.load(url: URL(string: startup.imageUrl)!) { (image) in
            
            self.view?.loadImage(image: image)
        }
    }
    
    func didRateProposal(rating: Double) {
        RatingManager.addRating(startup: startup, ratingType: .proposalRating, rating: rating)
    }
    
    func didRatePitch(rating: Double) {
        RatingManager.addRating(startup: startup, ratingType: .pitchRating, rating: rating)
    }
    
    func didRateDevelopment(rating: Double) {
        RatingManager.addRating(startup: startup, ratingType: .developmentRating, rating: rating)
    }
    
    
}
