//
//  GoalDetailView.swift
//  adidas-task
//
//  Created by Jaime Domenech on 08/11/2020.
//

import UIKit

class GoalDetailView: MVVMView<GoalDetailViewModel> {
    
    // MARK: Constants
    
    private let kHeaderHeigthComparedToBody: CGFloat = 0.55
    private let kOvelapBodyInPicture: CGFloat = 0.05
    private let kTrophyHeigthComparedToBody: CGFloat = 0.1
    private let kCornerRadius: CGFloat = 28
    private let kTitleFontSize: CGFloat = 48
    private let kSubtitleFontSize: CGFloat = 16
    private let kbodyFontSize: CGFloat = 14
    private let kpointsFontSize: CGFloat = 24
    private let kmarginLeading: CGFloat = 15
    private let kbodySeparationText: CGFloat = 8
    
    // MARK: Subviews
    
    private lazy var headerImageView    = createHeaderImageView()
    private lazy var bodyContainer      = createBodyContainer()
    private lazy var trophyContainer    = createTrophyContainer()
    private lazy var titleLabel         = createTitleLabel()
    private lazy var subtitleLabel      = createSubtitleLabel()
    private lazy var descriptionLabel   = createDescriptionLabel()
    private lazy var goalStatusLabel    = createGoalStatusLabel()
    private lazy var pointsLabel        = createPointsLabel()

    // MARK: View Setup
    
    func setUpView() {
        constructHierarchy()
        activateConstraints()
    }
}

// MARK: View Build

private extension GoalDetailView {
    
    func constructHierarchy() {
        self.backgroundColor = .backgroundAdidas
        self.addSubview(headerImageView)
        self.addSubview(bodyContainer)
        self.addSubview(trophyContainer)
        headerImageView.addSubview(titleLabel)
        bodyContainer.addSubview(subtitleLabel)
        bodyContainer.addSubview(goalStatusLabel)
        bodyContainer.addSubview(descriptionLabel)
        trophyContainer.addSubview(pointsLabel)
    }
    
    func createHeaderImageView() -> UIImageView {
        let iv = UIImageView(frame: .zero)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .clear
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = viewModel.goalType.relatedImage()
        return iv
    }
    
    func createBodyContainer() -> UIView {
        let body = UIView(frame: .zero)
        body.translatesAutoresizingMaskIntoConstraints = false
        body.backgroundColor = .containerAdidas
        body.layer.cornerRadius = kCornerRadius
        body.layer.masksToBounds = true
        return body
    }
    
    func createTrophyContainer() -> UIView {
        let trophy = UIView(frame: .zero)
        trophy.translatesAutoresizingMaskIntoConstraints = false
        trophy.backgroundColor = viewModel.goalType.relatedColor()
        trophy.layer.cornerRadius = kCornerRadius / 2
        trophy.layer.masksToBounds = true
        return trophy
    }
    
    func createTitleLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.goalType.asText()
        label.font = label.font.withSize(kTitleFontSize)
        label.textColor = .accentBodyAdidas
        return label
    }
    
    func createSubtitleLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.goalTitle
        label.font = label.font.withSize(kSubtitleFontSize)
        label.textColor = .regularTitleAdidas
        return label
    }
    
    func createDescriptionLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.goalDescription
        label.numberOfLines = 0
        label.font = label.font.withSize(kbodyFontSize)
        label.textColor = .regularBodyAdidas
        return label
    }
    
    func createGoalStatusLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.goalProgress
        label.font = label.font.withSize(kbodyFontSize)
        label.textColor = .regularTitleAdidas
        return label
    }
    
    func createPointsLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(viewModel.goalPoints) points // \(viewModel.goalThropy)"
        label.font = label.font.withSize(kpointsFontSize)
        label.textColor = .accentBodyAdidas
        return label
    }
}

// MARK: Constraints

private extension GoalDetailView {
    
    func activateConstraints() {
        let constraints = [headerImageView.topAnchor.constraint(equalTo: self.topAnchor),
                           headerImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                           headerImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                           headerImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: kHeaderHeigthComparedToBody),
                           bodyContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                           bodyContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                           bodyContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                           bodyContainer.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: kHeaderHeigthComparedToBody + kOvelapBodyInPicture),
                           trophyContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: kCornerRadius),
                           trophyContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                           trophyContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                           trophyContainer.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: kTrophyHeigthComparedToBody + kOvelapBodyInPicture),
                           titleLabel.centerYAnchor.constraint(equalTo: headerImageView.centerYAnchor, constant: -kTitleFontSize),
                           titleLabel.centerXAnchor.constraint(equalTo: headerImageView.centerXAnchor),
                           subtitleLabel.topAnchor.constraint(equalTo: bodyContainer.topAnchor, constant: kCornerRadius),
                           subtitleLabel.leadingAnchor.constraint(equalTo: bodyContainer.leadingAnchor, constant: kmarginLeading),
                           goalStatusLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: kbodySeparationText),
                           goalStatusLabel.leadingAnchor.constraint(equalTo: bodyContainer.leadingAnchor, constant: kmarginLeading),
                           descriptionLabel.topAnchor.constraint(equalTo: goalStatusLabel.bottomAnchor, constant: 2 * kbodySeparationText),
                           descriptionLabel.leadingAnchor.constraint(equalTo: bodyContainer.leadingAnchor, constant: kmarginLeading),
                           descriptionLabel.trailingAnchor.constraint(equalTo: bodyContainer.trailingAnchor, constant: -kmarginLeading),
                           pointsLabel.topAnchor.constraint(equalTo: trophyContainer.topAnchor, constant: 2 * kbodySeparationText),
                           pointsLabel.centerXAnchor.constraint(equalTo: trophyContainer.centerXAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
}
