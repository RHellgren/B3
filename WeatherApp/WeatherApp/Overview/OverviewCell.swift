//
//  OverviewCell.swift
//  WeatherApp
//
//  Created by Robin Hellgren on 16/03/2024.
//

import UIKit

final class OverviewCell: UITableViewCell {
    private let cityLabel = UILabel()
    private let temperatureLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        make()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func make() {
        makeViews()
        makeLayout()
        makeStyle()
    }
    
    private func makeViews() {
        contentView.addSubview(cityLabel)
        contentView.addSubview(temperatureLabel)
    }
    
    private func makeLayout() {
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor),
            cityLabel.bottomAnchor.constraint(
                equalTo: temperatureLabel.topAnchor),
            cityLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.edgeInsets),
            cityLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.edgeInsets),
            
            temperatureLabel.bottomAnchor.constraint(
                lessThanOrEqualTo: contentView.bottomAnchor),
            temperatureLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.edgeInsets),
            temperatureLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.edgeInsets)
        ])
    }
    
    private func makeStyle() {
        cityLabel.adjustsFontForContentSizeCategory = true
        cityLabel.numberOfLines = Constants.numberOfLines
        cityLabel.font = .preferredFont(
            forTextStyle: .title1,
            compatibleWith: UITraitCollection(legibilityWeight: .bold))
        
        temperatureLabel.adjustsFontForContentSizeCategory = true
        temperatureLabel.numberOfLines = Constants.numberOfLines
        temperatureLabel.font = .preferredFont(
            forTextStyle: .title3)
        temperatureLabel.textColor = Constants.tempTextColor
        
        let accessory = UIImageView(image: Constants.accessoryImage)
        accessory.tintColor = Constants.disclosureTint
        accessoryView = accessory
        
        selectionStyle = .none
    }
    
    func configure(
        with viewModel: OverviewCellViewModel
    ) {
        cityLabel.text = viewModel.cityName
        
        if let temperature = viewModel.temperature {
            temperatureLabel.text = String(localized: "\(temperature) °C")
        } else {
            temperatureLabel.text = Constants.loadingString
        }
    }
}

extension OverviewCell {
    struct Constants {
        static let edgeInsets: CGFloat = 12
        static let numberOfLines = 0
        static let accessoryImage = UIImage(systemName: "chevron.right")
        static let loadingString = String(localized: "Loading...")
        static let tempTextColor = UIColor(named: "SecondaryText")
        static let disclosureTint = UIColor(named: "IconTint")
    }
}

struct OverviewCellViewModel {
    let cityName: String
    let temperature: Float?
}
