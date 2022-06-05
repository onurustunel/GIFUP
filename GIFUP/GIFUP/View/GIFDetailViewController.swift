//
//  GIFDetailViewController.swift
//  GIFUP
//
//  Created by onur on 5.06.2022.
//

import UIKit

final class GIFDetailViewController: UIViewController {
    
    lazy var gifDetailView = GifDetailView()
    lazy var gifDetailViewModel: GifDetailViewModel? = nil {
        didSet {
            gifDetailView.gifDetailViewModel = gifDetailViewModel
        }
    }
    var navigateBack: (() -> Void)?
    init(gifDetailViewModel: GifDetailViewModel?) {
        super.init(nibName: nil, bundle: nil)
        self.gifDetailViewModel = gifDetailViewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigateBack?()
    }
}

extension GIFDetailViewController {
    private func setupNavigationBar() {
        title = gifDetailViewModel?.titleDecide()
        self.navigationController?.navigationBar.topItem?.title = " "
    }
    
    private func setupView() {
        view.backgroundColor = .black
        view.addSubview(gifDetailView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        gifDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        gifDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        gifDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        gifDetailView.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
}

