//
//  SceneDelegate.swift
//  MarvelHeroesUniverse
//
//  Created by kjoe on 5/14/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let loader: NetworkLoader = NetworkLoader()
        let service: CharacterListService = CharacterListService(loader: loader)
        let factory: CharacterListEndpointFactory = CharacterListEndpointFactory()
        let homeVC = HomeViewController(viewModel: HomeViewModel(service: service, factory: factory))
        let navigationController = UINavigationController()
        navigationController.viewControllers.append(homeVC)
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        self.window = window
        self.window?.layer.backgroundColor = UIColor.clear.cgColor
        window.makeKeyAndVisible()
    }
}
