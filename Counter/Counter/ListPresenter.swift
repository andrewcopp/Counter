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
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ListCell")
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
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        cell.textLabel?.text = self.interactor.counters()[indexPath.row].title
        return cell
    }
    
}

extension ListPresenter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
}
