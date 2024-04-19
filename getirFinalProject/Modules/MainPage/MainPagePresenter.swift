//
//  MainPagePresenter.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 17.04.2024.
//

import Foundation

protocol MainPagePresentation{
    func fetchAllProducts()
    func fetchSuggestedProducts()
}


class MainPagePresenter : MainPagePresentation, MainPageInteractorOutput{
    
    internal var output : MainPageViewContract!
    private var router : MainPageRouting
    let interactor : MainPageInteractorInput!
    
    init(router : MainPageRouting, view : MainPageViewContract, interactor : MainPageInteractorInput){
        self.output = view
        self.router = router
        self.interactor = interactor
    }
    
    func fetchAllProducts() {
        interactor.executeAllProducts()
    }
    
    func fetchSuggestedProducts(){
        interactor.executeSuggestedProducts()
    }
    
    func setFetchAllProductDataSuccess(result: [AllProductsResponse]) {
        print("resultGeldi : \(result[0].id)")
    }
    
    func setFetchAllProductDataFailed(error: String) {
        
    }
    
    func setFetchSuggestedProductDataSuccess(result: [SuggestedProductsResponse]) {
        
    }
    
    func setFetchSuggestedProductDataFailed(error: String) {
        
    }
    
    
    
}
