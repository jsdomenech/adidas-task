//
//  GoalCell.swift
//  adidas-task
//
//  Created by Jaime Domenech on 08/11/2020.
//

import UIKit

class GoalCell: UITableViewCell {
    
    // MARK: Static
    
    static let kCellIdentifier = "GoalCell"
    static let kProposedMinimalHeight: CGFloat = 200
    
    // MARK: Constants
    
    private let kCornerRadius: CGFloat = 28
    private let kCellMargin: CGFloat = 24
    private let kHeaderHeigthComparedToBody: CGFloat = 0.55
    private let kTitleFontSize: CGFloat = 20
    private let kSubtitleFontSize: CGFloat = 16
    private let kMarginTexts: CGFloat = 5
    
    // MARK: Subviews
    
    private lazy var cellBody = createCellBody()
    private lazy var headerImage = createHeaderImage()
    private lazy var titleLabel = createTitleLabel()
    private lazy var subtitleLabel = createSubtitleLabel()
    
    // MARK: LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        buildCellView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: View Build

private extension GoalCell {
    
    func createCellBody() -> UIView {
        let body = UIView(frame: .zero)
        body.translatesAutoresizingMaskIntoConstraints = false
        body.layer.cornerRadius = kCornerRadius
        body.layer.masksToBounds = true
        body.backgroundColor = .containerAdidas
        return body
    }
    
    func createHeaderImage() -> UIImageView {
        let iv = UIImageView(frame: .zero)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .clear
        iv.contentMode = .center
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "walk")
        return iv
    }
    
    func createTitleLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(kTitleFontSize)
        label.textColor = .walkAdidas
        return label
    }
    
    func createSubtitleLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(kSubtitleFontSize)
        label.textColor = .regularTitleAdidas
        return label
    }
    
    
    func buildCellView() {
        self.addSubview(cellBody)
        cellBody.addSubview(headerImage)
        cellBody.addSubview(titleLabel)
        cellBody.addSubview(subtitleLabel)
        addConstraints()
    }
    
    
}

// MARK: Contraints

private extension GoalCell {
    
    func addConstraints() {
        let constraints = [cellBody.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: kCellMargin),
                           cellBody.topAnchor.constraint(equalTo: self.topAnchor, constant: kCellMargin / 2),
                           cellBody.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(kCellMargin / 2)),
                           cellBody.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -kCellMargin),
                           headerImage.topAnchor.constraint(equalTo: cellBody.topAnchor),
                           headerImage.leadingAnchor.constraint(equalTo: cellBody.leadingAnchor),
                           headerImage.trailingAnchor.constraint(equalTo: cellBody.trailingAnchor),
                           headerImage.heightAnchor.constraint(equalTo: cellBody.heightAnchor, multiplier: kHeaderHeigthComparedToBody),
                           titleLabel.topAnchor.constraint(equalTo: headerImage.bottomAnchor, constant: kCellMargin/2),
                           titleLabel.leadingAnchor.constraint(equalTo: cellBody.leadingAnchor, constant: kCellMargin),
                           subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: kMarginTexts),
                           subtitleLabel.leadingAnchor.constraint(equalTo: cellBody.leadingAnchor, constant: kCellMargin)]
        
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: Configurator

extension GoalCell {
    
    func configure(with goal: Goal) {
        headerImage.image = goal.goalType.relatedImage()
        subtitleLabel.text = goal.title
        titleLabel.textColor = goal.goalType.relatedColor()
        titleLabel.text = goal.goalType.asText()
    }
}
