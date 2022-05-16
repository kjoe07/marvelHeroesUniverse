//
//  SceneDelegate.swift
//  marvelHeroesUniverse
//
//  Created by kjoe on 5/14/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        print("here in scene delegate")
        let HomeVC = HomeViewController(viewModel: HomeViewModel(service: CharacterListService(loader: NetworkLoader()), factory: CharacterListEndpointFactory()))
        let navigationController = UINavigationController()
        navigationController.viewControllers.append(HomeVC)
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        self.window = window
        self.window?.layer.backgroundColor = UIColor.clear.cgColor
        window.makeKeyAndVisible()
    }
}

