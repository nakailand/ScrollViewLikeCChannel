//
//  MainScrollView.swift
//  ScrollViewLikeCChannel
//
//  Created by 中島　頌太 on 2015/08/27.
//  Copyright © 2015年 nakazy. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMedia

class MainScrollView: UIScrollView, UIScrollViewDelegate {
    private var videoPlayer : AVPlayer!
    private var seekBar : UISlider!
    private var videoPlayerView: AVPlayerView!
    private var startButton: UIButton!
    
    init() {
        super.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let avAsset = AVURLAsset(URL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("IMG_1261", ofType: "MOV")!), options: nil)
        videoPlayer = AVPlayer(playerItem: AVPlayerItem(asset: avAsset))
        
        // 動画Viewの初期化
        videoPlayerView = AVPlayerView(frame: self.bounds)
        self.addSubview(videoPlayerView)
        let layer = videoPlayerView.layer as! AVPlayerLayer
        layer.videoGravity = AVLayerVideoGravityResizeAspect
        layer.player = videoPlayer
        self.layer.addSublayer(layer)
        
        
        // シークバーの初期化
        seekBar = UISlider(frame: CGRectMake(0, 0, self.bounds.maxX - 100, 50))
        seekBar.layer.position = CGPointMake(self.bounds.midX, self.bounds.maxY - 100)
        seekBar.minimumValue = 0
        seekBar.maximumValue = Float(CMTimeGetSeconds(avAsset.duration))
        seekBar.addTarget(self, action: "onSliderValueChange:", forControlEvents: UIControlEvents.ValueChanged)
        self.addSubview(seekBar)
        
        
        // シークバーを動画とシンクロさせる為の処理.
        videoPlayer.addPeriodicTimeObserverForInterval(CMTimeMakeWithSeconds(Double(0.5 * seekBar.maximumValue) / Double(seekBar.bounds.maxX), Int32(NSEC_PER_SEC)), queue: nil) { time in
            let duration = CMTimeGetSeconds(self.videoPlayer.currentItem!.duration)
            let time = CMTimeGetSeconds(self.videoPlayer.currentTime())
            let value = Float(self.seekBar.maximumValue - self.seekBar.minimumValue) * Float(time) / Float(duration) + Float(self.seekBar.minimumValue)
            self.seekBar.value = value
        }
        
        // 動画の再生ボタンの初期化
        startButton = UIButton(frame: CGRectMake(0, 0, 50, 50))
        startButton.layer.position = CGPointMake(self.bounds.midX, self.bounds.maxY - 50)
        startButton.layer.masksToBounds = true
        startButton.layer.cornerRadius = 20.0
        startButton.backgroundColor = UIColor.orangeColor()
        startButton.setTitle("Start", forState: UIControlState.Normal)
        startButton.addTarget(self, action: "onButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(startButton)
        
        self.delegate = self
        self.contentSize.height = self.bounds.height * 3
        self.backgroundColor = UIColor.blackColor()
        let view = UIView(frame: CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: self.bounds.height * 2))
        self.addSubview(view)
        view.backgroundColor = UIColor.yellowColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // 再生ボタンが押された時に呼ばれるメソッド.
    func onButtonClick(sender : UIButton){
        
        // 再生時間を最初に戻して再生.
        videoPlayer.seekToTime(CMTimeMakeWithSeconds(0, Int32(NSEC_PER_SEC)))
        videoPlayer.play()
        
    }
    
    // シークバーの値が変わった時に呼ばれるメソッド.
    func onSliderValueChange(sender : UISlider){
        
        // 動画の再生時間をシークバーとシンクロさせる.
        videoPlayer.seekToTime(CMTimeMakeWithSeconds(Float64(seekBar.value), Int32(NSEC_PER_SEC)))
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        videoPlayerView.transform = CGAffineTransformMakeScale(1 - (scrollView.contentOffset.y / (self.bounds.height * 1.5)), 1 - (scrollView.contentOffset.y / (self.bounds.height * 2)))
        videoPlayerView.frame.origin.y = scrollView.contentOffset.y * 1.1
        
        if scrollView.contentOffset.y > 20 {
            hideMediaButton()
        } else {
            showMediaButton()
        }
        
        //let layer = videoPlayerView.layer
        //var rotationAndPerspectiveTransform = CATransform3DIdentity
        //rotationAndPerspectiveTransform.m34 = 1.0 / -500
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, CGFloat(45.0 * M_PI / 360.0), CGFloat(1), CGFloat(1), CGFloat(0))
        //layer.transform = rotationAndPerspectiveTransform
    }
    
    private func hideMediaButton() {
        startButton.hidden = true
        seekBar.hidden = true
    }
    
    private func showMediaButton() {
        startButton.hidden = false
        seekBar.hidden = false
    }
}
