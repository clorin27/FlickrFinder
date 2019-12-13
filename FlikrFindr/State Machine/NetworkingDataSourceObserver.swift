//
//  NetworkingDataSourceObserver.swift
//  FlikrFindr
//
//  Created by Christelle Lorin on 12/11/19.
//  Copyright © 2019 Chirstelle Lorin. All rights reserved.
//

import Foundation

protocol NetworkingDataSourceDelegate: AnyObject {
    func refreshedState(state: NetworkDataSource.State)
}

protocol ViewModelDisplayDelegate: AnyObject {
    func displayData()
    func displayError()
    func displayEmpty()
}
