//
//  GifDetailView.swift
//  GIFUP
//
//  Created by onur on 5.06.2022.
//

import UIKit
import Kingfisher

final class GifDetailView: UIView {
    
    var gifDetailViewModel: GifDetailViewModel? {
        didSet {
            configure(gifDetailViewModel: gifDetailViewModel)
        }
    }
    private lazy var gifImageView: UIImageView = {
        let gifImageView = UIImageView()
        gifImageView.contentMode = .scaleAspectFit
        gifImageView.translatesAutoresizingMaskIntoConstraints = false
        return gifImageView
    }()
    private lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var linkLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var ratingLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemRed
        label.isHidden = true
        label.layer.cornerRadius = 25
        label.clipsToBounds = true
        return label
    }()
    
    func prepareForReuse() {
        gifImageView.image = nil
        ratingLabel.isHidden = true
        titleLabel.text = nil
        linkLabel.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupView()
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(gifImageView)
        addSubview(titleLabel)
        addSubview(linkLabel)
        addSubview(ratingLabel)
        setupConstraints()
    }
    
    /// Update UI with gifDetailViewModel data
    /// - Parameter gifDetailViewModel: GifDetailViewModel
    private func configure(gifDetailViewModel: GifDetailViewModel?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let gifDetailViewModel = gifDetailViewModel else { return }
            self.titleLabel.text = gifDetailViewModel.titleDecide()
            self.linkLabel.text = gifDetailViewModel.linkDecide()
            self.ratingLabel.text = gifDetailViewModel.ratingDecide()
            self.ratingLabel.isHidden = gifDetailViewModel.hideRatingLabel()
            self.gifImageView.kf.indicatorType = .activity
            self.gifImageView.kf.setImage(
                with: gifDetailViewModel.gifPreviewUrl,
                options: [.memoryCacheExpiration(.expired), .diskCacheExpiration(.expired)])
        }
    }
}

extension GifDetailView {
    fileprivate func setupConstraints() {
        gifImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gifImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        gifImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        gifImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: gifImageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -100).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        linkLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10).isActive = true
        linkLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        linkLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100).isActive = true
        linkLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        ratingLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        ratingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        ratingLabel.bottomAnchor.constraint(equalTo: linkLabel.bottomAnchor).isActive = true
        ratingLabel.widthAnchor.constraint(equalTo: ratingLabel.heightAnchor).isActive = true
    }
}

