//
//  OverviewTableViewController.swift
//  WeatherApp
//
//  Created by Robin Hellgren on 16/03/2024.
//

import UIKit

final class OverviewTableViewController: UITableViewController {
    
    private var viewModel: OverviewViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.title
        
        setupTableView()
        setupViewModel()
        fetchData()
    }
    
    // MARK: - Setup viewModel
    
    private func setupViewModel() {
        viewModel = OverviewViewModel() {
            Task { @MainActor [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Setup tableView
    
    private func setupTableView() {
        tableView.register(OverviewCell.self, forCellReuseIdentifier: Constants.cellReuseIdentifier)
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = Constants.separatorInset
    }
    
    // MARK: - Fetch data
    
    private func fetchData() {
        Task {
            do {
                try await viewModel?.fetchData()
            } catch {
                showError()
            }
        }
    }
    
    @MainActor
    private func showError() {
        let alert = UIAlertController(
            title: Constants.Alert.title,
            message: Constants.Alert.message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: Constants.Alert.buttonTitle,
            style: .default
        ))
        self.present(
            alert,
            animated: true,
            completion: nil
        )
    }
    
    // MARK: - TableView overrides
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel?.cellViewModels.count ?? 0
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cellViewModel = viewModel?.cellViewModels[safe: indexPath.row],
              let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.cellReuseIdentifier,
                for: indexPath) as? OverviewCell
        else {
            return UITableViewCell()
        }
        
        cell.configure(with: cellViewModel)
        return cell
    }
}

extension OverviewTableViewController {
    struct Constants {
        static let title = String(localized: "Weather")
        static let cellReuseIdentifier = "OverviewCell"
        static let estimatedRowHeight: CGFloat = 300
        static let separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        
        struct Alert {
            static let title = String(localized: "Something went wrong")
            static let message = String(localized: "Unable to fetch weather data, please try again later")
            static let buttonTitle = String(localized: "OK")
        }
    }
}
