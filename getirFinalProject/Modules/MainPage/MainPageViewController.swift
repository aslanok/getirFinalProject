//
//  MainPageViewController.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 16.04.2024.
//

import UIKit

protocol MainPageViewContract : UIViewController{
    
}

class MainPageViewController : UIViewController, MainPageViewContract{
    
    var presenter : MainPagePresentation?
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ürünler"
        label.font = UIFont(name: "OpenSans-Bold", size: 14)
        //label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .Theme.white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .Theme.primaryColor
        setupUI()
        
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
    }
    
    func setupUI(){
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        //titleLabel.widthAnchor.co
    }
    
    
    
}
