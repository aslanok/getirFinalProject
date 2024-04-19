//
//  ProductResponse.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 19.04.2024.
//

import Foundation

struct ProductResponse: Codable {
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
}
