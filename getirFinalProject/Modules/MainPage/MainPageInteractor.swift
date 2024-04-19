//
//  MainPageInteractor.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 19.04.2024.
//

import Foundation

protocol MainPageInteractorInput{
    func executeAllProducts()
    func executeSuggestedProducts()
}

protocol MainPageInteractorOutput{
    func setFetchAllProductDataSuccess(result : [AllProductsResponse])
    func setFetchAllProductDataFailed(error : String)
    func setFetchSuggestedProductDataSuccess(result : [SuggestedProductsResponse])
    func setFetchSuggestedProductDataFailed(error : String)
}

class MainPageInteractor : MainPageInteractorInput{
    
    internal var output : MainPageInteractorOutput?
    
    let endpointAllProductsURL = "https://65c38b5339055e7482c12050.mockapi.io/api/products"
    let endpointSuggestedProductsURL = "https://65c38b5339055e7482c12050.mockapi.io/api/suggestedProducts"
    
    func executeAllProducts() {
        APIService.shared.request( endpointAllProductsURL, type: [AllProductsResponse].self) { result in
            switch result{
            case .success(let data):
                self.output?.setFetchAllProductDataSuccess(result: data)
            case .failure(let error):
                self.output?.setFetchAllProductDataFailed(error: error.errorDescription)
            }
        }
    }
    
    func executeSuggestedProducts() {
        APIService.shared.request( endpointSuggestedProductsURL, type: [SuggestedProductsResponse].self) { result in
            switch result{
            case .success(let data):
                self.output?.setFetchSuggestedProductDataSuccess(result: data)
            case .failure(let error):
                self.output?.setFetchSuggestedProductDataFailed(error: error.errorDescription)
            }
        }
    }
    
}
