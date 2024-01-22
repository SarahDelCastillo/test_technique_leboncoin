//
//  LoadingView.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 22/01/2024.
//

import UIKit

final class LoadingView: UIView {
    enum LoadingViewState {
        case loading
        case loaded
        case noItems
    }

    private let loader = UIActivityIndicatorView(forAutoLayout: true)
    private let titleLabel = UILabel(forAutoLayout: true)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func updateState(_ newState: LoadingViewState) {
        switch newState {
        case .loading:
            loader.startAnimating()
            titleLabel.text = "Chargement en cours..."
            titleLabel.isHidden = false
        case .noItems:
            loader.stopAnimating()
            titleLabel.text = "Aucun élément"
            titleLabel.isHidden = false
        case .loaded:
            loader.stopAnimating()
            titleLabel.isHidden = true
        }
    }

    private func setupViews() {
        let stackView = UIStackView(forAutoLayout: true)
        addSubview(stackView)

        stackView.addArrangedSubview(loader)
        stackView.addArrangedSubview(titleLabel)
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill

        loader.hidesWhenStopped = true

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
