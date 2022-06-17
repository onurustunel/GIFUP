//
//  HomeViewController.swift
//  GIFUP
//
//  Created by onur on 5.06.2022.
//

import UIKit

final class HomeViewController: UIViewController {
    /// Logic for not reload collectionView after navigate back from GIFDetailViewController
    private var networkRequestPermission = true
    /// Logic for searching now
    var searchingNow = false {
        didSet {
            reloadCollectionView()
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .black
        collectionView.register(GifCell.self, forCellWithReuseIdentifier: GifCell.identifier)
        collectionView.register(GifImageCell.self, forCellWithReuseIdentifier: GifImageCell.identifier)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier)
        collectionView.keyboardDismissMode = .interactive
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    lazy var viewModel: HomeViewModelProtocol? = nil
    
    convenience init(viewModel: HomeViewModelProtocol) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    private let searchController = UISearchController()
    
    /// Fetch random gifs every Constant.requestDuration seconds
    private var timer: Timer?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSearchBar()
        setupRequest()
        observeChanges()
    }
    
    private func observeChanges() {
        viewModel?.bindNewDataArrived.assignValue { [weak self] _ in
            self?.reloadCollectionView()
        }
    }
    
    /// Fetch random gifs and fire time
    private func setupRequest() {
        viewModel?.fetchRandomGIF()
        timer = Timer.scheduledTimer(timeInterval: Constants.requestDuration, target: self, selector: #selector(refreshRequest), userInfo: nil, repeats: true)
    }
    
    /// Reload collectionView
    private func reloadCollectionView() {
        if !networkRequestPermission { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
    
    /// Refresh request every Constant.requestDuration seconds
    @objc fileprivate func refreshRequest() {
        viewModel?.fetchRandomGIF()
    }
    
    /// Setup Search Controller
    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = Constants.searchBarPlaceholder
        searchController.hidesNavigationBarDuringPresentation = true
        self.navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func setupView() {
        view.addSubview(collectionView)
    }
    
    /// Present GIFDetailViewController
    /// - Parameter index: IndexPath.row
    private func navigateToDetail(index: Int) {
        guard let selectedGIFViewModel = viewModel?.searchedGIFcellForRow(index: index) else { return }
        let detailViewController = GIFDetailViewController(gifDetailViewModel: selectedGIFViewModel)
        detailViewController.navigateBack = { [weak self] in
            self?.networkRequestPermission = false
        }
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        networkRequestPermission = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        networkRequestPermission = true
        // timer will start here again.
        setupRequest()
        viewModel?.clearSearchedGIF()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // timer will stop here...
        timer?.invalidate()
        timer = nil
        viewModel?.clearRandomGIF()
        return true
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        if text.count > 2 {
            /// Send request to search gif
            viewModel?.searchGIFText = text
            searchingNow = true
        } else {
            searchingNow = false
        }
    }
}

//MARK:- UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchingNow ? viewModel?.searchedNumberOfItemsInSection() ?? 0 : viewModel?.randomNumberOfItemsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch searchingNow {
            
        case true:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GifImageCell.identifier, for: indexPath) as? GifImageCell {
                let data = viewModel?.searchedGIFImageCellForRow(index: indexPath.row)
                cell.configure(viewModel: data)
                return cell
            } else { return UICollectionViewCell() }
        case false:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GifCell.identifier, for: indexPath) as? GifCell {
                cell.gifDetailViewModel = viewModel?.randomGIFcellForRow()
                return cell
            } else { return UICollectionViewCell() }
        }
    }
}

//MARK:- UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if searchingNow {
            navigateToDetail(index: indexPath.row)
        }
    }
}

extension HomeViewController {
    static func build() -> UIViewController {
        let viewModel = HomeViewModel()
        return HomeViewController(viewModel: viewModel)
    }
}
