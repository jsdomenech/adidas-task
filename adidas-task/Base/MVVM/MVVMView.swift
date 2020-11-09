//
//  MVVMView.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//
//
//  Just a View that must be done in code and force to have a ViewModel.
//  They view must have a setUpView() method propose for MVVMViewCandidate.
//  And will be the one called after they view is moved to a window. To 'setup'
//  the view after.
//
//

import UIKit

typealias MVVMView<T> = MVVMViewCandidate & VMView<T>

class VMView<ViewModelType>: CodeView{

    // MARK: Properties
    
    let viewModel: ViewModelType
    private var viewReady = false


    // MARK: - Initializer
    
    required init(frame: CGRect = .zero,
         viewModel: ViewModelType) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }

    // MARK: - Setup
    
    final override func didMoveToWindow() {
        super.didMoveToWindow()
        
        guard !viewReady, let view = self as? MVVMViewCandidate else {
            return
        }
        
        view.setUpView()
        
        viewReady = true
    }
}

protocol MVVMViewCandidate: CodeView{
    func setUpView()
}
