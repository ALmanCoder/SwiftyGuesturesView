//
//  GH_Util.swift
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

public class GH_Util: NSObject {
    // MARK: - 视图抖动效果
    public class func shakerView(_ ashakerView:UIView) {
        let kfanimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        let cTx = ashakerView.transform.tx
        kfanimation.duration = 0.4
        kfanimation.values = [cTx, cTx+10, cTx-8, cTx+8, cTx-5, cTx+5, cTx]
        kfanimation.keyTimes = [(0), (0.225), (0.425), (0.525), (0.750), (0.875), (1)]
        kfanimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        ashakerView.layer.add(kfanimation, forKey: "kShakerAnimationKey")
    }
}
