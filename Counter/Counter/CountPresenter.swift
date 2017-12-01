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
    var textField: UITextField!
    
    init(interactor: CountInteractor) {
        self.interactor = interactor
    }
    
    func viewCreated() {
        self.label.text = "\(self.interactor.counter.count)"
        
        self.textField.becomeFirstResponder()
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
            self.label.textColor = UIColor.red
            UIView.transition(with: self.label, duration: 0.35, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                self.label.textColor = UIColor.black
            }, completion: { finished in
                self.label.textColor = UIColor.black
            })
        })
    }
    
}

extension CountPresenter: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
