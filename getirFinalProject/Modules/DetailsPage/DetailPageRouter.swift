//
//  DetailPageRouter.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 19.04.2024.
//

import UIKit

protocol DetailPageRouting{
    func presentShoppingCart(from view : UIViewController)
    func back(from view : UIViewController?)
}


final class DetailPageRouter : DetailPageRouting{
    
    weak var viewController : DetailPageViewController?
    
    static func viewController(product : ProductDataModel) -> UIViewController {
        let view = DetailPageViewController(product : product)
        let router = DetailPageRouter()
        let presenter = DetailPagePresenter(currentProduct : product, output: view, router: router)
        view.modalPresentationStyle = .fullScreen
        view.presenter = presenter
        presenter.output = view
        return view
    }
    
    func presentShoppingCart(from view: UIViewController) {
        let router = ShoppingCartRouter()
        view.present(router.viewController(), animated: true)
    }
    
    func back(from view: UIViewController?) {
        view?.dismiss(animated: true)
    }
    
    
    
}

