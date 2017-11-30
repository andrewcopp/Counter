//
//  CountPresenter.swift
//  Counter
//
//  Created by Andrew Copp on 11/29/17.
//  Copyright © 2017 Andrew Copp. All rights reserved.
//

import Foundation
import UIKit

class CountPresenter: NSObject {
    
    let interactor: CountInteractor
    
    var label: UILabel!
    
    init(interactor: CountInteractor) {
        self.interactor = interactor
    }
    
    @objc func plusButtonPressed(sender: UIButton) {
        self.interactor.increment() { count in
            self.label.text = "\(count)"
        }
    }
    
    @objc func minusButtonPressed(sender: UIButton) {
        self.interactor.decrement(success: { count in
            self.label.text = "\(count)"
        }, failure: { error in
            
        })
    }
    
}
