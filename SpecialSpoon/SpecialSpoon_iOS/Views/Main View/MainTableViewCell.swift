//
//  MainTableViewCell.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    private var hierarchyNotReady = true
    
    var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    var playButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        let buttonTitle = NSLocalizedString("Play", comment: "Play")
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    public override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: window)
        
        guard hierarchyNotReady, newWindow != nil else {
            return
        }
        
        constructHierarchy()
        activateConstraints()
        
        self.hierarchyNotReady = false
    }
}

extension MainTableViewCell { // MARK: - Helpers
    private func constructHierarchy() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(playButton)
    }
    
    private func activateNameLabelConstraints() {
        let leadingConstraint = nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4)
        let topConstraint = nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4)
        let toActivate = [
            leadingConstraint,
            topConstraint
        ]
        NSLayoutConstraint.activate(toActivate)
    }
    
    private func activatePlayButtonConstraints() {
        let centerXConstraint = playButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        let topConstraint = playButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4)
        let bottomConstraint = playButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        
        let toActivate = [
            centerXConstraint,
            topConstraint,
            bottomConstraint
        ]
        
        NSLayoutConstraint.activate(toActivate)
    }
    
    private func activateConstraints() {
        activateNameLabelConstraints()
        activatePlayButtonConstraints()
    }
}
