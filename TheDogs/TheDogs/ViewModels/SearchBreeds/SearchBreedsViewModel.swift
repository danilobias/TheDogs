//
//  SearchBreedsViewModel.swift
//  TheDogs
//
//  Created by Danilo Lago on 21/11/2021.
//

import Foundation
protocol SearchBreedsViewModelProtocol: ListProtocol {
    var breedsDidChange: (() -> Void)? { get set }
}

class SearchBreedsViewModel: SearchBreedsViewModelProtocol {
    // MARK: - Vars
    let breedsRequest: BreedsServiceProtocol

    var limit: Int = 50

    var breeds: [Breed]? {
        didSet{
            self.breedsDidChange?()
        }
    }

    var breedsDidChange: (() -> Void)?

    // MARK: - Methods
    required init() {
        self.breedsRequest = BreedsRequests()
    }

    // MARK: - Methods
    func searchBreeds(search: String) {
        let params: [String : Any]? = search.isEmpty ? nil : ["q": search]
        self.breedsRequest.searchBreeds(params: params) { result in
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
        return SearchBreedCellViewModel(name: breed.name, group: breed.breedGroup, origin: breed.origin) as? T
    }
    
    func detailsViewModel(indexPath: IndexPath) -> DetailsBreedsViewModel? {
        guard let breed = breeds?[indexPath.row] else { return nil}
        return DetailsBreedsViewModel(name: breed.name, image: breed.image?.url, origin: breed.origin,
                                      temperament: breed.temperament, category: breed.breedGroup)
    }

    func numberOfRows() -> Int{
        return breeds?.count ?? 0
    }
}

struct SearchBreedCellViewModel {
    let name: String
    let group: String?
    let origin: String?
}
