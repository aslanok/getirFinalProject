//
//  CountableBasketView.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 20.04.2024.
//

import UIKit

protocol CountableBasketViewDelegate: AnyObject {
    func productCountDidUpdate(_ count: Int)
}

class CountableBasketView : UIView{
    
    weak var delegate: CountableBasketViewDelegate?
    
    private var productCount: Int = 1 {
        didSet {
            updateUI()
        }
    }
    private var layoutOrientation: LayoutOrientation


    init(frame: CGRect, initialCount: Int = 1, orientation: LayoutOrientation = .horizontal) {
        self.layoutOrientation = orientation
        super.init(frame: frame)
        self.productCount = initialCount
        setupView()
        updateUI()
    }
        
    required init?(coder: NSCoder) {
        self.layoutOrientation = .horizontal // Default to horizontal
        super.init(coder: coder)
    }

    private lazy var decrementButton: UIButton = {
        let button = UIButton( )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "garbageIcon"), for: .normal)
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.Theme.shadowGray.cgColor
        button.addTarget(self, action: #selector(decrementCount), for: .touchUpInside)
        return button
    }()

    private lazy var incrementButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plusSign"), for: .normal)
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.Theme.shadowGray.cgColor
        button.addTarget(self, action: #selector(incrementCount), for: .touchUpInside)
        return button
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = .Theme.primaryColor
        label.textColor = .Theme.white
        label.font = UIFont(name: "OpenSans-Bold", size: layoutOrientation == .horizontal ? 16 : 12)
        label.text = "\(productCount)"
        return label
    }()
    
    func setupHorizontalLayout(){
        decrementButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        decrementButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        decrementButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        decrementButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        //incrementButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        incrementButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        incrementButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        incrementButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        incrementButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        self.bringSubviewToFront(countLabel)
        countLabel.leadingAnchor.constraint(equalTo: decrementButton.trailingAnchor, constant: -3).isActive = true
        countLabel.trailingAnchor.constraint(equalTo: incrementButton.leadingAnchor, constant: 3).isActive = true
        countLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    func setupVerticalLayout(){
        incrementButton.topAnchor.constraint(equalTo: self.topAnchor,constant: 3).isActive = true
        incrementButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        incrementButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        incrementButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        decrementButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        //decrementButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        //decrementButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        decrementButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        decrementButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        decrementButton.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -3).isActive = true
        
        self.bringSubviewToFront(countLabel)
        countLabel.topAnchor.constraint(equalTo: incrementButton.bottomAnchor, constant: -3).isActive = true
        countLabel.bottomAnchor.constraint(equalTo: decrementButton.topAnchor, constant: 3).isActive = true
        countLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        
        
    }
    
    func setupView(){
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(decrementButton)
        self.addSubview(countLabel)
        self.addSubview(incrementButton)
        
        switch layoutOrientation {
        case .horizontal:
            setupHorizontalLayout()
        case .vertical:
            setupVerticalLayout()
        }

    }
    
    @objc private func decrementCount() {
        productCount = max(0, productCount - 1)
    }
    
    @objc private func incrementCount() {
        productCount += 1
    }
    
    func updateUI(){
        delegate?.productCountDidUpdate(productCount)
        countLabel.text = "\(productCount)"
        if productCount > 1{
            decrementButton.setImage(UIImage(named: "minusSign"), for: .normal)
        } else{
            decrementButton.setImage(UIImage(named: "garbageIcon"), for: .normal)
        }
    }
    
    func setInitialCount(count : Int){
        productCount = count
    }
    
    func getProductCount() -> Int{
        return productCount
    }
    
}
