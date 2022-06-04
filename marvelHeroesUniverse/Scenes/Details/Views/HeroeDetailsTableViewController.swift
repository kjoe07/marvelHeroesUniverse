//
//  TableViewController.swift
//  MarvelHeroesUniverseTests
//
//  Created by kjoe on 5/26/22.
//

import UIKit
import Kingfisher
class HeroeDetailsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let headerView: UIView
    let namelabel: UILabel
    let descriptionLabel: UILabel
    let viewModel: HeroeDetailsViewModelRepresentable
    let tableView = UITableView(frame: .zero)
    init(viewModel: HeroeDetailsViewModelRepresentable) {
        headerView = UIView(frame: .zero)
        namelabel = UILabel(frame: .zero)
        descriptionLabel = UILabel(frame: .zero)
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let heroeImage = UIImageView(frame: .zero)
        heroeImage.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(heroeImage)
        heroeImage.layer.cornerRadius = 75
        heroeImage.clipsToBounds = true
        heroeImage.kf.setImage(with: URL(string: viewModel.heroeImageUrlString))
        namelabel.translatesAutoresizingMaskIntoConstraints = false
        namelabel.font = .systemFont(ofSize: 22, weight: .bold)
        namelabel.numberOfLines = 0
        namelabel.lineBreakMode = .byWordWrapping
        namelabel.textAlignment = .center
        namelabel.text = viewModel.heroeName
        headerView.addSubview(namelabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = .systemFont(ofSize: 19)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = viewModel.heroeDescription
        headerView.addSubview(descriptionLabel)
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.sectionHeaderTopPadding = 0
        
        NSLayoutConstraint.activate([
            heroeImage.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
            heroeImage.heightAnchor.constraint(equalToConstant: 150),
            heroeImage.widthAnchor.constraint(equalToConstant: 150),
            heroeImage.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            namelabel.topAnchor.constraint(equalTo: heroeImage.bottomAnchor, constant: 10),
            namelabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 30),
            namelabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -30),
            descriptionLabel.topAnchor.constraint(equalTo: namelabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            descriptionLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10)
        ])
        tableView.tableHeaderView = headerView
        headerView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: tableView.widthAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
       
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0        
        label.text = viewModel.footerText
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .bold)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = label
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
        let appareance = UINavigationBarAppearance()
        appareance.backgroundColor =  .systemBackground
        navigationController?.navigationBar.standardAppearance = appareance
        navigationController?.navigationBar.scrollEdgeAppearance = appareance
        title = viewModel.heroeName
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.titlefor(row: indexPath.row, in: indexPath.section)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        if indexPath.section == 4 {
            cell.textLabel?.textColor = .link
        } else {
            cell.textLabel?.textColor = .label
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitle(for: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.shouldSelectItem(at: indexPath.row, in: indexPath.section) {
            guard let url = viewModel.urlForItem(at: indexPath.row) else { return }
            guard UIApplication.shared.canOpenURL(url)  else { return }
            UIApplication.shared.open(url)
        }
    }
    
}
