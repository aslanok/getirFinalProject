//
//  MainPageRouter.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 16.04.2024.
//

import UIKit

protocol MainPageRouting{
    func presentDetailPage(product : ProductDataModel,from view : UIViewController?)
    func presentShoppingCart(from view : UIViewController)
}


final class MainPageRouter : MainPageRouting{
    
    weak var viewController : MainPageViewController?
    
    static func createViewController() -> MainPageViewController {
        let view = MainPageViewController()
        let interactor = MainPageInteractor()
        let router = MainPageRouter()
        let presenter = MainPagePresenter(router: router, view: view, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        presenter.output = view
        return view
    }
    /*
    var viewController : UIViewController {
        let view = MainPageViewController()
        let interactor = MainPageInteractor()
        
        let presenter = MainPagePresenter(router: self, view: view, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        presenter.output = view
        return view
    }
     */
    
    func presentDetailPage(product : ProductDataModel,from view: UIViewController?) {
        //let router = DetailPageRouter()
        view?.present(DetailPageRouter.viewController(product: product), animated: true)
    }
    
    func presentShoppingCart(from view: UIViewController) {
        let router = ShoppingCartRouter()
        view.present(router.viewController(), animated: true)
    }
    

    
}
