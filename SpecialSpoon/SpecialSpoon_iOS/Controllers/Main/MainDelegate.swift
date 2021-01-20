//
//  MainDelegate.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import UIKit

class MainDelegate: NSObject, UITableViewDelegate {
    private let model: SearchViewModel
    
    init(model: SearchViewModel) {
        self.model = model
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if (offsetY > (contentHeight - (scrollView.frame.height * 4))) {
            model.retrieveNewPage()
        }
    }
}
