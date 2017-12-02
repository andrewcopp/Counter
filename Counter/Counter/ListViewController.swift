//
//  ListViewController.swift
//  Counter
//
//  Created by Andrew Copp on 12/1/17.
//  Copyright © 2017 Andrew Copp. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    let countFactory: CountFactory
    
    let presenter: ListPresenter
    
    init(presenter: ListPresenter, countFactory: CountFactory) {
        self.presenter = presenter
        self.countFactory = countFactory
        super.init(nibName: nil, bundle: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ListViewController.countersDidUpdate(notification:)), name: Notification.Name.init("CounterCountersDidUpdate"), object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.init("CounterCountersDidUpdate"), object: nil)
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
        tableView.delegate = self
        self.presenter.tableView = tableView
        
        let addButton: UIBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ListViewController.addButtonPressed(sender:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        self.presenter.viewCreated()
    }
    
    @objc func countersDidUpdate(notification: Notification) {
        self.presenter.tableView.reloadData()
    }
    
    @objc func addButtonPressed(sender: UIBarButtonItem) {
        let countViewController: CountViewController = self.countFactory.countViewController(identifier: nil)
        self.navigationController?.pushViewController(countViewController, animated: true)
    }
    
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let counter: Counter = self.presenter.interactor.counters()[indexPath.row]
        let countViewController: CountViewController = self.countFactory.countViewController(identifier: counter.identifier)
        self.navigationController?.pushViewController(countViewController, animated: true)
    }
    
}
