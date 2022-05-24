//
//  HeroesTableViewCell.swift
//  MarvelHeroesUniverse
//
//  Created by kjoe on 5/15/22.
//

import UIKit
import Kingfisher
class HeroesTableViewCell: UITableViewCell {
    var cardView: CardView!
    var heroeImage: UIImageView!
    var heroeName: UILabel!
    var heroeDescrip: UILabel!
    var comicNumber: UILabel!
    var seriesNumber: UILabel!
    var storiesNumber: UILabel!
    var eventNumber: UILabel!
    var buttonStack: UIStackView!
    var viewModel: HeroesTableViewCellViewModelRepresentable! {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    static var cellIdentifier: String {
        return String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.backgroundColor = .systemBackground
        cardView = CardView(frame: .zero)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = .systemBackground
        contentView.addSubview(cardView)
        cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        heroeImage = UIImageView(frame: .zero)
        cardView.addSubview(heroeImage)
        heroeImage.translatesAutoresizingMaskIntoConstraints = false
        heroeImage.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20).isActive = true
        heroeImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        heroeImage.heightAnchor.constraint(equalToConstant: 44).isActive = true
        heroeImage.widthAnchor.constraint(equalToConstant: 44).isActive = true
        heroeImage.layer.cornerRadius = 22
        heroeImage.clipsToBounds = true
        heroeName = UILabel(frame: .zero)
        heroeName.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(heroeName)
        heroeName.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10).isActive = true
        heroeName.leadingAnchor.constraint(equalTo: heroeImage.trailingAnchor, constant: 10).isActive = true
        heroeName.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        heroeName.font = .systemFont(ofSize: 24, weight: .bold)
        heroeDescrip = UILabel(frame: .zero)
        heroeDescrip.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(heroeDescrip)
        heroeDescrip.topAnchor.constraint(equalTo: heroeName.bottomAnchor, constant: 5).isActive = true
        heroeDescrip.leadingAnchor.constraint(equalTo: heroeName.leadingAnchor).isActive = true
        heroeDescrip.trailingAnchor.constraint(equalTo: heroeName.trailingAnchor).isActive = true
        heroeDescrip.numberOfLines = 2
        comicNumber = UILabel(frame: .zero)
        comicNumber.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(comicNumber)
        comicNumber.topAnchor.constraint(equalTo: heroeDescrip.bottomAnchor, constant: 10).isActive = true
        comicNumber.leadingAnchor.constraint(equalTo: heroeDescrip.leadingAnchor).isActive = true
        seriesNumber = UILabel(frame: .zero)
        seriesNumber.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(seriesNumber)
        seriesNumber.topAnchor.constraint(equalTo: comicNumber.topAnchor).isActive = true
        seriesNumber.trailingAnchor.constraint(equalTo: heroeDescrip.trailingAnchor).isActive = true
        seriesNumber.textAlignment = .right
        seriesNumber.leadingAnchor.constraint(equalTo: comicNumber.trailingAnchor, constant: 10).isActive = true
        seriesNumber.widthAnchor.constraint(equalTo: comicNumber.widthAnchor).isActive = true
        storiesNumber = UILabel(frame: .zero)
        storiesNumber.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(storiesNumber)
        storiesNumber.topAnchor.constraint(equalTo: comicNumber.bottomAnchor, constant: 10).isActive = true
        storiesNumber.leadingAnchor.constraint(equalTo: comicNumber.leadingAnchor).isActive = true
        storiesNumber.text = "stories: 0"
        eventNumber = UILabel(frame: .zero)
        eventNumber.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(eventNumber)
        eventNumber.topAnchor.constraint(equalTo: storiesNumber.topAnchor).isActive = true
        eventNumber.trailingAnchor.constraint(equalTo: seriesNumber.trailingAnchor).isActive = true
        eventNumber.text = "events: 0"
        buttonStack = UIStackView(frame: .zero)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(buttonStack)
        buttonStack.topAnchor.constraint(equalTo: storiesNumber.bottomAnchor, constant: 10).isActive = true
        buttonStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        buttonStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        buttonStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10).isActive = true
        buttonStack.distribution = .fillEqually
        buttonStack.axis = .horizontal
        buttonStack.spacing = 20
    }
    
    func set(viewModel: HeroesTableViewCellViewModelRepresentable) {
        self.viewModel = viewModel
    }
    
    func updateView() {
        if let url = viewModel.thumbnailURl() {
            heroeImage.kf.setImage(with: url)
        }
        heroeName.text = viewModel.heroeName()
        heroeDescrip.text = viewModel.heroeDescription()
        comicNumber.text = viewModel.comicNumber()
        seriesNumber.text = viewModel.seriesNumber()
        storiesNumber.text = viewModel.storiesNumber()
        eventNumber.text = viewModel.eventNumber()
        let number = viewModel.buttonNumber()
        let numb = number < 3 ? number : 3
        for identifier in 0..<numb {
            let action = actionClosure(identifier: identifier)
            var configuration = UIButton.Configuration.filled()
            configuration.titlePadding = 10
            configuration.imagePadding = 10
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10)
            let button = UIButton(configuration: configuration)
            button.setTitleColor(.systemBackground, for: .normal)
            button.setTitle(viewModel.titleforButton(at: identifier), for: .normal)
            button.addAction(UIAction(title: viewModel.titleforButton(at: identifier), handler: action), for: .primaryActionTriggered)
            buttonStack.addArrangedSubview(button)
        }
        cardView.setNeedsLayout()
        cardView.layoutIfNeeded()
        setNeedsLayout()
        layoutIfNeeded()
    }
    func actionClosure(identifier: Int) -> UIActionHandler {
        let action: UIActionHandler = { _ in
            if let url = self.viewModel.urlforButtton(at: identifier) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
        }
        return action
    }
}
