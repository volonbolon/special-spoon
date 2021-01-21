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
    
    var artworkImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        contentView.addSubview(artworkImageView)
    }
    
    private func activateArtworkConstraints() {
        let leadingConstraint = artworkImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                                          constant: 4)
        let topConstraint = artworkImageView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                                  constant: 4)
        let bottomConstraint = artworkImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                                        constant: -4)
        bottomConstraint.priority = .defaultHigh
        let heightConstraint = artworkImageView.heightAnchor.constraint(equalToConstant: 100)
        let widthConstraint = artworkImageView.widthAnchor.constraint(equalToConstant: 100)
        
        let toActivate = [
            leadingConstraint,
            topConstraint,
            bottomConstraint,
            heightConstraint,
            widthConstraint
        ]
        NSLayoutConstraint.activate(toActivate)
    }
    
    private func activateNameLabelConstraints() {
        let leadingConstraint = nameLabel.leadingAnchor.constraint(equalTo: artworkImageView.trailingAnchor, constant: 4)
        let topConstraint = nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4)
        let toActivate = [
            leadingConstraint,
            topConstraint
        ]
        NSLayoutConstraint.activate(toActivate)
    }
    
    private func activatePlayButtonConstraints() {
        let trailingConstraint = playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
        let bottomConstraint = playButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        
        let toActivate = [
            trailingConstraint,
            bottomConstraint
        ]
        
        NSLayoutConstraint.activate(toActivate)
    }
    
    private func activateConstraints() {
        activateArtworkConstraints()
        activateNameLabelConstraints()
        activatePlayButtonConstraints()
    }
}
