//
//  StartupTableViewCell.swift
//  StartUpRating
//
//  Created by Edgar Hirama on 22/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import UIKit

class StartupTableViewCell: UITableViewCell, StartupListCellView, Reusable, NibLoadableView {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var segmentLabel: UILabel!
    override var bounds: CGRect {
        didSet {
            self.setupShadow()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCardView()
    }
    
    override func layoutSubviews() {
        
        self.setupShadow()
    }
    
    private func setupShadow() {
        self.cardView.layer.cornerRadius = 8
        self.cardView.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.cardView.layer.shadowRadius = 3
        self.cardView.layer.shadowOpacity = 0.3
        self.cardView.layer.shadowPath = UIBezierPath(roundedRect: self.cardView.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.cardView.layer.shouldRasterize = true
        self.cardView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCardView() {
        self.cardView.layer.cornerRadius = 5.0
        self.logoImageView.layer.cornerRadius = 4.0
        self.logoImageView.layer.masksToBounds = true
    }
    
    //MARK:- StartupListCellView
    func displayName(name: String) {
        nameLabel.text = name
    }
    
    func displaySegment(segment: String) {
        segmentLabel.text = segment
    }
    
    func displayImage(image: UIImage) {
        logoImageView.image = image
    }
    
}
