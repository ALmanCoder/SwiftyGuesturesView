//
//  GH_UIViewExtension.swift
//  SwiftyRefresh
//
//  Created by guanghuiwu on 16/5/12.
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

// MARK: - UIView extension
public extension UIView {
    
    // MARK: - x
    public var x : CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame =  frame
        }
        get {
            return frame.origin.x
        }
    }
    
    // MARK: - y
    public var y : CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame =  frame
        }
        get {
            return frame.origin.y
        }
    }
        
    // MARK: - width
    public var width : CGFloat {
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame =  frame
        }
        get {
            return frame.width
        }
    }
    
    // MARK: - height
    public var height : CGFloat {
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame =  frame
        }
        get {
            return frame.height
        }
    }
    
    // MARK: - centerX
    public var centerX : CGFloat {
        set {
            var center = self.center
            center.x = newValue
            self.center =  center
        }
        get {
            return center.x
        }
    }
    
    // MARK: - centerY
    public var centerY : CGFloat {
        set {
            var center = self.center
            center.y = newValue
            self.center =  center
        }
        get {
            return center.y
        }
    }
    
    // MARK: - size
    public var size : CGSize {
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
        get {
            return frame.size
        }
    }
    
}
