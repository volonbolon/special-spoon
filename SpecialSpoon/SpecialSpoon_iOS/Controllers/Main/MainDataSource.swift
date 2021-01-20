//
//  MainDataSource.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import UIKit

class MainDataSource: NSObject, UITableViewDataSource {
    private let model: SearchViewModel
    
    init(model: SearchViewModel) {
        self.model = model
        
        super.init()
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        model.searchResults.count > 0 ? 1 : 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.searchResults.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainView.cellIdentifier,
                                                 for: indexPath)
        
        if let mainCell = cell as? MainTableViewCell {
            let searchResult = model.searchResults[indexPath.row]
            mainCell.nameLabel.text = searchResult.trackName
            mainCell.playButton.addTarget(self,
                                          action: #selector(playButtonWrapper(sender:)),
                                          for: .touchUpInside)
        }
        
        return cell
    }
    
    // Since we choose to expose SearchViewModel in the protocol
    // we cannot flag methods as `objc`
    // thus, we are wrapping the call.
    @IBAction private func playButtonWrapper(sender: UIButton) {
//        guard let responder = model.uxResponder else {
//            return
//        }
//        responder.playButtonTappedSample(sender: sender)
    }
}
