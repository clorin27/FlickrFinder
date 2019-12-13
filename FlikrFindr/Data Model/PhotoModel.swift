//
//  PhotoModel.swift
//  FlikrFindr
//
//  Created by Christelle Lorin on 12/9/19.
//  Copyright © 2019 Chirstelle Lorin. All rights reserved.
//

import Foundation

struct SearchResults: Codable {
    let stat: String
    let photos: Photos
}

//Due to the API not camel casing certain keys, I chose to decode for model best practices.  

struct Photos: Codable {
    let page: Int
    let pages: Int
    let perPage: Int
    let total: String
    let photo: [Photo]

    enum CodingKeys: String, CodingKey {
        case page, pages, total, photo
        case perPage = "perpage"
    }
}

extension Photos {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        page = try container.decode(Int.self, forKey: .page)
        pages = try container.decode(Int.self, forKey: .pages)
        perPage = try container.decode(Int.self, forKey: .perPage)
        total = try container.decode(String.self, forKey: .total)
        photo = try container.decode([Photo].self, forKey: .photo)
    }
}

struct Photo: Codable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let isPublic: Int
    let isFriend: Int
    let isFamily: Int

    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title
        case isPublic = "ispublic"
        case isFriend = "isfriend"
        case isFamily = "isfamily"
    }
}

extension Photo {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        owner = try container.decode(String.self, forKey: .owner)
        secret = try container.decode(String.self, forKey: .secret)
        server = try container.decode(String.self, forKey: .server)
        farm = try container.decode(Int.self, forKey: .farm)
        title = try container.decode(String.self, forKey: .title)
        isPublic = try container.decode(Int.self, forKey: .isPublic)
        isFriend = try container.decode(Int.self, forKey: .isFriend)
        isFamily = try container.decode(Int.self, forKey: .isFamily)
    }
}
