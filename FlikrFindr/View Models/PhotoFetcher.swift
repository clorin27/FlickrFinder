//
//  PhotoFetcher.swift
//  FlikrFindr
//
//  Created by Christelle Lorin on 12/7/19.
//  Copyright © 2019 Chirstelle Lorin. All rights reserved.
//

import Foundation

class PhotoFetcher {

    // MARK: - Properties

    var photoResult = [Photo]()

    private let apiBuilder = APIUrlBuilder()

    // MARK: - Fetch Photos

    func fetchPhoto(photo: Photo, completionHandler: ((Error?) -> Void)?) {
        guard let url = apiBuilder.createPhotoFetchUrl(photo: photo) else { return }
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                guard let data = data, let _ = response, error == nil else {
                    if let error = error {
                        completionHandler?(error)
                    }
                    return
                }

                let decoder = JSONDecoder()
                let photoResponse = try decoder.decode(Photos.self, from: data)

                self.photoResult = photoResponse.photo

                completionHandler?(nil)
            } catch {
                print(error)
            }
        }.resume()
    }
}
