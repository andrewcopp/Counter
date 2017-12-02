//
//  CountViewController.swift
//  Counter
//
//  Created by Andrew Copp on 11/29/17.
//  Copyright © 2017 Andrew Copp. All rights reserved.
//

import UIKit

class CountViewController: UIViewController {

    let presenter: CountPresenter
        
    init(presenter: CountPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        self.presenter.viewCreated()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.presenter.viewAppeared()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.presenter.viewDisappearing()
    }
    
    func configureView() {
        self.view.backgroundColor = UIColor.white
        
        let plusButton: UIButton = UIButton()
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.setTitle("+", for: UIControlState.normal)
        plusButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        plusButton.titleLabel?.font = plusButton.titleLabel?.font.withSize(100.0)
        plusButton.backgroundColor = UIColor.green
        self.view.addSubview(plusButton)
        
        self.view.addConstraint(NSLayoutConstraint(item: plusButton,
                                                   attribute: NSLayoutAttribute.width,
                                                   relatedBy: NSLayoutRelation.equal,
                                                   toItem: self.view,
                                                   attribute: NSLayoutAttribute.width,
                                                   multiplier: 1.0/3.0,
                                                   constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: plusButton,
                                                   attribute: NSLayoutAttribute.height,
                                                   relatedBy: NSLayoutRelation.equal,
                                                   toItem: plusButton,
                                                   attribute: NSLayoutAttribute.width,
                                                   multiplier: 1.0/1.0,
                                                   constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: plusButton,
                                                   attribute: NSLayoutAttribute.centerX,
                                                   relatedBy: NSLayoutRelation.equal,
                                                   toItem: self.view,
                                                   attribute: NSLayoutAttribute.centerX,
                                                   multiplier: 1.0/1.0,
                                                   constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: plusButton,
                                                   attribute: NSLayoutAttribute.bottom,
                                                   relatedBy: NSLayoutRelation.equal,
                                                   toItem: self.view,
                                                   attribute: NSLayoutAttribute.bottom,
                                                   multiplier: 1.0/1.0,
                                                   constant: -44.0))
        
        plusButton.addTarget(self.presenter,
                             action: #selector(CountPresenter.plusButtonPressed(sender:)),
                             for: UIControlEvents.touchUpInside)
        
        let minusButton: UIButton = UIButton()
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.setTitle("-", for: UIControlState.normal)
        minusButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        minusButton.titleLabel?.font = minusButton.titleLabel?.font.withSize(50.0)
        self.view.addSubview(minusButton)
        
        self.view.addConstraint(NSLayoutConstraint(item: minusButton,
                                                   attribute: NSLayoutAttribute.left,
                                                   relatedBy: NSLayoutRelation.equal,
                                                   toItem: plusButton,
                                                   attribute: NSLayoutAttribute.left,
                                                   multiplier: 1.0/4.0,
                                                   constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: minusButton,
                                                   attribute: NSLayoutAttribute.right,
                                                   relatedBy: NSLayoutRelation.equal,
                                                   toItem: plusButton,
                                                   attribute: NSLayoutAttribute.left,
                                                   multiplier: 3.0/4.0,
                                                   constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: minusButton,
                                                   attribute: NSLayoutAttribute.centerY,
                                                   relatedBy: NSLayoutRelation.equal,
                                                   toItem: plusButton,
                                                   attribute: NSLayoutAttribute.centerY,
                                                   multiplier: 1.0/1.0,
                                                   constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: minusButton,
                                                   attribute: NSLayoutAttribute.height,
                                                   relatedBy: NSLayoutRelation.equal,
                                                   toItem: minusButton,
                                                   attribute: NSLayoutAttribute.width,
                                                   multiplier: 1.0/1.0,
                                                   constant: 0.0))
        
        minusButton.addTarget(self.presenter,
                              action: #selector(CountPresenter.minusButtonPressed(sender:)),
                              for: UIControlEvents.touchUpInside)
        
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        label.font = label.font.withSize(100.0)
        self.view.addSubview(label)
        
        self.view.addConstraint(NSLayoutConstraint(item: label,
                                                   attribute: NSLayoutAttribute.width,
                                                   relatedBy: NSLayoutRelation.equal,
                                                   toItem: self.view,
                                                   attribute: NSLayoutAttribute.width,
                                                   multiplier: 1.0/2.0,
                                                   constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: label,
                                                   attribute: NSLayoutAttribute.height,
                                                   relatedBy: NSLayoutRelation.equal,
                                                   toItem: label,
                                                   attribute: NSLayoutAttribute.width,
                                                   multiplier: 1.0/1.0,
                                                   constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: label,
                                                   attribute: NSLayoutAttribute.centerX,
                                                   relatedBy: NSLayoutRelation.equal,
                                                   toItem: self.view,
                                                   attribute: NSLayoutAttribute.centerX,
                                                   multiplier: 1.0/1.0,
                                                   constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: label,
                                                   attribute: NSLayoutAttribute.top,
                                                   relatedBy: NSLayoutRelation.equal,
                                                   toItem: self.view,
                                                   attribute: NSLayoutAttribute.top,
                                                   multiplier: 1.0/1.0,
                                                   constant: 44.0))
        self.presenter.label = label
        
        let textField: UITextField = UITextField(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 21.0))
        textField.textAlignment = NSTextAlignment.center
        textField.delegate = self.presenter
        self.navigationItem.titleView = textField
        self.presenter.textField = textField
    }
        
}
