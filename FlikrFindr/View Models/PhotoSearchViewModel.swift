//
//  PhotoSearchViewModel.swift
//  FlikrFindr
//
//  Created by Christelle Lorin on 12/7/19.
//  Copyright © 2019 Chirstelle Lorin. All rights reserved.
//

import UIKit

class PhotoSearchViewModel {

    // MARK: Properties

    var dataSource = [Photo]()

    private let apiBuilder = APIUrlBuilder()

    // MARK: Public

    func returnNumberOfItems() -> Int {
        return dataSource.count
    }

    // MARK: Search Photos Data

    func loadPhotosData(searchTerm: String, page: Int, perPage: Int, completionHandler: ((Error?) -> Void)?) {
        guard let url = apiBuilder.createSearchUrl(searchTerm: searchTerm, page: page, perPage: perPage) else { return }
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
                let searchResponse = try decoder.decode(SearchResults.self, from: data)

                self.dataSource = searchResponse.photos.photo

                completionHandler?(nil)
            } catch {
                print(error)
            }
        }.resume()
    }
}
