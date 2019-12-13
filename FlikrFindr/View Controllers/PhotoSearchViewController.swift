//
//  PhotoSearchViewController.swift
//  FlikrFindr
//
//  Created by Christelle Lorin on 12/7/19.
//  Copyright © 2019 Chirstelle Lorin. All rights reserved.
//

import UIKit

class PhotoSearchViewController: UIViewController {

    // MARK: - Constants

    fileprivate struct LocalizedKeys {
        static let SearchBarPlaceholderLabel = "SearchBarPlaceholder"
        static let ErrorTitleLabel = "ErrorTitle"
        static let EmptyErrorLabel = "EmptyError"
    }

    // MARK: - Properties

    private var viewModel = PhotoSearchViewModel()

    private let searchController = UISearchController()

    private let refreshControl = UIRefreshControl()

    // MARK: - Outlets

    @IBOutlet weak var photoTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        updateTableView()
    }

    // MARK: Private

    private func updateTableView() {
        photoTableView.delegate = self
        photoTableView.dataSource = self

        viewModel.delegate = self

        addRefreshControl()
        createSearchController()
    }

    // MARK: UIRefreshControl

    private func addRefreshControl() {
        photoTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)

        photoTableView.addSubview(refreshControl)
    }

    @objc private func refresh() {
        viewModel.refresh(searchTerm: viewModel.searchTerm())
    }

    // MARK: UISearchController

    private func createSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self

        searchController.searchBar.tintColor = .label
        searchController.searchBar.barTintColor = .label
        searchController.searchBar.placeholder = NSLocalizedString(LocalizedKeys.SearchBarPlaceholderLabel, comment: "")
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false

        navigationItem.titleView = searchController.searchBar

        definesPresentationContext = true
    }
}


// MARK: - Table View Delegate

extension PhotoSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfRows = viewModel.numberOfRows() else { return 0 }

        return numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = viewModel.data() else { return UITableViewCell() }

        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Reuse.reuseIdentifier, for: indexPath)
        let photoResults = data[indexPath.row]

        if let cell = cell as? PhotoSearchTableViewCell {
            cell.configure(with: photoResults)
        }

        return cell
    }
}

// MARK: - Search Results Updater

extension PhotoSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text,
            searchText.isEmpty == false else { return }
        viewModel.refresh(searchTerm: searchText)
    }
}


// MARK: - Table View Data Source

extension PhotoSearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = viewModel.data(), data.count > 0 else { return }
        let photo = data[indexPath.row]
        let detailVC = PhotoSearchDetailViewController.instantiatePhotoSearchDetailVC(photo: photo)

        navigationController?.pushViewController(detailVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.estimatedHeightForRow()
    }
}


// MARK: - Search Bar Delegate

extension PhotoSearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        emptyView.isHidden = false 
        viewModel.empty()
        photoTableView.reloadData()
    }
}


// MARK: - View Model Display Delegate

extension PhotoSearchViewController: ViewModelDisplayDelegate {
    func displayError(errorMessage: String) {
        DispatchQueue.main.async { [weak self] in
            let alertController = UIAlertController(title: NSLocalizedString(LocalizedKeys.ErrorTitleLabel, comment: ""), message: errorMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self?.present(alertController, animated: false, completion: nil)
        }
    }

    func displayData() {
        DispatchQueue.main.async { [weak self] in
            self?.photoTableView.isHidden = false
            self?.emptyView.isHidden = true

            if self?.refreshControl.isRefreshing == true {
                self?.refreshControl.endRefreshing()
            }
            self?.photoTableView.reloadData()
        }
    }

    func displayEmpty() {
        DispatchQueue.main.async { [weak self] in
            self?.photoTableView.isHidden = true
            self?.emptyView.isHidden = false

            let alertController = UIAlertController(title: NSLocalizedString(LocalizedKeys.ErrorTitleLabel, comment: ""), message: NSLocalizedString(LocalizedKeys.EmptyErrorLabel, comment: ""), preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self?.present(alertController, animated: false, completion: nil)
        }
    }
}
