//
//  DetailsView.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import UIKit
import WebKit

class DetailsView: NiblessView {
    private var hierarchyNotReady = true
    private let url: URL
    
    var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        return webView
    }()
    
    init(url: URL) {
        self.url = url
        
        super.init(frame: .zero)
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: window)
        
        guard hierarchyNotReady, newWindow != nil else {
            return
        }
        
        constructHierarchy()
        activateConstraints()
        
        self.hierarchyNotReady = false
    }
    
    override func didMoveToSuperview() {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension DetailsView { // MARK: - Helpers
    private func constructHierarchy() {
        addSubview(webView)
    }
    
    private func activateWebViewConstraints() {
        let widthConstraint = webView.widthAnchor.constraint(equalTo: widthAnchor)
        let heightConstraint = webView.heightAnchor.constraint(equalTo: heightAnchor)
        let centerXConstraint = webView.centerXAnchor.constraint(equalTo: centerXAnchor)
        let centerYConstraint = webView.centerYAnchor.constraint(equalTo: centerYAnchor)

        let toActivate = [
            widthConstraint,
            heightConstraint,
            centerXConstraint,
            centerYConstraint
        ]
        
        NSLayoutConstraint.activate(toActivate)
    }
    
    private func activateConstraints() {
        activateWebViewConstraints()
    }
}
