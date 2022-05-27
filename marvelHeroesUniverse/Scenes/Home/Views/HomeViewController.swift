//
//  HomeViewController.swift
//  MarvelHeroesUniverse
//
//  Created by kjoe on 5/14/22.
//

import UIKit

class HomeViewController: UIViewController {
    let tableView: UITableView
    var viewModel: HomeViewModelRepresentable
    let searchController = UISearchController(searchResultsController: nil)
    
    init(viewModel: HomeViewModelRepresentable) {
        self.viewModel = viewModel
        tableView = UITableView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
        viewModel.loadData(query: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        view.backgroundColor = .systemBackground
        title = "Home"
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.backgroundColor = .clear
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.automaticallyShowsCancelButton = true
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        tableView.register(HeroesTableViewCell.self, forCellReuseIdentifier: HeroesTableViewCell.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemBackground
        viewModel.reloadClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                let label = UILabel(frame: .zero)
                label.text = self.viewModel.footerText()
                self.tableView.tableFooterView = label
                self.tableView.reloadData()
            }
        }
        viewModel.errorClosure = { error in
            // TODO: - show some message when error string, used for network error or for loaded all data from search or from endpoint
            print(error)
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeroesTableViewCell.cellIdentifier) as! HeroesTableViewCell
        cell.set(viewModel: viewModel.viewModelfor(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.select(index: indexPath.row)
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfItems() - 10 {
            let searchterm: Bool = searchController.searchBar.text?.isEmpty ?? true
            viewModel.loadData(query: searchterm ? nil :  searchController.searchBar.text)
        }
    }
}
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.loadData(query: searchBar.text)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.loadData(query: nil)
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .none, animated: true)
    }
}
