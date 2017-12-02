//
//  ListPresenter.swift
//  Counter
//
//  Created by Andrew Copp on 12/1/17.
//  Copyright © 2017 Andrew Copp. All rights reserved.
//

import Foundation
import UIKit

class ListPresenter: NSObject {
    
    let interactor: ListInteractor
    
    var tableView: UITableView!
    
    init(interactor: ListInteractor) {
        self.interactor = interactor
    }
    
    func viewCreated() {
        self.tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListCell")
        
        self.interactor.synchronize()
    }
    
}

extension ListPresenter: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interactor.counters().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell
        let counter: Counter = self.interactor.counters()[indexPath.row]
        cell.textLabel?.text = counter.title
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.countLabel.text = "\(counter.count)"
        return cell
    }
    
}
