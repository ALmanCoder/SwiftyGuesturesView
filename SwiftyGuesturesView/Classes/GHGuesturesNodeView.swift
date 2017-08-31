//
//  GHGuesturesNodeView.swift
//  SwiftyGuesturesView
//
//  Created by wuguanghui on 2017/8/22.
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

// MARK: - 节点状态类型
public enum NodeState : Int {
    case normal       // 普通
    case selected     // 选中
    case warning      // 警告
}

// MARK: - 每个节点
public class GHGuesturesNodeView: UIView {
   
    // MARK: - property        /    变量声明
    // MARK: -外圈边框
    public lazy var outLineSLayer : CAShapeLayer = {
        let outLineSLayer = CAShapeLayer()
        outLineSLayer.strokeColor = HexToColor(hex: "#cf9872").cgColor
        outLineSLayer.lineWidth = GH_Scale(1)
        outLineSLayer.fillColor = UIColor.clear.cgColor
        return outLineSLayer
    }()
    
    // MARK: -内圈圆形
    public lazy var innerAreaSLayer : CAShapeLayer = {
        let innerAreaSLayer = CAShapeLayer()
        innerAreaSLayer.strokeColor = UIColor.clear.cgColor
        innerAreaSLayer.lineWidth = GH_Scale(1)
        innerAreaSLayer.fillColor = UIColor.clear.cgColor
        return innerAreaSLayer
    }()
    
    // MARK: -中心实点
    public lazy var innerPointSLayer : CAShapeLayer = {
        let innerPointSLayer = CAShapeLayer()
        innerPointSLayer.strokeColor = UIColor.clear.cgColor
        innerPointSLayer.lineWidth = GH_Scale(1)
        innerPointSLayer.fillColor = UIColor.clear.cgColor
        return innerPointSLayer
    }()
    
    // MARK: -三角形箭头
    public lazy var triAnchorView : GHTriangleAnchorView = {
        let triAnchorView = GHTriangleAnchorView(frame: self.frame)
        triAnchorView.isHidden = true
        self.addSubview(triAnchorView)
        return triAnchorView
    }()
    
    // MARK: -节点状态
    public var nodeState : NodeState = .normal {
        willSet {
            self.nodeState = newValue
        }
        didSet {
            let status = nodeState
            switch status {
                case .normal:
                    let clearCG = UIColor.clear.cgColor
                    self.outLineSLayer.strokeColor  = HexToColor(hex: "#cf9872").cgColor
                    self.innerAreaSLayer.fillColor  = clearCG
                    self.innerPointSLayer.fillColor = clearCG
                    self.triAnchorView.taSLayer.fillColor = clearCG
                    self.triAnchorView.isHidden = true;
                case .selected:
                    let selectCG = RGB(82, 146, 252).cgColor
                    self.outLineSLayer.strokeColor  = selectCG
                    self.innerAreaSLayer.fillColor  = RGB(216, 230, 254).cgColor
                    self.innerPointSLayer.fillColor = selectCG
                    self.triAnchorView.taSLayer.fillColor = selectCG
                case .warning:
                    let warningCG = RGB(252, 90, 75).cgColor
                    self.outLineSLayer.strokeColor  = warningCG
                    self.innerAreaSLayer.fillColor  = RGB(254, 219, 215).cgColor
                    self.innerPointSLayer.fillColor = warningCG
                    self.triAnchorView.taSLayer.fillColor = warningCG
            }
        }
    }
    
    // MARK: - life cycle      /    生命周期
    public override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(outLineSLayer)
        layer.addSublayer(innerAreaSLayer)
        layer.addSublayer(innerPointSLayer)
        nodeState = .normal
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let outLinePath = UIBezierPath(ovalIn: bounds)
        outLineSLayer.path = outLinePath.cgPath
        
        let dwidth  = (width / 3) * 2
        let ddwidth = (width / 6)
        
        innerAreaSLayer.frame = CGRect(x: ddwidth,
                                       y: ddwidth,
                                       width : dwidth,
                                       height: dwidth)
        let innerAreaPath = UIBezierPath(ovalIn: innerAreaSLayer.bounds)
        innerAreaSLayer.path = innerAreaPath.cgPath
        
        innerPointSLayer.frame = CGRect(x: ddwidth * 2.5,
                                        y: ddwidth * 2.5,
                                        width : ddwidth,
                                        height: ddwidth)
        let innerPointPath = UIBezierPath(ovalIn: innerPointSLayer.bounds)
        innerPointSLayer.path = innerPointPath.cgPath
        
        triAnchorView.frame = bounds
    }
    
    // MARK: - public method   /    公共方法
    // MARK: -起点、△X、△Y
    public func anchorWithStartPointXY(_ startPoint:CGPoint, x:Float, y:Float) {
        var anchor : Float = 0
        if x > 0 {
            anchor = 90 + radiansToDegrees(atan(y/x))
        } else if x == 0 {
            if y > 0 {
                anchor = 180
            } else {
                anchor = 0
            }
        } else {
            anchor = 270 + radiansToDegrees(atan(y/x))
        }
        triAnchorView.angle = anchor
        triAnchorView.isHidden = false
        triAnchorView.frame = bounds
    }
    
}

// MARK: - 三角形箭头
public class GHTriangleAnchorView: UIView {
    
    // MARK: - property        /    变量声明
    // MARK: -三角实点
    public lazy var taSLayer : CAShapeLayer = {
        let taSLayer = CAShapeLayer()
        return taSLayer
    }()

    // MARK: -半径
    public var radius : CGFloat = 0 {
        willSet {
            self.radius = newValue
        }
    }
    
    // MARK: -角度
    public var angle : Float = 0 {
        willSet {
            self.angle = newValue
        }
        didSet {
            let length : CGFloat = 1
            let width  : CGFloat = GH_Scale(5)
            
            let innerLinePath = UIBezierPath()
            
            let cx = centerPoint.x + mysinf(degreesToRadians(angle)) * GH_Scale(10)
            let cy = centerPoint.y - mycosf(degreesToRadians(angle)) * GH_Scale(10)
            let center = CGPoint(x: cx, y: cy)
            
            let sx = center.x + radius * length * mysinf(degreesToRadians(angle))
            let sy = center.y - radius * length * mycosf(degreesToRadians(angle))
            let startPoint = CGPoint(x: sx, y: sy)
            
            let mx = center.x + width * mysinf(degreesToRadians(angle + 90.0))
            let my = center.y - width * mycosf(degreesToRadians(angle + 90.0))
            let middlePoint = CGPoint(x: mx, y: my)
            
            let ex = center.x + width * mysinf(degreesToRadians(angle + 270.0))
            let ey = center.y - width * mycosf(degreesToRadians(angle + 270.0))
            let endPoint = CGPoint(x: ex, y: ey)
            
            innerLinePath.move(to: startPoint)
            innerLinePath.addLine(to: middlePoint)
            innerLinePath.addLine(to: endPoint)
            innerLinePath.addLine(to: startPoint)
            
            taSLayer.path = innerLinePath.cgPath
        }
    }
    
    // MARK: -旋转中心点
    public var centerPoint : CGPoint = CGPoint(x:0,y:0) {
        willSet {
            self.centerPoint = newValue
        }
    }
    
    // MARK: - life cycle      /    生命周期
    public override init(frame: CGRect) {
        super.init(frame: frame)
        radius = GH_Scale(8)
        backgroundColor = .clear
        layer.addSublayer(taSLayer)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        taSLayer.frame = frame
        centerPoint = CGPoint(x: width/2, y: height/2)
    }
    
    public func mysinf(_ dTrAngle:Float) -> CGFloat {
        return CGFloat(sinf(dTrAngle))
    }
    
    public func mycosf(_ dTrAngle:Float) -> CGFloat {
        return CGFloat(cosf(dTrAngle))
    }
}



