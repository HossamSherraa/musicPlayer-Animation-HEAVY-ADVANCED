//
//  TitleStackView.swift
//  musicPlayer-Animation
//
//  Created by Hossam on 4/4/20.
//  Copyright © 2020 Hossam. All rights reserved.
//

import UIKit

class TitleStackView : UIStackView {
    var songTitle : UILabel = {
      let label = UILabel()
       label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
       label.textColor = .white
       return label
   }()
     var  songArtist : UILabel = {
      let label = UILabel()
       label.textColor  = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
       label.font = UIFont.systemFont(ofSize: 19, weight: .regular)
       return label
   }()
    
    init() {
        super.init(frame: .zero)
        self.addArrangedSubview(songTitle)
        self.addArrangedSubview(songArtist)
        axis = .vertical
        self.translatesAutoresizingMaskIntoConstraints  = false 
        alignment = .center
        distribution = .fillEqually
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func changeTitles(song : String , artist : String){
        self.songTitle.text = song
        self.songArtist.text = artist
    }
    
}
