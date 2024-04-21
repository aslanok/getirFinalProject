//
//  ShoppingCartViewController.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 21.04.2024.
//

import UIKit

protocol ShoppingCartViewContract : UIViewController {
    
}

class ShoppingCartViewController: UIViewController, ShoppingCartViewContract {
    
    var presenter : ShoppingCartPresentation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupUI(){
        view.backgroundColor = .Theme.viewBackgroundColor
        
    }
    
}


