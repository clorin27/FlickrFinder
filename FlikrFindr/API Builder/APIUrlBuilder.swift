//
//  APIUrlBuilder.swift
//  FlikrFindr
//
//  Created by Christelle Lorin on 12/7/19.
//  Copyright © 2019 Chirstelle Lorin. All rights reserved.
//

import Foundation

struct APIUrlBuilder  {

    func createPhotoFetchUrl(photo: Photo) -> URL? {
        return URL(string:"https://farm\(photo.farm).static.flickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg")
    }

    func createSearchUrl(searchTerm: String, page: Int) -> URL? {
        return URL(string: "\(Constants.API.searchURL)&api_key=\(Constants.API.apiKey)&text=\(searchTerm)&per_page=\(page)&format=json&nojsoncallback=1&sort=relevance")
    }
}
