//
//  RankingTableViewCell.swift
//  StartUpRating
//
//  Created by Edgar Hirama on 25/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import UIKit

class RankingTableViewCell: UITableViewCell, Reusable, NibLoadableView, RankingCellView {
   

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var startupImageView: UIImageView!
    @IBOutlet weak var startupNameLabel: UILabel!
    @IBOutlet weak var segmentLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
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
        //TODO
    }
    
    func displayStartupImage(image: UIImage) {
        //TODO
    }
    
}
