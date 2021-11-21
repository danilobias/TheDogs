//
//  ListBreedsViewController.swift
//  TheDogs
//
//  Created by Danilo Lago on 21/11/2021.
//

import UIKit

class ListBreedsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView : UITableView!
    
    // MARK: - VARs
    private var breedsListViewModel: ListBreedsViewModel?
    
    lazy var viewModel : ListBreedsViewModel = {
        let viewModel = ListBreedsViewModel()
        viewModel.breedsDidChange = {
            self.showBreedsList()
        }
        return viewModel
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerCells()
        fetchBreeds()
    }
    
    // MARK: - Layout
    func configureTableViewL() {
        tableView.estimatedRowHeight = 134.5
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func registerCells() {
        tableView.registerNib(BreedTableViewCell.self)
    }
    
    // MARK: - Requests
    func fetchBreeds() {
        self.viewModel.fetchBreeds()
    }
    
    func showBreedsList() {
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

extension ListBreedsViewController: UITableViewDataSource {    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: BreedTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath) else { return UITableViewCell() }
        cell.breedCellViewModel = viewModel.cellViewModel(indexPath: indexPath)
        return cell
    }
}

extension ListBreedsViewController: UITableViewDelegate {
    
}
