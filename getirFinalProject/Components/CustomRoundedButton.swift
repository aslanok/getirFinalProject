//
//  CustomRoundedButton.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 23.04.2024.
//

import UIKit

class CustomRoundedButton: UIButton {
    
    private var roundedCorners: UIRectCorner = []
    private var cornerRadius: CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.layer.cornerRadius = 0  // Clear any default rounding
        self.clipsToBounds = true  // This allows the mask to clip the view's content
    }
    
    func setRoundedCorners(corners: UIRectCorner, radius: CGFloat) {
        self.roundedCorners = corners
        self.cornerRadius = radius
        applyRoundedCorners()
    }

    private func applyRoundedCorners() {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: roundedCorners,
                                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        applyRoundedCorners()  // Reapply the rounded corners every time the view layout is updated
    }
}
