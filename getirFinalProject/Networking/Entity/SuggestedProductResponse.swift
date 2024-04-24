//
//  SuggestedProductResponse.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 19.04.2024.
//

import Foundation

// MARK: - SuggestedProductsResponse
struct SuggestedProductsResponse: Codable {
    let products: [ProductResponse]
    let id, name: String?
}
