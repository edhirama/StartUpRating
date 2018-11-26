//
//  RankingViewController.swift
//  StartupRating
//
//  Created by Edgar Hirama on 24/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController, RankingView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorView: UIView!
    
    var rankingConfigurator = RankingConfiguratorImplementation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.rankingConfigurator.configure(rankingViewController: self)
        presenter.viewDidLoad()
        
    }

    func showLoadingView(_ show: Bool) {
        if show {
            LoadingIndicator.shared.show()
        } else {
            LoadingIndicator.shared.hide()
        }
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(RankingTableViewCell.self)
        self.tableView.register(RankingHeaderView.self)
    }
    
    //MARK: RankingView
    
    var presenter: RankingPresenter!
    
    func refreshRankingView() {
        self.tableView.reloadData()
        self.errorView.isHidden = true
    }
    
    func showErrorView(_ show: Bool) {
        self.errorView.isHidden = !show
    }
    
    @IBAction func tryAgainClicked(_ sender: Any) {
        self.presenter.refresh()
    }
}

extension RankingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter.numberOfCriterias
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOfCriteriaRatings(criteriaIndex: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath) as RankingTableViewCell
        self.presenter.configure(cell: cell, section: indexPath.section, forRow: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let header = tableView.dequeueReusableHeaderFooter() as RankingHeaderView
            self.presenter.configure(header: header, forSection: section)
        
            return header
    }
    
}
