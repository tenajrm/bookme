//
//  TextFieldWithPadding.swift
//  Bookme
//
//  Created by Janet Rivas on 6/14/17.
//  Copyright © 2017 Janet Rivas. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class TextFieldWithPadding: UITextField {
    
    @IBInspectable var horizontalInset: CGFloat = 0
    @IBInspectable var verticalInset: CGFloat = 0
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: horizontalInset, dy: verticalInset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: horizontalInset , dy: verticalInset)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: horizontalInset, dy: verticalInset)
    }
}
