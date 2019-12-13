//
//  PhotoSearchViewModel.swift
//  FlikrFindr
//
//  Created by Christelle Lorin on 12/7/19.
//  Copyright © 2019 Chirstelle Lorin. All rights reserved.
//

import UIKit

class PhotoSearchViewModel {

    // MARK: - Properties

    private let dataSource = NetworkDataSource()
    var delegate: ViewModelDisplayDelegate?

    init() {
        dataSource.delegate = self
    }

    // MARK: - Public

    public func data() -> [Photo]? {
        return dataSource.data
    }

    public func refresh(searchTerm: String?) {
        if let searchTerm = searchTerm {
            dataSource.searchTerm = searchTerm
        }

        dataSource.refresh()
    }

    public func empty() {
        dataSource.empty()
    }

    public func searchTerm() -> String? {
        return dataSource.searchTerm
    }

    public func numberOfRows() -> Int? {
        guard let data = dataSource.data else { return nil }

        return data.count
    }

    public func estimatedHeightForRow() -> CGFloat {
        return 200
    }
}

extension PhotoSearchViewModel: NetworkingDataSourceDelegate {
    func refreshedState(state: NetworkDataSourceState) {
        switch state {
        case .data:
            delegate?.displayData()
        case .empty:
            delegate?.displayEmpty()
        case .error(let error):
            delegate?.displayError(errorMessage: error.localizedDescription )
        default:
            break
        }
    }
}
