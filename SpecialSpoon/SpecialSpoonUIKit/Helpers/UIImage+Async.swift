//
//  UIImage+Async.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 21/01/2021.
//

import UIKit

extension UIImage {
    static func imageFromURL(_ url: URL, completionHandler: @escaping (UIImage?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, _, error) in
            guard let data = data, let downloadedImage = UIImage(data: data) else {
                if let error = error {
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    completionHandler(nil)
                }
                return
            }
            DispatchQueue.main.async {
                completionHandler(downloadedImage)
            }
        }
        task.resume()
    }
}
