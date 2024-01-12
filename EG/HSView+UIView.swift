//
//  HSView+UIView.swift
//  HSTaxiUserApp
//
//  Created by APPLE on 14/03/18.
//  Copyright © 2018 APPLE. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    //MARK: shadow effect
    func crapView(radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
 
    func setBottomViewCornerRadius(radius: CGFloat) {
           self.layer.cornerRadius = radius
           self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
       }
}




