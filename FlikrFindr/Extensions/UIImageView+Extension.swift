//
//  UIImageView+Extension.swift
//  FlikrFindr
//
//  Created by Christelle Lorin on 12/7/19.
//  Copyright © 2019 Chirstelle Lorin. All rights reserved.
//

import UIKit

extension UIImageView {

    func cacheImages(with photo: Photo) -> UIImage? {
        let cache = NSCache<NSString, UIImage>()
        let apiBuilder = APIUrlBuilder()

        guard let key = apiBuilder.createPhotoUrl(photo: photo) else { return nil }

        let cachedPhotos = cache.object(forKey: NSString(string:key))

        return cachedPhotos
    }

    func downloadImageFromUrl(_ url: String, photo: Photo, placeholder: UIImage? = UIImage(named: Constants.Image.imagePlaceholder)) {
        guard let imageUrl = URL(string:url) else { return }

        if let cachedImage = cacheImages(with: photo) {
            self.image = cachedImage
            return
        }

        URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in
            if let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200, let data = data, error == nil, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.image = placeholder
                }
            }
        }).resume()
    }
}


