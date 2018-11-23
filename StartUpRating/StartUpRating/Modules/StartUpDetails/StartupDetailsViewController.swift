//
//  StartupDetailsViewController.swift
//  StartUpRating
//
//  Created by Edgar Hirama on 22/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import UIKit

class StartupDetailsViewController: UIViewController, StartupDetailsView {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var segmentLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var configurator: StartupDetailsConfigurator!
    var presenter: StartupDetailsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurator.configure(startupDetailsViewController: self)
        presenter.viewDidLoad()
        self.setupSubviews()
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
    

}
