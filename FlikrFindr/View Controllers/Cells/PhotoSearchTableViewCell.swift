//
//  PhotoSearchTableViewCell.swift
//  FlikrFindr
//
//  Created by Christelle Lorin on 12/10/19.
//  Copyright © 2019 Chirstelle Lorin. All rights reserved.
//

import Foundation
import UIKit

class PhotoSearchTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak var photoLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!

    // MARK: - Public

    func configure(with photo: Photo) {
        if let label = photoLabel {
            label.text = photo.title
        }

        if let urlString = APIUrlBuilder().createPhotoUrl(photo: photo) {
            photoImageView.downloadImageFromUrl(urlString, photo: photo)
        }
    }
}
