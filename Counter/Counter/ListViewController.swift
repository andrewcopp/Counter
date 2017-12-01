//
//  ListViewController.swift
//  Counter
//
//  Created by Andrew Copp on 12/1/17.
//  Copyright © 2017 Andrew Copp. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    let presenter: ListPresenter
    
    init(presenter: ListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(tableView)
        
        let options: NSLayoutFormatOptions = []
        let metrics: [String : Any]? = [:]
        let views: [String : Any] = ["tableView" : tableView]
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: options, metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: options, metrics: metrics, views: views))
        
        tableView.dataSource = self.presenter
        tableView.delegate = self.presenter
        self.presenter.tableView = tableView
        
        self.presenter.viewCreated()
    }

    
    
}