//
//  StartupDetailsViewController.swift
//  StartUpRating
//
//  Created by Edgar Hirama on 22/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import UIKit
import Cosmos

class StartupDetailsViewController: UIViewController, StartupDetailsView {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var segmentLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var proposalRatingView: CosmosView!
    @IBOutlet weak var pitchRatingView: CosmosView!
    @IBOutlet weak var developmentRatingView: CosmosView!
    
    var configurator: StartupDetailsConfigurator!
    var presenter: StartupDetailsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurator.configure(startupDetailsViewController: self)
        presenter.viewDidLoad()
        self.setupSubviews()
        self.setupRatingHandlers()
    }
    
    func setupSubviews() {
        self.logoImageView.layer.cornerRadius = 4.0
        self.logoImageView.layer.masksToBounds = true
    }
    
    //MARK: StartupDetailsView
    func displayName(name: String) {
        self.nameLabel.text = name
    }
    
    func displaySegment(segment: String) {
        self.segmentLabel.text = segment
    }
    
    func displayDescription(description: String) {
        self.descriptionLabel.text = description
    }
    
    func loadImage(image: UIImage) {
        logoImageView.backgroundColor = nil
        self.logoImageView.image = image
    }
    

    //MARK: CosmosView
    
    func setupRatingHandlers() {

        self.proposalRatingView.didFinishTouchingCosmos = self.proposalRatingHandler()
        self.pitchRatingView.didFinishTouchingCosmos = self.pitchRatingHandler()
        self.developmentRatingView.didFinishTouchingCosmos = self.developmentRatingHandler()
        
    }
    
    func proposalRatingHandler () -> ((Double) -> ()) {
        return { [weak self] (rating) in
            self?.presenter.didRateProposal(rating: rating)
        }
    }
    
    func pitchRatingHandler () -> ((Double) -> ()) {
        return { [weak self]  (rating) in
            self?.presenter.didRatePitch(rating: rating)
        }
    }
    
    func developmentRatingHandler () -> ((Double) -> ()) {
        return { [weak self] (rating) in
            self?.presenter.didRateDevelopment(rating: rating)
        }
    }
}
