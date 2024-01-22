//
//  ItemImageView.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 22/01/2024.
//

import UIKit

final class ItemImageView: UIView {
    private let asyncImageView = AsyncUIImageView(forAutoLayout: true)
    private let urgentLabel = UILabel(forAutoLayout: true)
    private var imageLoadingTask: Task<Void, Error>?
    
    var imageURL: URL? {
        didSet {
            loadImage()
        }
    }
    
    var urgent = false {
        didSet {
            urgentLabel.isHidden = !urgent
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupUrgentLabel()
    }

    deinit {
        imageLoadingTask?.cancel()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func loadImage() {
        if let imageURL {
            imageLoadingTask = asyncImageView.load(from: imageURL)
        } else {
            asyncImageView.image = UIImage(named: "placeholder")
        }
    }

    private func setupImageView() {
        addSubview(asyncImageView)
        asyncImageView.layer.cornerRadius = 10
        asyncImageView.clipsToBounds = true
        asyncImageView.contentMode = .scaleAspectFill

        let aspectRatio = NSLayoutConstraint(item: asyncImageView, attribute: .width, relatedBy: .equal, toItem: asyncImageView, attribute: .height, multiplier: 2, constant: 0)
        asyncImageView.addConstraint(aspectRatio)

        NSLayoutConstraint.activate([
            asyncImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            asyncImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            asyncImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            asyncImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)

        ])
    }

    private func setupUrgentLabel() {
        addSubview(urgentLabel)
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
}
