//
//  ProductDataModel.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 19.04.2024.
//

import Foundation
class ProductDataModel {
    let id: String
    let imageURL: String?
    let price: Double?
    let name, priceText: String?
    let shortDescription, category: String?
    let unitPrice: Double?
    let squareThumbnailURL: String?
    let status: Int?
    let attribute : String?
    let thumbnailURL : String?
    private var productCount : Int
    
    init(id: String, imageURL: String?, price: Double?, name: String?, priceText: String?, shortDescription: String?, category: String?, unitPrice: Double?, squareThumbnailURL: String?, status: Int?, attribute: String?, thumbnailURL: String?,productCount : Int) {
        self.id = id
        self.imageURL = imageURL
        self.price = price
        self.name = name
        self.priceText = priceText
        self.shortDescription = shortDescription
        self.category = category
        self.unitPrice = unitPrice
        self.squareThumbnailURL = squareThumbnailURL
        self.status = status
        self.attribute = attribute
        self.thumbnailURL = thumbnailURL
        self.productCount = productCount
    }
    
    func getProductCount() -> Int{
        return self.productCount
    }
    
    func increaseProductCount(){
        productCount += 1
    }
    func decreaseProductCount(){
        productCount -= 1
    }
    
    func setProductCount(count : Int){
        productCount = count
    }
    
    
}
