//
//  DataSource.swift
//  FlikrFindr
//
//  Created by Christelle Lorin on 12/11/19.
//  Copyright © 2019 Chirstelle Lorin. All rights reserved.
//

import Foundation

/// The DataSource retains the data and vends it to the View Controller
public protocol DataSource: AnyObject {
    /// Does the data source contain no data
    var isEmpty: Bool { get }
}
