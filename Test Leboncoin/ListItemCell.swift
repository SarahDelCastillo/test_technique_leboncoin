//
//  ListItemViewCell.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 20/01/2024.
//

import UIKit

final class ListItemCell: UITableViewCell {

    private var asyncImageView = AsyncUIImageView(forAutoLayout: true)
    private var titleLabel = UILabel(forAutoLayout: true)
    private var priceLabel = UILabel(forAutoLayout: true)
    private var categoryLabel = UILabel(forAutoLayout: true)
    private var urgentLabel = UILabel(forAutoLayout: true)

    private var imageLoadingTask: Task<Void, Error>?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupImageView()
        setupUrgentLabel()
        setupPriceLabel()
        setupCategoryLabel()
        setupTitleLabel()
    }

    override func prepareForReuse() {
        asyncImageView.image = nil
        imageLoadingTask?.cancel()
    }

    func setupContent(with item: ListItem) {
        titleLabel.text = item.title
        priceLabel.text = formattedPrice(price: item.price)
        categoryLabel.text = item.category
        urgentLabel.isHidden = !item.urgent
        if let imageURL = item.image {
            imageLoadingTask = asyncImageView.load(from: imageURL)
        } else {
            asyncImageView.image = UIImage(named: "placeholder")
        }
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
        contentView.addSubview(asyncImageView)
        asyncImageView.layer.cornerRadius = 10
        asyncImageView.clipsToBounds = true
        asyncImageView.contentMode = .scaleAspectFill

        let aspectRatio = NSLayoutConstraint(item: asyncImageView, attribute: .width, relatedBy: .equal, toItem: asyncImageView, attribute: .height, multiplier: 2, constant: 0)
        asyncImageView.addConstraint(aspectRatio)

        NSLayoutConstraint.activate([
            asyncImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            asyncImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            asyncImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -16),

        ])
    }

    private func setupPriceLabel() {
        contentView.addSubview(priceLabel)
        priceLabel.font = .systemFont(ofSize: 16, weight: .medium)

        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: asyncImageView.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
    }

    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: 14, weight: .light)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    private func setupCategoryLabel() {
        contentView.addSubview(categoryLabel)
        priceLabel.font = .systemFont(ofSize: 16, weight: .medium)

        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: asyncImageView.bottomAnchor, constant: 8),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    private func setupUrgentLabel() {

        contentView.addSubview(urgentLabel)
        urgentLabel.backgroundColor = .cyan
        urgentLabel.layer.cornerRadius = 8
        urgentLabel.clipsToBounds = true
        urgentLabel.text = " Urgent "
        urgentLabel.textColor = .black
        urgentLabel.font = .systemFont(ofSize: 14, weight: .medium)

        NSLayoutConstraint.activate([
            urgentLabel.topAnchor.constraint(equalTo: asyncImageView.topAnchor, constant: 8),
            urgentLabel.leadingAnchor.constraint(equalTo: asyncImageView.leadingAnchor, constant: 8),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
