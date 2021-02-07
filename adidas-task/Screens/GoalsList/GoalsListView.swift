//
//  GoalsListView.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//

import Foundation
import UIKit

class GoalListView: MVVMView<GoalsListViewModel> {
    
    // MARK: Subviews
    
    lazy var tableView = createTableView()

    // MARK: View setup
    
    func setUpView() {
        constructHierarchy()
        activateConstraints()
        bindView()
    }
}

// MARK: View Build

private extension GoalListView {
    
    func constructHierarchy() {
        self.backgroundColor = .backgroundAdidas
        self.addSubview(tableView)
    }
    
    func createTableView() -> UITableView {
        let tv = UITableView(frame: .zero)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.backgroundColor = .clear
        tv.register(GoalCell.self, forCellReuseIdentifier: GoalCell.kCellIdentifier)
        return tv
    }
}

// MARK: Constraints

private extension GoalListView {
    
    func activateConstraints() {
        let constraints = [tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                           tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
                           tableView.widthAnchor.constraint(equalTo: self.widthAnchor),
                           tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: TableViewDelegate & TableViewDataSource

extension GoalListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.goals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GoalCell.kCellIdentifier, for: indexPath)
        if let cell = cell as? GoalCell, viewModel.goals.count > indexPath.row {
            cell.configure(with: viewModel.goals[indexPath.row])
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GoalCell.kProposedMinimalHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.goals.count > indexPath.row else { return }
        viewModel.userDidSelected(viewModel.goals[indexPath.row])
    }
}

// MARK: View Binding

private extension GoalListView {
    
    func bindView() {
        viewModel.reloadTableViewHandler = { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
}
