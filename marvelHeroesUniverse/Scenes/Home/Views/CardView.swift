//
//  CardView.swift
//  marvelHeroesUniverse
//
//  Created by kjoe on 5/15/22.
//

import UIKit
@IBDesignable class CardView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 10
    @IBInspectable var shadowsOffSetWidth: CGFloat = 0
    @IBInspectable var shadowsOffSetHeight: CGFloat = 0
    @IBInspectable var shadowColor: UIColor = UIColor.gray
    @IBInspectable var shadowOpacity: CGFloat = 0.16
    @IBInspectable var shadowBlur: CGFloat = 20
    @IBInspectable var shadowSpread: CGFloat = 0
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = .black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = 10
        let dxVal = -shadowSpread
        let rect  = bounds.insetBy(dx: dxVal, dy: dxVal)
        layer.shadowPath = UIBezierPath(rect: rect).cgPath
        layer.shadowRadius = shadowBlur / 2
        layer.shadowOffset = CGSize(width: shadowsOffSetWidth, height: shadowsOffSetHeight)
        layer.shadowOpacity = Float(shadowOpacity)
    }
}
