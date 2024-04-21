//
//  ShoppingCartPresenter.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 21.04.2024.
//

import Foundation

protocol ShoppingCartPresentation {
    func back()
}

class ShoppingCartPresenter : ShoppingCartPresentation{
    
    internal var output: ShoppingCartViewContract!
    private var router : ShoppingCartRouting
    
    init(output: ShoppingCartViewContract, router: ShoppingCartRouting) {
        self.output = output
        self.router = router
    }
    
    func back(){
        router.back(from: output)
    }
    
    
}
