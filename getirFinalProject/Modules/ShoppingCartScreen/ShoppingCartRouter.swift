//
//  ShoppingCartRouter.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 21.04.2024.
//

import UIKit

protocol ShoppingCartRouting{
    func back(from view: UIViewController)
}

class ShoppingCartRouter : ShoppingCartRouting{
    
    func viewController() -> UIViewController {
        let view = ShoppingCartViewController()
        let interactor = ShoppingCartInteractor()
        let presenter = ShoppingCartPresenter(output: view, router: self, interactor: interactor)
        
        view.modalPresentationStyle = .fullScreen
        interactor.output = presenter
        view.presenter = presenter
        presenter.output = view
        return view
    }
    
    func back(from view: UIViewController) {
        view.dismiss(animated: true)
    }

    
}
