//
//  PhotoSearchDetailViewController.swift
//  FlikrFindr
//
//  Created by Christelle Lorin on 12/7/19.
//  Copyright © 2019 Chirstelle Lorin. All rights reserved.
//

import UIKit

class PhotoSearchDetailViewController: UIViewController {

    // MARK: - Instantiate

    static func instantiatePhotoSearchDetailVC(photo: Photo?) -> PhotoSearchDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "PhotoSearchDetailViewController") as! PhotoSearchDetailViewController
        detailVC.photo = photo

        return detailVC
    }

    // MARK: Properties

    var photo: Photo?

    // MARK: - Outlets

    @IBOutlet weak var photoDetailImageView: UIImageView! {
        didSet {
            configureDetail()
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = photo?.title
    }

    // MARK: - Private

    private func configureDetail() {
        guard let photo = photo else { return }

        if let imageURL = APIUrlBuilder().createPhotoUrl(photo: photo) {
            photoDetailImageView.downloadImageFromUrl(imageURL, photo: photo)
        }
    }
}
