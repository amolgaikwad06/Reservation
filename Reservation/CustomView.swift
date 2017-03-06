//
//  CustomView.swift
//  Reservation
//
//  Created by Amol Gaikwad on 2/17/17.
//  Copyright © 2017 Amol Gaikwad. All rights reserved.
//

import UIKit

@IBDesignable
class CustomView: UIView
{
    
    @IBInspectable var borderWidth: CGFloat = 1.0
        {
        
        didSet
        {
            
            self.layer.borderWidth = borderWidth
        }
    }
    
    
    @IBInspectable var borderColor: UIColor = UIColor.clear
        {
        
        didSet
        {
            
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat = 0
        {
        
        didSet
        {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func prepareForInterfaceBuilder()
    {
        
        super.prepareForInterfaceBuilder()
    }
}
