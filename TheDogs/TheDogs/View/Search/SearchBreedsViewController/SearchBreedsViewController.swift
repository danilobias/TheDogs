//
//  SearchBreedsViewController.swift
//  TheDogs
//
//  Created by Danilo Lago on 21/11/2021.
//

import UIKit

class SearchBreedsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var  tableView: UITableView!

    // MARK: - VARs
    lazy var viewModel : SearchBreedsViewModel = {
        let viewModel = SearchBreedsViewModel()
        viewModel.breedsDidChange = {
            self.reloadBreedsList()
        }
        return viewModel
    }()

    var currentSearchTerm: String = ""
    
    let search = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Search"
        registerCells()
        configureTableView()
        configureSearchBar()
        searchBreeds(firstPage: true)
    }
    
    // MARK: - Layout
    func configureSearchBar() {
        search.searchBar.delegate = self
        search.hidesNavigationBarDuringPresentation = true
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search"
        
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true;
        extendedLayoutIncludesOpaqueBars = true
    }
    
    func configureTableView() {
        tableView.estimatedRowHeight = 134.5
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func registerCells() {
        tableView.registerNib(SearchBreedsTableViewCell.self)
    }
    
    func reloadBreedsList() {
        tableView.reloadData()
    }
    
    // MARK: - Requests
    func searchBreeds(firstPage: Bool, term: String = "") {
        viewModel.searchBreeds(search: term)
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

extension SearchBreedsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: SearchBreedsTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath) else { return UITableViewCell() }
        cell.breedCellViewModel = viewModel.cellViewModel(indexPath: indexPath)
        return cell
    }
}

extension SearchBreedsViewController: UITableViewDelegate {
    
}

extension SearchBreedsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {}
}

extension SearchBreedsViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() //hide keyboard

        if let text = searchBar.text, !text.isEmpty {
            self.currentSearchTerm = text
            self.searchBreeds(firstPage: true, term: text)
        }
        else {
            self.currentSearchTerm = ""
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.currentSearchTerm = ""
    }
}
