//
//  GifCell.swift
//  GIFUP
//
//  Created by onur on 5.06.2022.
//

import UIKit

final class GifCell: UICollectionViewCell {
    static let identifier = "CustomFirstCell"
    
    private let gifDetailView = GifDetailView()
    var gifDetailViewModel: GifDetailViewModel? {
        didSet {
            gifDetailView.gifDetailViewModel = gifDetailViewModel
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    /// Add subviews and call setupConstraints function
    fileprivate func setupView() {
        addSubview(gifDetailView)
        setupConstraints()
    }
    
    /// prepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        gifDetailView.prepareForReuse()
    }
    
    fileprivate func setupConstraints() {
        gifDetailView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gifDetailView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gifDetailView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gifDetailView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

