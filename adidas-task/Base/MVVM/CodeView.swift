//
//  CodeView.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//
//  Definition of a View that can only be created with code.
//
//  Doing this I can be sure will be initiated with the dependencies disabling IB / XIB initializers.
//  Also it reduces the boilerplate code as we will not need to type
//  the required init?(coder aDecoder: NSCoder) in every CodeView.
//  As they are created in code, no need to worry about the coder init.
//

import UIKit

class CodeView: UIView {
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable, message: "This is a CodeView.")
    required init?(coder aDecoder: NSCoder) {
        fatalError("A CodeView should not be initialized with a XIB / SB.")
    }
}
