//
//  GoalsListViewController.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//

import Foundation

class GoalsListViewController: MVVMViewController<GoalsListViewModel, GoalListView> {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadData()
    }
}

// MARK: Navigation

private extension GoalsListViewController {
    
    func setupUI() {
        title = NSLocalizedString("listName", comment: "")
        bindNavigation()
    }
    
    func bindNavigation() {
        self.navigationController?.navigationBar.tintColor = .accentBodyAdidas
        
        viewModel.navigationHandler = { [weak self] vc in
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        viewModel.showAlertHandler = { [weak self] alert in
            guard let self = self else { return }
            switch alert {
            case .noData:
                alert.show(in: self) { _ in self.viewModel.loadData() }
            case .healthKitAdvisory:
                alert.show(in: self) { _ in self.viewModel.askForHealthAuthorization() }
            }
        }
    }
}
