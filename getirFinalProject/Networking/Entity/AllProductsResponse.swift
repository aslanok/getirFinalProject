//
//  AllProductsResponse.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 19.04.2024.
//

import Foundation

struct AllProductsResponse: Codable {
    let id: String
    let name: String?
    let productCount: Int?
    let products: [ProductResponse]?
    let email, password: String?
}
