//
//  AVPlayerView.swift
//  ScrollViewLikeCChannel
//
//  Created by 中島　頌太 on 2015/08/27.
//  Copyright © 2015年 nakazy. All rights reserved.
//

import AVFoundation
import UIKit

class AVPlayerView : UIView{
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override class func layerClass() -> AnyClass{
        return AVPlayerLayer.self
    }
}
