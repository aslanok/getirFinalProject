//
//  PopUpView.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 24.04.2024.
//

import UIKit

protocol PopUpViewDelegate : AnyObject {
    func buttonYesTapped()
    func buttonNoTapped()
}

class PopUpView: UIView {
    
    weak var delegate : PopUpViewDelegate?
    
    private lazy var contentView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .Theme.white
        view.layer.cornerRadius = 6
        return view
    }()
    
    // UI Elements
    private lazy var messageLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sepetini boşaltmak istediğinden emin misin?"
        label.textColor = .Theme.darkText
        label.font = UIFont(name: "OpenSans-SemiBold", size: 14)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var buttonYes : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Evet", for: .normal)
        button.backgroundColor = UIColor.Theme.primaryColor
        button.setTitleColor(.Theme.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(buttonYesTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonNo : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Hayır", for: .normal)
        button.backgroundColor = UIColor.Theme.grayText
        button.setTitleColor(.Theme.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(buttonNoTapped), for: .touchUpInside)
        return button
    }()
    
    
    // Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // Setup the view appearance and layout
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black.withAlphaComponent(0.6)
        clipsToBounds = true

        // Setup message label
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        addSubview(contentView)
        
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        contentView.addSubview(messageLabel)
        
        // Add buttons to the view
        contentView.addSubview(buttonNo)
        contentView.addSubview(buttonYes)

        messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        buttonNo.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 15).isActive = true
        buttonNo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        buttonNo.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -4).isActive = true
        buttonNo.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        buttonYes.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 15).isActive = true
        buttonYes.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 4).isActive = true
        buttonYes.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        buttonYes.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc func buttonYesTapped(){
        delegate?.buttonYesTapped()
        print("yes tapped")
    }
    
    @objc func buttonNoTapped(){
        delegate?.buttonNoTapped()
        print("no tapped")
    }
    
    // Configure the popup with specific data
    func configure(message: String, buttonOneTitle: String, buttonTwoTitle: String) {
        messageLabel.text = message
        
    }
}
