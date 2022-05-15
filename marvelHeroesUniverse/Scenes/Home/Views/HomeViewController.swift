//
//  HomeViewController.swift
//  marvelHeroesUniverse
//
//  Created by kjoe on 5/14/22.
//

import UIKit

class HomeViewController: UIViewController {
    let tableView: UITableView
    let viewModel: HomeViewModel
    let searchController = UISearchController(searchResultsController: nil)
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        tableView = UITableView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
        viewModel.loadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setupView() {
        view.translatesAutoresizingMaskIntoConstraints = false
        title = "Home"
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.automaticallyShowsCancelButton = true
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        viewModel.reloadClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                let label = UILabel(frame: .zero)
                label.text = self.viewModel.footerText()
                self.tableView.tableFooterView = label
                self.tableView.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.loadData(query: searchBar.text)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.loadData()
    }
}
