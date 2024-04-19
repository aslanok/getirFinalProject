//
//  DetailPagePresenter.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 19.04.2024.
//

import Foundation

protocol DetailPagePresentation{
    func back()
}

class DetailPagePresenter : DetailPagePresentation{
    
    internal var output : DetailPageViewContract!
    private var router : DetailPageRouting
    
    init(output: DetailPageViewContract!, router: DetailPageRouting) {
        self.output = output
        self.router = router
    }
    
    func back() {
        router.back(from: output)
    }
    
    
    
}
