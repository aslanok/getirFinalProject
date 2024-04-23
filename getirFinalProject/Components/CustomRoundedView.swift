//
//  OneSideRoundedView.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 17.04.2024.
//

/* Example Usage :
 let view = CustomRoundedView()
 view.translatesAutoresizingMaskIntoConstraints = false
 view.backgroundColor = .Theme.lightPurple
 view.cornerRadius = 6
 view.roundedCorners = [.topRight, .bottomRight]
*/

import UIKit

class CustomRoundedView: UIView {
    
    // Corners to be rounded
    var roundedCorners: UIRectCorner = [] {
        didSet {
            setNeedsLayout() // Redraw when corners change
        }
    }
    
    var cornerRadius: CGFloat = 0 {
        didSet {
            setNeedsLayout() // Redraw when radius changes
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        applyRoundedCorners(corners: roundedCorners, radius: cornerRadius)
    }
    
    private func applyRoundedCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
