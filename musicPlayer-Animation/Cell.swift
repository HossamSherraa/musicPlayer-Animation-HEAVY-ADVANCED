//
//  Cell.swift
//  musicPlayer-Animation
//
//  Created by Hossam on 4/2/20.
//  Copyright © 2020 Hossam. All rights reserved.
//

import UIKit

class Cell : UICollectionViewCell {
    
    
   
   
  lazy var  albumCover : UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
    
    let verticalMotion = UIInterpolatingMotionEffect(keyPath: "0", type: .tiltAlongVerticalAxis)
    let horizontalMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type: .tiltAlongHorizontalAxis)
    verticalMotion.maximumRelativeValue = 50
    verticalMotion.minimumRelativeValue = -50
    horizontalMotion.maximumRelativeValue = 50
    horizontalMotion.minimumRelativeValue = -50
    
    let motionGroups = UIMotionEffectGroup()
    motionGroups.motionEffects = [verticalMotion , horizontalMotion]
           imageView.addMotionEffect(motionGroups)

        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewsConstraints()
        configCellShape()
    }
    
    override func prepareForReuse() {
        self.contentView.transform = CATransform3DGetAffineTransform(CATransform3DIdentity)
    }
    
    private func setupViewsConstraints(){
        self.contentView.addSubview(albumCover)
           NSLayoutConstraint.activate([
           self.albumCover.topAnchor.constraint(equalTo: self.topAnchor , constant:  -90) ,
           self.albumCover.leadingAnchor.constraint(equalTo: self.leadingAnchor) ,
           self.albumCover.trailingAnchor.constraint(equalTo: self.trailingAnchor) ,
           self.albumCover.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: 0)
           ])
       }
    
    func configCellShape(){
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        guard let attributes = layoutAttributes as? LayoutAttributes else {fatalError()}
        
        if #available(iOS 13, *){
            self.contentView.transform3D = attributes.rotation3D
            self.albumCover.transform = attributes.parralex
        }else {
            self.contentView.layer.transform = attributes.rotation3D
            self.albumCover.transform = attributes.parralex
        }
        
    }
}
