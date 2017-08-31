//
//  GHGuesturesViewerView.swift
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

public class GHGuesturesViewerView: UIView {

    // MARK: - 密码指示器
    public var password : String = "" {
        willSet {
            self.password = newValue
        }
        didSet {
            for (_,gvnView) in gvnViewArray.enumerated() {
                gvnView.vpShapeLayer.fillColor = UIColor.clear.cgColor
            }
            let pstr : NSString = NSString(string: password)
            for i in 0..<password.characters.count {
                let sub = pstr.substring(with: NSRange(location: i, length: 1)) as NSString
                let cgvnView = gvnViewArray[sub.integerValue]
                cgvnView.vpShapeLayer.strokeColor = HexToColor(hex: "#cf9872").cgColor
                cgvnView.vpShapeLayer.fillColor   = HexToColor(hex: "#cf9872").cgColor
            }
        }
    }
    
    private var gvnViewArray = [GHGuesturesViewerNodeView]()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        if gvnViewArray.count > 0 { gvnViewArray.removeAll() }
        for (_,node) in subviews.enumerated() { node.removeFromSuperview() }
        
        for i in 0...8 {
            let gvnView = GHGuesturesViewerNodeView()
            gvnView.tag = i
            gvnViewArray.append(gvnView)
            self.addSubview(gvnView)
        }
    }
    
    public  required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        let min = width < height ? width : height
        let w = min / 5
        let h = min / 5
        for (index,gvnView) in gvnViewArray.enumerated() {
            let row = index % 3
            let col = index / 3
            gvnView.frame = CGRect(x: CGFloat(row * 2) * w,
                                   y: CGFloat(col * 2) * h,
                                   width : w,
                                   height: h
            )
        }
    }

}

public class GHGuesturesViewerNodeView: UIView {
    // MARK: - vpShapeLayer
    public lazy var vpShapeLayer : CAShapeLayer = {
        let vpShapeLayer = CAShapeLayer()
        vpShapeLayer.lineWidth = GH_Scale(1)
        vpShapeLayer.strokeColor = HexToColor(hex: "#cf9872").cgColor
        vpShapeLayer.fillColor = UIColor.clear.cgColor
        return vpShapeLayer
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(vpShapeLayer)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("initError")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        vpShapeLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        let vpPath = UIBezierPath(ovalIn: bounds)
        vpShapeLayer.path = vpPath.cgPath
    }
}
