//
//  CollectionViewBackgroundView.swift
//  musicPlayer-Animation
//
//  Created by Hossam on 4/2/20.
//  Copyright © 2020 Hossam. All rights reserved.
//

import UIKit

protocol LayoutDelegate : class {
    func viewDidLayoutSubviews()
}
enum TitlePosition {
    case mostTop
    case mostBottom
}

enum MoveDirection {
    case top (CGFloat)
    case down (CGFloat)
    
}

class BackgroundView : UIView  , UICollectionViewDelegate , LayoutDelegate{
    var numberOfCells = 0
    var currentFullPercentage : CGFloat = 0
    var currentOrigins = [CGFloat]()
    lazy var title1HeightConstraints  = self.titleView1.topAnchor.constraint(equalTo: self.topAnchor , constant: CGFloat(self.bottom))
      lazy var title2HeightConstraints = self.titleView2.topAnchor.constraint(equalTo: self.topAnchor , constant: CGFloat(self.top))
           
      var titleView1 : TitleStackView  = .init()
        
      var titleView2 : TitleStackView  = .init()
       
      lazy var titlesViews = [self.titleView1 , self.titleView2]
    lazy var imageViews = [self.imageView1 , self.imageView2]

    func findLessAlpha() -> UIImageView{
        self.imageViews.sorted {$0.alpha < $1.alpha}.first!
    }
    
    func findGreatAlpha()->UIImageView {
        self.imageViews.sorted {$0.alpha > $1.alpha}.first!
    }
    
    var currentView = 0
    
    
    var currentPrecentage  : CGFloat = 0
    private var offsetPerItem = CGFloat.zero
    
    private var previousFocused = 0
    var currentFocusedCell = 0 {
        didSet {
            
            
            
            

            
            
            
            
            
        currentFocusedCellChanged()
        }
        willSet {
            self.previousFocused = self.currentFocusedCell
        }
    }
    
    func currentFocusedCellChanged(){
        //ChangeValueOfHiddentTopValue and animate
                   if previousFocused != self.currentFocusedCell {
                       //NEXT
                       if previousFocused < self.currentFocusedCell{
                           
                           animateWith(currentPrecentage)
                        imageViews[currentView].image = images[currentFocusedCell == numberOfCells-1 ? 0 : self.currentFocusedCell+1]
                           titlesViews[currentView].changeTitles(song: currentFocusedCell == numberOfCells-1 ? "" : fakeSongTitle[self.currentFocusedCell+1], artist: currentFocusedCell == numberOfCells-1 ? "" : fakeSongArtist[self.currentFocusedCell+1])
                            self.currentView = self.currentView.toggle
                           }
                       else {
           //Fine View with alpha = 0 , and change it to previous value
                           
                           self.titlesViews.sorted(by: {$0.alpha < $1.alpha}).first!.changeTitles(song: fakeSongTitle[currentFocusedCell == 0 ? 0 : currentFocusedCell], artist: fakeSongArtist[currentFocusedCell == 0 ? 0 : currentFocusedCell])
                        self.imageViews.sorted(by: {$0.alpha < $1.alpha}).first!.image  = images[currentFocusedCell == 0 ? 0 : currentFocusedCell]
                            
                               animateWith(currentPrecentage)
                            self.currentView = self.currentView.toggle
                       }
                           
                      
                   }
                   else if self.currentFocusedCell == 0  {
                       //JustCompleteAnimation
                      
                       titlesViews[currentView].changeTitles(song: fakeSongTitle[currentFocusedCell], artist: fakeSongArtist[currentFocusedCell])
                       titlesViews[currentView.toggle].changeTitles(song: fakeSongTitle[currentFocusedCell+1], artist: fakeSongArtist[currentFocusedCell+1])
                    imageViews[currentView].image = images[currentFocusedCell]
                    imageViews[currentView.toggle].image = images[currentFocusedCell+1]
                       animateWith(currentPrecentage  )
                   }
                   else {
                       animateWith(currentPrecentage  )
                       
                   }
    }
    func animateWith(_ percentage : CGFloat) {
        imageViews[currentView].frame.origin.x =    10 * (-currentFullPercentage)
        imageViews[currentView.toggle].frame.origin.x = 10 * (-currentFullPercentage)
        
        imageViews[currentView].alpha =   1 - (percentage)
        imageViews[currentView.toggle].alpha = percentage
        
        titlesViews[currentView].alpha = 1 - percentage
        titlesViews[currentView.toggle].alpha = percentage
        self.getTopConstraint(titlesViews[currentView]).constant = bottom + ((bottom - top) * currentPrecentage)
        self.getTopConstraint(titlesViews[currentView.toggle]).constant = top + ((bottom - top) * currentPrecentage)
        
    }
    
    var contentSize = CGFloat.zero {
           didSet {
                var  collectionView = superview as! UICollectionView
               self.offsetPerItem = self.contentSize  / CGFloat(collectionView.numberOfItems(inSection: 0))
            
           }
       }
    
    func viewDidLayoutSubviews() {
        guard let collectionView = superview as? UICollectionView else {return}
        self.contentSize = collectionView.contentSize.width
        self.numberOfCells  = collectionView.numberOfItems(inSection: 0)
    }
    
     
    
    var top : CGFloat = 60
    var bottom : CGFloat = 120
 
    var imageView1 : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.frame = .init(origin: .zero, size: .init(width: UIScreen.main.bounds.size.width + 100, height: UIScreen.main.bounds.height))
        imageView.alpha = 1
        imageView.clipsToBounds = true
        return imageView
    }()

    var imageView2 : UIImageView = {
           let imageView = UIImageView()
           imageView.backgroundColor = .white
           imageView.contentMode = .scaleAspectFill
           imageView.clipsToBounds  =  true
           imageView.alpha = 0
           imageView.frame = .init(x: 0  , y: 0, width: UIScreen.main.bounds.width + 100, height: UIScreen.main.bounds.height)
           return imageView
       }()

 
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView1)
        self.addSubview(imageView2)
       
        configGredient()
        self.backgroundColor = .black
        setupViewsConstraints()

        self.addSubview(titleView1)
        self.addSubview(titleView2)
        NSLayoutConstraint.activate([
            self.titleView1.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.titleView2.centerXAnchor.constraint(equalTo: self.centerXAnchor)])
        NSLayoutConstraint.activate([title1HeightConstraints , title2HeightConstraints])
        
    }
    
   
    private func setupViewsConstraints(){
        
}
    func current(state : TitlePosition)->TitleStackView{
        switch state {
        case .mostTop : return self.titlesViews.sorted { $0.frame.origin.y < $1.frame.origin.y }.first!
        case .mostBottom : return self.titlesViews.sorted { $0.frame.origin.y > $1.frame.origin.y }.first!
        }
    }
    
    
    
    private func configGredient(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.cgColor , UIColor.black.cgColor , #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4367508562).cgColor ]
        gradientLayer.frame = .init(origin: .init(x: self.frame.origin.x, y: self.frame.origin.y ), size: .init(width: self.frame.width, height: self.frame.height + 90))
        gradientLayer.startPoint = .init(x: 0.5, y: 1)
        gradientLayer.endPoint = .init(x: 0.5, y: 0)
        self.layer.addSublayer(gradientLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let  collectionView = superview as! UICollectionView
        let currentOffsetPerItem = CGFloat(scrollView.contentOffset.x  ) / offsetPerItem
        currentFullPercentage = currentOffsetPerItem
        self.currentFocusedCell  = min(collectionView.numberOfItems(inSection: 0), max(0, Int(currentOffsetPerItem)) )
        
        self.currentPrecentage = currentOffsetPerItem - CGFloat(self.currentFocusedCell)

       
        
        
        
    }
}



extension Int {
    var toggle : Int{
    
if self == 0 { return 1}
else  {return 0} }
    
}


extension  BackgroundView{
    func getTopConstraint(_ view : TitleStackView )-> NSLayoutConstraint {
        if view == self.titleView1 {
            return title1HeightConstraints
        }else {
            return title2HeightConstraints
        }
    }
    
}
