//
//  ListItemViewCell.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 20/01/2024.
//

import UIKit

final class ListItemCell: UITableViewCell {
    private var itemImageView = ItemImageView(forAutoLayout: true)
    private var titleLabel = UILabel(forAutoLayout: true)
    private var priceLabel = UILabel(forAutoLayout: true)
    private var dateLabel = UILabel(forAutoLayout: true)
    private var categoryLabel = UILabel(forAutoLayout: true)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupImageView()
        setupPriceLabel()
        setupCategoryLabel()
        setupTitleLabel()
        setupDateLabel()
    }

    func setupContent(with item: ListItem) {
        titleLabel.text = item.title
        priceLabel.text = formattedPrice(price: item.price)
        categoryLabel.text = item.category
        dateLabel.text = item.date
        itemImageView.imageURL = item.image
        itemImageView.urgent = item.urgent
    }

    private func formattedPrice(price: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        return if let formattedPrice = numberFormatter.string(from: NSNumber(value: price)) {
            "\(formattedPrice) €"
        } else {
            ""
        }
    }

    private func setupImageView() {
        contentView.addSubview(itemImageView)

        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            itemImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -16),

        ])
    }

    private func setupPriceLabel() {
        contentView.addSubview(priceLabel)
        priceLabel.font = .systemFont(ofSize: 16, weight: .medium)

        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
    }

    private func setupDateLabel() {
        contentView.addSubview(dateLabel)
        dateLabel.font = .systemFont(ofSize: 14, weight: .light)

        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: 14, weight: .light)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    private func setupCategoryLabel() {
        contentView.addSubview(categoryLabel)
        priceLabel.font = .systemFont(ofSize: 16, weight: .medium)

        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 8),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
