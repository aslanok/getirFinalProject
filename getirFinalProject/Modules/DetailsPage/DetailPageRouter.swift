//
//  DetailPageRouter.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 19.04.2024.
//

import UIKit

protocol DetailPageRouting{
    func back(from view : UIViewController?)
}


class DetailPageRouter : DetailPageRouting{
    func viewController(product : ProductResponse) -> UIViewController {
        let view = DetailPageViewController(product : product)
        let presenter = DetailPagePresenter(output: view, router: self)
        view.modalPresentationStyle = .fullScreen
        view.presenter = presenter
        presenter.output = view
        return view
    }
    
    func back(from view: UIViewController?) {
        view?.dismiss(animated: true)
    }
    
    
    
}

