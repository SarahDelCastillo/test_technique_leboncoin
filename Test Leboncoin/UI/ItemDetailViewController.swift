//
//  ItemDetailViewController.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 22/01/2024.
//

import UIKit

class ItemDetailViewController: UIViewController {
    private let itemImageView = ItemImageView(forAutoLayout: true)
    private var imageLoadingTask: Task<Void, Error>?
    private let dateLabel = UILabel(forAutoLayout: true)
    private let titleTextView = UITextView(forAutoLayout: true)
    private let priceLabel = UILabel(forAutoLayout: true)
    private let descriptionTextView = UITextView(forAutoLayout: true)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupImageView()
        setupTitleLabel()
        setupPriceLabel()
        setupDateLabel()
        setupDescriptionTextField()
    }

    func setupWithItem(_ item: ListItem) {
        itemImageView.imageURL = item.image
        itemImageView.urgent = item.urgent
        dateLabel.text = item.date
        titleTextView.text = item.title
        priceLabel.text = item.price.asFormattedPrice
        descriptionTextView.text = item.description
    }

    private func setupImageView() {
        view.addSubview(itemImageView)

        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            itemImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            itemImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -16),

        ])
    }

    private func setupDateLabel() {
        view.addSubview(dateLabel)

        dateLabel.font = .systemFont(ofSize: 14, weight: .light)

        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8)
        ])
    }

    private func setupTitleLabel() {
        view.addSubview(titleTextView)
        titleTextView.font = .systemFont(ofSize: 16)
        titleTextView.isScrollEnabled = false
        NSLayoutConstraint.activate([
            titleTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleTextView.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 8)
        ])
    }

    private func setupPriceLabel() {
        view.addSubview(priceLabel)

        priceLabel.font = .systemFont(ofSize: 16, weight: .medium)

        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            priceLabel.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 8)
        ])
    }

    private func setupDescriptionTextField() {
        view.addSubview(descriptionTextView)

        descriptionTextView.font = .preferredFont(forTextStyle: .body)

        NSLayoutConstraint.activate([
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionTextView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            descriptionTextView.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

@available (iOS 17, *)
#Preview {
    let preview = {
        let vc = ItemDetailViewController()
        let item: ListItem = .init(title: "Apple watch",
                                   description: """
                                                Lorem ipsum est un grand texte, grand comme ma motivation pour rejoindre
                                                Leboncoin en tant que développeuse iOS.
                                                """,
                                   date: "22 janvier 2024",
                                   image: nil,
                                   category: "Test",
                                   price: 220,
                                   urgent: true)
        vc.setupWithItem(item)
        return vc
    }()
    return UINavigationController(rootViewController: preview)
}
