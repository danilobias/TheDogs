//
//  ListBreedsViewController.swift
//  TheDogs
//
//  Created by Danilo Lago on 21/11/2021.
//

import UIKit

class ListBreedsViewController: BaseViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - VARs
    private var breedsListViewModel: ListBreedsViewModel?
    
    lazy var viewModel : ListBreedsViewModel = {
        let viewModel = ListBreedsViewModel()
        return viewModel
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Breeds"
        registerCells()
        configureViewModelBindings()
        showLoading()
        fetchBreeds()
    }
    
    // MARK: - Actions
    @IBAction func changeViewType(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        viewModel.changeViewType()
    }
    
    @IBAction func changeOrder(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        showLoading()
        viewModel.changeOrder()
    }
    
    // MARK: - Layout
    func configureViewModelBindings() {
        viewModel.breedsDidChange = {
            self.reloadBreedsList()
        }
        viewModel.viewTypeDidChange = {
            self.reloadBreedsList()
        }
    }
    
    func registerCells() {
        collectionView.registerNib(BreedListCell.self)
        collectionView.registerNib(BreedGridCell.self)
        collectionView.registerNib(LoadingCollectionViewCell.self)
    }
    
    
    // MARK: - Requests
    func fetchBreeds() {
        self.viewModel.fetchBreeds()
    }
    
    func reloadBreedsList() {
        hideLoading()
        collectionView.reloadData()
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

extension ListBreedsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.hasNextPage, indexPath.row >= viewModel.numberOfRows() - 1,
            let cell: LoadingCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath) {
            return cell
        }
        
        if !viewModel.isListView, let cell: BreedGridCell = collectionView.dequeueReusableCell(forIndexPath: indexPath) {
            cell.breedCellViewModel = viewModel.cellViewModel(indexPath: indexPath)
            return cell
        }
        
        if viewModel.isListView, let cell: BreedListCell = collectionView.dequeueReusableCell(forIndexPath: indexPath) {
            cell.breedCellViewModel = viewModel.cellViewModel(indexPath: indexPath)
            return cell
        }

        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.hasNextPage, indexPath.row >= viewModel.numberOfRows() - 1 {
            fetchBreeds()
        }
    }
}

extension ListBreedsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension ListBreedsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = viewModel.numberOfItemsPerRow()
        let hardCodedPadding: CGFloat = 10
        let itemWidth: CGFloat = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight: CGFloat = viewModel.isListView ? 132.0 : 182.0
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

