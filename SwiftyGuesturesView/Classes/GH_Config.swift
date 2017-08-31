//
//  GH_Config.swift
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

// MARK: - ColorCofig
// MARK: -- bgColor
public func bgColor() -> UIColor {
    return RGB(240,240,240)
}

// MARK: -- TestColor
public func TestColor () -> UIColor {
    return RGB(CGFloat(arc4random()%255), CGFloat(arc4random()%255), CGFloat(arc4random()%255))
}

// MARK: -- RGBA
public func RGBA (_ r : CGFloat, _ g : CGFloat, _ b : CGFloat, _ a : CGFloat) -> UIColor {
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: a)
}

// MARK: -- RGB
public func RGB(_ r : CGFloat, _ g:CGFloat, _ b:CGFloat) -> UIColor {
    return RGBA(r, g, b, 1.0)
}

// MARK: -- 十六进制转RGBA
public func HexToColor(hex : String) -> UIColor {
    var cString : String = hex.trimmingCharacters(in: NSCharacterSet.whitespaces).uppercased()
    if (cString.hasPrefix("#")) {  cString = (cString as NSString).substring(from: 1) }
    let rString = (cString as NSString).substring(to: 2)
    let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
    let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
    Scanner(string: rString).scanHexInt32(&r)
    Scanner(string: gString).scanHexInt32(&g)
    Scanner(string: bString).scanHexInt32(&b)
    return RGB(CGFloat(r), CGFloat(g), CGFloat(b))
}


// MARK: - SystemCofig
// MARK: -- GHLog
public func GHLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\(fileName) -> \(funcName) -> (line : \(lineNum)) -> \(message)")
    #endif
}

// MARK: -- 设备型号
public let IS_IPHONE       = (UI_USER_INTERFACE_IDIOM() == .phone)
public let HG_IPHONE_4     = (IS_IPHONE && GH_S_HEIGHT < 568)
public let HG_IPHONE_5     = (IS_IPHONE && GH_S_HEIGHT == 568)
public let HG_IPHONE_6     = (IS_IPHONE && GH_S_HEIGHT == 667)
public let HG_IPHONE_6p    = (IS_IPHONE && GH_S_HEIGHT == 736)

// MARK: -- 获取屏幕宽高
public let GH_S_WIDTH      = UIScreen.main.bounds.width
public let GH_S_HEIGHT     = UIScreen.main.bounds.height
public let GH_S_N_HEIGHT   = GH_S_HEIGHT - GH_NavStatusBarHeight

// MARK: -- 导航和状态栏高度
public let GH_NavStatusBarHeight = 44.0 + navBarHeight()

// MARK: -- navHeight
public func navBarHeight() -> CGFloat {
    return UIApplication.shared.statusBarFrame.height
}

// MARK: -- 屏宽比系数，依375为基准
public func GH_Scale(_ s:CGFloat) -> CGFloat{
    return (s) * UIScreen.main.bounds.width / 375.0
}


// MARK: -- 设置字体
public func GH_FONT(_ size : CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}

// MARK: -- NSNotification.Name
public func N_Name(_ rawValue:String) -> NSNotification.Name {
    return NSNotification.Name(rawValue: rawValue)
}

// MARK: -- 角度转弧度
public func degreesToRadians(_ x : Float) -> Float {
    return (x * Float(Double.pi) / 180.0)
}
// MARK: -- 弧度转角度
public func radiansToDegrees(_ x : Float) -> Float {
    return (x * 180.0 / Float(Double.pi))
}


