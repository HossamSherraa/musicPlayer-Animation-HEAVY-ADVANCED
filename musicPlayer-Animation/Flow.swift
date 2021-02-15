//
//  Flow.swift
//  musicPlayer-Animation
//
//  Created by Hossam on 4/5/20.
//  Copyright © 2020 Hossam. All rights reserved.
//

import UIKit
class Flow : UICollectionViewFlowLayout  {
    
    lazy var offsetPerItem = self.collectionViewContentSize.width  / CGFloat(collectionView!.numberOfItems(inSection: 0))
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: self.collectionView!.bounds)
       return  attributes!.map{
        
        let attributes = LayoutAttributes(forCellWith: $0.indexPath)
        let item = $0.indexPath.item
        let currentOffset =  (collectionView!.contentOffset.x /  offsetPerItem ) - CGFloat(item)
        
        var affine = CATransform3DIdentity
        affine.m34 = 1 / -400
        attributes.rotation3D = CATransform3DRotate(affine, (-(45 * 3.14) / 180) * currentOffset , 0, 1, 0)
        attributes.frame = $0.frame
        
        attributes.parralex = CGAffineTransform.init(translationX: 500 * currentOffset, y: 0)
        return attributes
            
        }
       
    }
    
    
    override class var layoutAttributesClass: AnyClass {
        LayoutAttributes.self
    }
    
   
    
    
}
