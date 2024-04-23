//
//  ShoppingCartPresenter.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 21.04.2024.
//

import Foundation

protocol ShoppingCartPresentation {
    func fetchSuggestedProducts()
    func back()
}

class ShoppingCartPresenter : ShoppingCartPresentation, ShoppingCartInteractorOutput{
    
    
    internal var output: ShoppingCartViewContract!
    private var router : ShoppingCartRouting
    let interactor : ShoppingCartInteractorInput!
    
    init(output: ShoppingCartViewContract, router: ShoppingCartRouting, interactor : ShoppingCartInteractorInput) {
        self.output = output
        self.router = router
        self.interactor = interactor
    }
    
    func fetchSuggestedProducts() {
        interactor.execute()
    }
    
    func setFetchSuggestedProductSucceed(result: [ProductDataModel]) {
        print("result:\(result)")
        output.suggestedProductsFetched(productList: result)
    }
    
    func setFetchSuggestedProductFailed(error: String) {
        
    }
    
    
    func back(){
        router.back(from: output)
    }
    
    
}
