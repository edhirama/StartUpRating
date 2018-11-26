//
//  StartupsListViewController.swift
//  StartupRating
//
//  Created by Edgar Hirama on 21/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import UIKit

class StartupsListViewController: UIViewController, StartupListView {
 
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var startups: [StartupDetails]?
    
    var configurator = StartupsListConfiguratorImplementation()
    var presenter: StartupListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        configurator.configure(startupsListViewController: self)
        presenter.viewDidLoad()
    }
    
    func showLoadingView(_ show: Bool) {
        if show {
            LoadingIndicator.shared.show()
        } else {
            LoadingIndicator.shared.hide()
        }
    }
    
    func setUpTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(StartupTableViewCell.self)
    }
    
    func setupStartups(startups: [StartupDetails]) {
        self.startups = startups
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.presenter.router.prepare(for: segue, sender: sender)
    }
    
    //MARK:- StartupListView
    func refreshStartupListView() {
        tableView.reloadData()
        self.errorView.isHidden = true
    }
    
    func showErrorView(_ show: Bool) {
        self.errorView.isHidden = !show
    }
    
    //MARK: Actions
    @IBAction func tryAgainClicked(_ sender: AnyObject) {
        self.presenter.refresh()
    }
    
}

extension StartupsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfStartups
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath) as StartupTableViewCell
        presenter.configure(cell: cell, forRow: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelect(row: indexPath.row)
    }
    
}
