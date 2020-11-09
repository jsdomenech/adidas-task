//
//  CodeViewController.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//
//  Definition of a ViewController that can only be created with code.
//
//  Doing this we can be sure it will be initiated with all the required dependencies
//  as we disabled IB / XIB initializers.
//  Adding after with property injection is ok, but you can forget some dependency.
//
//

import UIKit

class CodeViewController: UIViewController {
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "This is a CodeViewController")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable, message: "This is a CodeViewController")
    required init?(coder aDecoder: NSCoder) {
        fatalError("A CodeViewController should not be initialized with a XIB / SB.")
    }
}
