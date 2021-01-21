//
//  MainDataSource.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import UIKit

class MainDataSource: NSObject, UITableViewDataSource {
    private let model: SearchViewModel
    private let imageCache: NSCache<NSString, UIImage>
    
    init(model: SearchViewModel) {
        self.model = model
        self.imageCache = NSCache()
        
        super.init()
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        model.searchResults.count > 0 ? 1 : 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.searchResults.count
    }
    
    private func processImage(artwork: String,
                              cell: MainTableViewCell,
                              tableView: UITableView,
                              indexPath: IndexPath) {
        if let cachedImage = imageCache.object(forKey: artwork as NSString) {
            cell.artworkImageView.image = cachedImage
        } else {
            if let url = URL(string: artwork) {
                UIImage.imageFromURL(url) { (image) in
                    if let image = image {
                        self.imageCache.setObject(image, forKey: artwork as NSString)
                    }
                    if let cell = tableView.cellForRow(at: indexPath) as? MainTableViewCell {
                        cell.artworkImageView.image = image
                    }
                }
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainView.cellIdentifier,
                                                 for: indexPath)
        
        if let mainCell = cell as? MainTableViewCell {
            let searchResult = model.searchResults[indexPath.row]
            mainCell.nameLabel.text = searchResult.trackName
            mainCell.artistLabel.text = searchResult.artistName
            mainCell.playButton.addTarget(model.uxResponder,
                                          action: #selector(MainUXResponder.playSampleButtonTapped(sender:)),
                                          for: .touchUpInside)
            processImage(artwork: searchResult.artworkUrl100,
                         cell: mainCell,
                         tableView: tableView,
                         indexPath: indexPath)
        }
        
        return cell
    }
}
