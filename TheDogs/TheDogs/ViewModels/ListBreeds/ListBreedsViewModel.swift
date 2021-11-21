//
//  ListBreedsViewModel.swift
//  TheDogs
//
//  Created by Danilo Lago on 21/11/2021.
//

import UIKit

protocol ListBreedsViewModelProtocol: ListProtocol {
    var breedsDidChange: (() -> Void)? { get set }
    var viewTypeDidChange: (() -> Void)? { get set }
}

class ListBreedsViewModel: ListBreedsViewModelProtocol {
    // MARK: - Vars
    let breedsRequest: BreedsServiceProtocol

    let limit: Int = 20

    var breeds: [Breed]? {
        didSet{
            self.breedsDidChange?()
        }
    }

    var breedsDidChange: (() -> Void)?
    var viewTypeDidChange: (() -> Void)?

    var isListView: Bool = true
    
    // MARK: - Init
    required init() {
        self.breedsRequest = BreedsRequests()
    }

    // MARK: - Methods
    func fetchBreeds() {
        self.breedsRequest.getBreeds(params: nil) { result in
            switch result {
            case .success(let breedsList):
                self.breeds = breedsList
            case .unknowError(let error):
                debugPrint(error)
            case .apiFailure(_):
                debugPrint("error")
            case .networkFailure(_):
                debugPrint("error")
            }
        }
    }
    
    func cellViewModel<T>(indexPath: IndexPath) -> T? {
        guard let breed = breeds?[indexPath.row] else { return nil}
        return BreedCellViewModel(name: breed.name, image: breed.image?.url) as? T
    }

    func numberOfRows() -> Int{
        return breeds?.count ?? 0
    }
    
    func numberOfItemsPerRow() -> CGFloat {
        if isListView {
            return 1.0
        }
        return 2.0
    }
    
    func changeViewType() {
        isListView = !isListView
        viewTypeDidChange?()
    }
}

struct BreedCellViewModel {
    var name: String
    var image: String?
}
