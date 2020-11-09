//
//  MVVMViewController.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//
//  Just a ViewController that can't be created with Xib and force to have a ViewModel & MVVMView.
//
//  After initialize it with a viewModel, the VC will generate his View and inject
//  the viewModel to the view.
//
//

import UIKit

class MVVMViewController<ViewModelType, ViewType: MVVMView<ViewModelType>>: CodeViewController {
    
    let viewModel: ViewModelType
    
    // MARK: - Methods
    init(viewModel: ViewModelType) {
        self.viewModel = viewModel
        super.init()
    }

    override func loadView() {
        view = ViewType(viewModel: viewModel)
    }
}
