//
//  MainPagePresenter.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 17.04.2024.
//

import Foundation

protocol MainPagePresentation{
}


class MainPagePresenter : MainPagePresentation{
    
    internal var output : MainPageViewContract!
    private var router : MainPageRouting
    
    init(router : MainPageRouting, view : MainPageViewContract){
        self.output = view
        self.router = router
    }
    
    
}
