//
//  CountFactory.swift
//  Counter
//
//  Created by Andrew Copp on 12/1/17.
//  Copyright © 2017 Andrew Copp. All rights reserved.
//

import Foundation

class CountFactory {
    
    let coreData: CoreData
    
    init(coreData: CoreData) {
        self.coreData = coreData
    }
    
    func countViewController(identifier: Int?) -> CountViewController {
        let countInteractor: CountInteractor = CountInteractor(identifier: identifier, coreData: self.coreData)
        let countPresenter: CountPresenter = CountPresenter(interactor: countInteractor)
        let countViewController: CountViewController = CountViewController(presenter: countPresenter)
        return countViewController
    }
    
}
