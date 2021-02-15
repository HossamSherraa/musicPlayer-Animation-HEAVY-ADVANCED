//
//  LayoutAttributes.swift
//  musicPlayer-Animation
//
//  Created by Hossam eldin on 6/17/20.
//  Copyright © 2020 Hossam. All rights reserved.
//

import UIKit
class LayoutAttributes : UICollectionViewLayoutAttributes {
    var rotation3D : CATransform3D!
    var parralex : CGAffineTransform!
    override func copy(with zone: NSZone?) -> Any {
        guard let attributes = super.copy(with: zone) as? LayoutAttributes else { return UICollectionViewLayoutAttributes() }
        attributes.rotation3D = self.rotation3D
        attributes.parralex = self.parralex
       
        return attributes
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let attributes = object as? LayoutAttributes else { return false }
        guard NSValue(caTransform3D:attributes.rotation3D) == NSValue(caTransform3D: rotation3D) else { return false }
        guard NSValue(cgAffineTransform:attributes.parralex) == NSValue(cgAffineTransform: parralex) else { return false }
        
        return super.isEqual(object)
    }
    
}
