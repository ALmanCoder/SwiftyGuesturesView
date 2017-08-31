//
//  GHGPasswordView.swift
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

// MARK: - GHGPViewDelegate
public protocol GHGPViewDelegate {
    func didEndSwipeWithPassword(gpView:GHGPasswordView,password:String) -> NodeState
}

// MARK: - 手势密码
public class GHGPasswordView: UIView {
    // MARK: - 代理
    public var gpviewDelegate : GHGPViewDelegate!
    
    // MARK: - 存点数组
    public var nodeArray = [GHGuesturesNodeView]()
    // MARK: - 选中点数组
    public var nodeSelectedArray = [GHGuesturesNodeView]()
    
    // MARK: - 连点线
    // MARK: -pointLineSLayer
    public lazy var pointLineSLayer : CAShapeLayer = {
        let pointLineSLayer = CAShapeLayer()
        pointLineSLayer.lineWidth = GH_Scale(2)
        pointLineSLayer.strokeColor = RGB(252, 90, 75).cgColor
        pointLineSLayer.fillColor = UIColor.clear.cgColor
        return pointLineSLayer
    }()
    // MARK: -pointLinePath
    public var pointLinePath : UIBezierPath!
    // MARK: -pointLinePath上的点
    public var pointArray = [NSValue]()
    
    // MARK: - nodeState
    public var nodeState : NodeState = .normal {
        willSet {
            self.nodeState = newValue
        }
        didSet {
            switch nodeState {
                case .normal:
                    clearNodes()
                case .warning:
                    makeNodesToWarning()
                    perform(#selector(clearNodesIfNeeded), with: nil, afterDelay: 1)
                case .selected:
                    break
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        nodeArray = [GHGuesturesNodeView]()
        nodeSelectedArray = [GHGuesturesNodeView]()
        pointArray = [NSValue]()
        
        for i in 0...8 {
            let gnodeView = GHGuesturesNodeView()
            nodeArray.append(gnodeView)
            gnodeView.tag = i
            addSubview(gnodeView)
        }
        
        let pgRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
        addGestureRecognizer(pgRecognizer)
        nodeState = .normal
        layer.addSublayer(pointLineSLayer)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        pointLineSLayer.frame = bounds
        let maskSLayer = CAShapeLayer()
        maskSLayer.frame = bounds
        let maskPath = UIBezierPath(rect: bounds)
        // MARK: - kCAFillRuleEvenOdd 要结合nodeView的frame使用
        maskSLayer.fillRule = kCAFillRuleEvenOdd
        
        for (index,gnodeView) in nodeArray.enumerated() {
            let min = width < height ? width : height
            let w = min / 5
            let h = min / 5
            let row = index % 3
            let col = index / 3
            gnodeView.frame = CGRect(x: CGFloat(row * 2) * w,
                                     y: CGFloat(col * 2) * h,
                                     width : w,
                                     height: h
            )
            maskPath.append(UIBezierPath(ovalIn: gnodeView.frame))
        }
        maskSLayer.path = maskPath.cgPath
        pointLineSLayer.mask = maskSLayer
    }
    
    // MARK: - 绘制
    public func pan(_ pgRecognizer:UIPanGestureRecognizer) {
        let pgrState = pgRecognizer.state
        if pgrState == .began { nodeState = .normal }
        
        let touchPoint = pgRecognizer.location(in: self)
        let index = indexForNodeAtPoint(touchPoint)
        
        if index >= 0 {
            let gnodeView = nodeArray[index]
            if !addSelectedNode(gnodeView) {
                moveLineWithFingerPosition(touchPoint)
            }
        } else {
            moveLineWithFingerPosition(touchPoint)
        }
        
        if pgrState == .ended {
            removeLastFingerPosition()
            var password = ""
            for (_,snodeView) in nodeSelectedArray.enumerated() {
                password.append("\(snodeView.tag)")
            }
            nodeState = gpviewDelegate.didEndSwipeWithPassword(gpView: self, password: password)
        }
    }
    
    // MARK: - 点所在索引
    public func indexForNodeAtPoint(_ point:CGPoint) -> NSInteger {
        for (index,gnodeView) in nodeArray.enumerated() {
            let pointInNodeView = gnodeView.convert(point, from:self)
            if gnodeView.point(inside: pointInNodeView, with: nil) {
                return index
            }
        }
        return -1
    }
    
    // MARK: - 清楚节点
    public func clearNodes() {
        for (_,gnodeView) in nodeArray.enumerated() {
            gnodeView.nodeState = .normal
        }
        nodeSelectedArray.removeAll()
        pointArray.removeAll()
        pointLinePath = UIBezierPath()
        pointLineSLayer.strokeColor = RGB(82, 146, 252).cgColor
        pointLineSLayer.path = pointLinePath.cgPath
    }
    
    public func clearNodesIfNeeded() {
        if nodeState != .normal {
            clearNodes()
        }
    }
    
    // MARK: - 设置节点为警告
    public func makeNodesToWarning() {
        for (_, gnodeView) in nodeArray.enumerated() {
            gnodeView.nodeState = .warning
        }
        pointLineSLayer.strokeColor = RGB(252, 90, 75).cgColor
    }
    
    // MARK: - 添加节点并判断是否已添加
    public func addSelectedNode(_ gnodeView:GHGuesturesNodeView) -> Bool {
        if !nodeSelectedArray.contains(gnodeView) {
            gnodeView.nodeState = .selected
            nodeSelectedArray.append(gnodeView)
            addLineToNode(gnodeView)
            return true
        } else {
            return false
        }
    }
    
    // MARK: - 节点之间连线
    public func addLineToNode(_ gnodeView:GHGuesturesNodeView) {
        if nodeSelectedArray.count == 1 {
            let startPoint = gnodeView.center
            pointLinePath.move(to: startPoint)
            pointArray.append(NSValue(cgPoint: startPoint))
            pointLineSLayer.path = pointLinePath.cgPath
        } else {
            pointArray.removeLast()
            pointArray.append(NSValue(cgPoint: gnodeView.center))
            drewLineNodeToNode()
            let preNodeView = nodeSelectedArray[nodeSelectedArray.count-2]
            preNodeView.anchorWithStartPointXY(gnodeView.center,
                                               x: Float(gnodeView.center.x - preNodeView.center.x),
                                               y: Float(gnodeView.center.y - preNodeView.center.y)
            )
        }

    }
    
    // MARK: - 节点到手指之前连线
    public func moveLineWithFingerPosition(_ point:CGPoint) {
        if pointArray.count > 0 {
            if pointArray.count > nodeSelectedArray.count {
                pointArray.removeLast()
            }
            pointArray.append(NSValue(cgPoint: point))
            drewLineNodeToNode()
        }
    }
    
    // MARK: - 移除最后一个节点
    public func removeLastFingerPosition() {
        if pointArray.count > 0 {
            if pointArray.count > nodeSelectedArray.count {
                pointArray.removeLast()
            }
            drewLineNodeToNode()
        }
    }
    
    // MARK: - 重新添加节点
    public func drewLineNodeToNode() {
        pointLinePath.removeAllPoints()
        let startPoint = pointArray[0].cgPointValue
        pointLinePath.move(to: startPoint)
        for (index,value) in pointArray.enumerated() {
            if index > 0 {
                let middlePoint = value.cgPointValue
                pointLinePath.addLine(to: middlePoint)
            }
        }
        pointLineSLayer.path = pointLinePath.cgPath
    }
}
