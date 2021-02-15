//
//  ViewController.swift
//  musicPlayer-Animation
//
//  Created by Hossam on 4/2/20.
//  Copyright © 2020 Hossam. All rights reserved.
//

import UIKit
class ViewController: UIViewController{
    weak var delegate :LayoutDelegate?
    override func viewDidLayoutSubviews() {
        delegate?.viewDidLayoutSubviews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    
        
        let flow : Flow = {
           
             let flow = Flow()
             flow.sectionInset.top = view.bounds.height / 3.4
             flow.sectionInset.bottom = 30
             flow.sectionInset.left = 60
             flow.sectionInset.right = 60
             flow.minimumLineSpacing = 120
             flow.itemSize = .init(width: self.view.bounds.width - 120, height: self.view.bounds.height -  (flow.sectionInset.top  + flow.sectionInset.bottom))
             flow.scrollDirection = .horizontal
             return flow
             }()
        
             let collectionView  : UICollectionView  = {
                 let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flow)
                collectionView.isPagingEnabled = true
                collectionView.decelerationRate = .fast
               
                 collectionView.dataSource = self
                 collectionView.register(Cell.self, forCellWithReuseIdentifier: "Cell")
                 let backView = BackgroundView(frame: collectionView.frame)
                
                 backView.imageView2.image = images[1]
                backView.imageView1.image = images[0]
                self.delegate = backView
                backView.currentFocusedCell = 0
                collectionView.delegate = backView
                 collectionView.backgroundView = backView
                
                
                 return collectionView
             }()
             
             self.view.addSubview(collectionView)
         }
    }
    
    


extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        cell.albumCover.image = images[indexPath.row]
        return cell
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
