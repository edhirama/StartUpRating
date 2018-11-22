//
//  StartUpsListViewController.swift
//  StartUpRating
//
//  Created by Edgar Hirama on 21/11/18.
//  Copyright © 2018 Edgar. All rights reserved.
//

import UIKit

class StartUpsListViewController: UIViewController, StartUpListView {
 

    @IBOutlet weak var tableView: UITableView!
    var startups: [StartupDetails]?
    
    var configurator = StartUpsListConfiguratorImplementation()
    var presenter: StartUpListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        configurator.configure(startUpsListViewController: self)
        presenter.viewDidLoad()
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
    
    //MARK:- StartUpListView
    func refreshStartUpListView() {
        tableView.reloadData()
    }
    
    func displayStartUpsRetrievalError(title: String, message: String) {
        //TODO
        
        print("displayStartUpsRetrievalError")
    }
    
}

extension StartUpsListViewController: UITableViewDataSource, UITableViewDelegate {
    
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
