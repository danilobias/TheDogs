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

public enum SortOption: String {
    case asc = "asc"
    case desc = "desc"
}

class ListBreedsViewModel: ListBreedsViewModelProtocol {
    // MARK: - Vars
    let breedsRequest: BreedsServiceProtocol

    var breeds: [Breed]? {
        didSet{
            self.breedsDidChange?()
        }
    }

    var breedsDidChange: (() -> Void)?
    var viewTypeDidChange: (() -> Void)?
    
    var currentPage: Int = 0
    var hasNextPage: Bool = false
    var orderBy: SortOption = .asc

    var isListView: Bool = true
    private let limit: Int = 50
    
    // MARK: - Init
    required init() {
        self.breedsRequest = BreedsRequests()
    }

    // MARK: - Methods
    func changeOrder() {
        orderBy = orderBy == .asc ? .desc : .asc
        currentPage = 0
        fetchBreeds()
    }
    
    func fetchBreeds() {
        let params: [String: Any] = ["page": currentPage,
                                     "limit": limit,
                                     "order": orderBy.rawValue]
        
        self.breedsRequest.getBreeds(params: params) { result in
            switch result {
            case .success(let breedsList):
                
                if self.currentPage == 0 {
                    self.breeds = breedsList
                } else {
                    self.breeds?.append(contentsOf: breedsList)
                }
                
                self.currentPage += 1
                self.hasNextPage = breedsList.count == self.limit
                
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
        return breeds?.count ?? 0 + (hasNextPage ? 1 : 0)
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
    let name: String
    let image: String?
}
