//
//  RankingTableViewCell.swift
//  StartupRating
//
//  Created by Edgar Hirama on 25/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import UIKit
import Cosmos

class RankingTableViewCell: UITableViewCell, Reusable, NibLoadableView, RankingCellView {
    

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var startupImageView: UIImageView!
    @IBOutlet weak var startupNameLabel: UILabel!
    @IBOutlet weak var segmentLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var ratingView: CosmosView!
    //MARK:- RankingCellView
    
    func displayRank(rank: String) {
        rankLabel.text = rank
    }
    
    func displayStartupName(name: String) {
        startupNameLabel.text = name
    }
    
    func displayRatingString(rating: String) {
        ratingLabel.text = rating
    }
    
    func displayRatingValue(value: Double) {
        ratingView.rating = value
    }
    
    func displayStartupImage(image: UIImage) {
        self.startupImageView.image = image
        self.startupImageView.backgroundColor = .white
    }
    
    func displaySegment(segmentName: String) {
        self.segmentLabel.text = segmentName
    }
}
