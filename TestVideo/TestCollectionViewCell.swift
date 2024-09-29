//
//  TestCollectionViewCell.swift
//  TestVideo
//
//  Created by edy on 2024/8/29.
//

import UIKit
import AVFoundation

class TestCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    func cellSetVideo()  {
        
        self.layoutIfNeeded()
        
//         let filePath = Bundle.main.path(forResource: "testVideo", ofType: "MP4")
//        let videoPath = URL.init(resource: URLResource.init(name: "testVideo1.MP4"))!
        let player = AVPlayer(url: URL.init(string: "http://lc-Eq0WF1MR.cn-n1.lcfile.com/7ixNjGUhA18ww8euLaurik0mx6AFX70o/testVideo.MP4")!)
         
        // 创建一个 AVPlayerLayer 实例来展示视频
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.bounds
//        playerLayer.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.size.width), height: Int(UIScreen.main.bounds.size.height))

        // 将播放层添加到视图
        self.layer.addSublayer(playerLayer)
         
        // 播放视频
        player.play()
    }

}
