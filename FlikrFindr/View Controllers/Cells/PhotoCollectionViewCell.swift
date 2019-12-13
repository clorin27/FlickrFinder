//
//  PhotoCollectionViewCell.swift
//  FlikrFindr
//
//  Created by Christelle Lorin on 12/7/19.
//  Copyright © 2019 Chirstelle Lorin. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    private let viewModel = PhotoSearchViewModel()

    // MARK: - Outlets

    @IBOutlet fileprivate var photoImageView: UIImageView!
    @IBOutlet fileprivate var photoLabel: UILabel!

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
