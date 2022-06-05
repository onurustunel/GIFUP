//
//  GifImageCell.swift
//  GIFUP
//
//  Created by onur on 5.06.2022.
//

import UIKit
import Kingfisher

/// GifImageCellProtocol
protocol GifImageCellProtocol {
    func configure(viewModel: GifImageCellViewModel?)
}

final class GifImageCell: UICollectionViewCell, GifImageCellProtocol {
    static let identifier = "GifImageCell"
    
    private lazy var gifImageView: UIImageView = {
        let gifImageView = UIImageView()
        gifImageView.contentMode = .scaleAspectFit
        gifImageView.translatesAutoresizingMaskIntoConstraints = false
        return gifImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// prepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        gifImageView.image = nil
    }
    
    /// Add subviews and call setupConstraints function
    private func setupView() {
        addSubview(gifImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        gifImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gifImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gifImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gifImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func configure(viewModel: GifImageCellViewModel?) {
        if let url = URL(string: viewModel?.imageLink ?? "") {
            DispatchQueue.main.async { [weak self] in
                self?.gifImageView.kf.indicatorType = .activity
                self?.gifImageView.kf.setImage(with: url,
                                               options: [.memoryCacheExpiration(.expired), .diskCacheExpiration(.expired)])
            }
        }
    }
}

