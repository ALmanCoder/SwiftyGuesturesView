//
//  GHSettingGPView.swift
//  SwiftyGuesturesView
//
//  Created by wuguanghui on 2017/8/23.
//  Copyright © 2017年 wuguanghui. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


import UIKit
import SwiftyGuesturesView

// MARK: - 设置手势密码
class GHSettingGPView: UIView ,GHGPViewDelegate {

    let gpvW = GH_S_WIDTH - GH_Scale(34) * 2
    // MARK: - gpView
    lazy var gpView : GHGPasswordView = {
        let gpView = GHGPasswordView(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width : self.gpvW,
                                                   height: self.gpvW)
        )
        gpView.gpviewDelegate = self
        self.addSubview(gpView)
        return gpView
    }()
    
    // MARK: - gpvView
    lazy var gpvView : GHGuesturesViewerView = {
        let gpvView = GHGuesturesViewerView(frame: CGRect(x: 0,
                                                          y: 0,
                                                          width : GH_Scale(40),
                                                          height: GH_Scale(40))
        )
        self.addSubview(gpvView)
        return gpvView
    }()

    // MARK: - bgImgView
    lazy var bgImgView : UIImageView = {
        let bgImgView = UIImageView()
        bgImgView.image = UIImage(named: "guest")
        bgImgView.isUserInteractionEnabled = true
        self.addSubview(bgImgView)
        return bgImgView
    }()
    
    // MARK: - noticeLabel
    lazy var noticeLabel : UILabel = {
        let noticeLabel = UILabel(frame: CGRect(x: 0,
                                                y: 0,
                                                width : GH_S_WIDTH,
                                                height: GH_Scale(20))
        )
        noticeLabel.textAlignment = .center
        noticeLabel.textColor = .white
        noticeLabel.font = GH_FONT(16)
        noticeLabel.text = "请绘制解锁图案"
        self.addSubview(noticeLabel)
        return noticeLabel
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgImgView.frame = frame
        
        gpView.center = self.center
        
        gpvView.centerX = self.centerX
        noticeLabel.y =  gpView.y - GH_Scale(40)
        gpvView.y = noticeLabel.y - GH_Scale(60)
    }
    
    // MARK: - do anything you want
    func didEndSwipeWithPassword(gpView: GHGPasswordView, password: String) -> NodeState {
        
        gpvView.password = password
        GH_Util.shakerView(noticeLabel)
        
        return .warning
    }
}
