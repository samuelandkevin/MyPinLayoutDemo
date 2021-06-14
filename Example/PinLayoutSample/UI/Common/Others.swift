//
//  Others.swift
//  PinLayoutSample
//
//  Created by 黄坤鹏 on 2021/6/5.
//  Copyright © 2021 layoutbox. All rights reserved.
//

import Foundation

extension String {
    /// 获取颜色值 #fff, fff, #f0f0f0, f0f0f0
    var color: UIColor {
        get {
            var cacheString = self
            if cacheString.hasPrefix("#") {
                let startIndex = cacheString.index(cacheString.startIndex, offsetBy: 1)
                cacheString = String(cacheString[startIndex...])
            }
            if cacheString.count == 3 {
                
                let redString = cacheString.prefix(1)
                let startIndex = cacheString.index(cacheString.startIndex, offsetBy: 1)
                let endIndex = cacheString.index(cacheString.startIndex, offsetBy: 2)
                let greenString = cacheString[startIndex..<endIndex]
                let blueString = cacheString.suffix(1)
                var red: UInt32 = 0
                var green: UInt32 = 0
                var blue: UInt32 = 0
                Scanner(string: "\(redString)\(redString)").scanHexInt32(&red)
                Scanner(string: "\(greenString)\(greenString)").scanHexInt32(&green)
                Scanner(string: "\(blueString)\(blueString)").scanHexInt32(&blue)
                
                return UIColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
                
            } else if cacheString.count == 6 {
                
                let redString = cacheString.prefix(2)
                let startIndex = cacheString.index(cacheString.startIndex, offsetBy: 2)
                let endIndex = cacheString.index(cacheString.startIndex, offsetBy: 4)
                let greenString = cacheString[startIndex..<endIndex]
                let blueString = cacheString.suffix(2)
                var red: UInt32 = 0
                var green: UInt32 = 0
                var blue: UInt32 = 0
                
                Scanner(string: "\(redString)").scanHexInt32(&red)
                Scanner(string: "\(greenString)").scanHexInt32(&green)
                Scanner(string: "\(blueString)").scanHexInt32(&blue)
                return UIColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
            }
            return UIColor.black
        }
    }
}

extension UILabel {
    
    /// 创建UILabel
    class func eh_creatLabel(text:String?,textAlignment:NSTextAlignment,textColor:UIColor,font:UIFont) -> UILabel {
        let v = UILabel()
        v.text = text
        v.textAlignment = textAlignment
        v.font = font
        v.textColor = textColor
        v.textAlignment = textAlignment
        return v
    }
}


extension UIButton {
    
    /// 创建UIButton
    class func eh_create(title:String?,backgroundColor:UIColor?,font:UIFont?,titleColor:UIColor?,imageName:String?,textAlignment:NSTextAlignment)->UIButton{
        let btn = UIButton()
        btn.setup(title: title, backgroundColor: backgroundColor, font: font, titleColor: titleColor, imageName: imageName,textAlignment:textAlignment)
        return btn
    }
    
    /// 设置UIButton属性
    func setup(title:String?,backgroundColor:UIColor?,font:UIFont?,titleColor:UIColor?,imageName:String?,textAlignment:NSTextAlignment){
        self.backgroundColor = backgroundColor
        titleLabel?.font = font
        setTitleColor(titleColor, for: .normal)
        setTitle(title, for: .normal)
        self.titleLabel?.textAlignment = textAlignment
        if let imageName = imageName {
            setImage(UIImage(named: imageName), for: .normal)
            setImage(UIImage(named: imageName), for: .highlighted)
        }
       
    }
    
    /// 设置圆角
    func setCornerRadius(_ radius:CGFloat){
        self.layer.cornerRadius  = radius
        self.layer.masksToBounds = true
    }
}


/// 扩大点击范围
extension UIButton{
    
    // 改进写法【推荐】
    private struct RuntimeKey {
        static let clickEdgeInsets = UnsafeRawPointer.init(bitPattern: "clickEdgeInsets".hashValue)
        /// ...其他Key声明
    }
    /// 需要扩充的点击边距
    public var eh_clickEdgeInsets: UIEdgeInsets? {
        set {
            objc_setAssociatedObject(self, UIButton.RuntimeKey.clickEdgeInsets!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get {
            return objc_getAssociatedObject(self, UIButton.RuntimeKey.clickEdgeInsets!) as? UIEdgeInsets ?? UIEdgeInsets.zero
        }
    }
        
    // 重写系统方法修改点击区域
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        super.point(inside: point, with: event)
        var bounds = self.bounds
        if (eh_clickEdgeInsets != nil) {
            let x: CGFloat = -(eh_clickEdgeInsets?.left ?? 0)
            let y: CGFloat = -(eh_clickEdgeInsets?.top ?? 0)
            let width: CGFloat = bounds.width + (eh_clickEdgeInsets?.left ?? 0) + (eh_clickEdgeInsets?.right ?? 0)
            let height: CGFloat = bounds.height + (eh_clickEdgeInsets?.top ?? 0) + (eh_clickEdgeInsets?.bottom ?? 0)
            bounds = CGRect(x: x, y: y, width: width, height: height) //负值是方法响应范围
        }
        return bounds.contains(point)
    }
    

}

/// 扩大点击范围
extension UILabel{
    
    // 改进写法【推荐】
    private struct RuntimeKey {
        static let clickEdgeInsets = UnsafeRawPointer.init(bitPattern: "clickEdgeInsets_label".hashValue)
        /// ...其他Key声明
    }
    /// 需要扩充的点击边距
    public var eh_clickEdgeInsets: UIEdgeInsets? {
        set {
            objc_setAssociatedObject(self, UILabel.RuntimeKey.clickEdgeInsets!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get {
            return objc_getAssociatedObject(self, UILabel.RuntimeKey.clickEdgeInsets!) as? UIEdgeInsets ?? UIEdgeInsets.zero
        }
    }
        
    // 重写系统方法修改点击区域
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        super.point(inside: point, with: event)
        var bounds = self.bounds
        if (eh_clickEdgeInsets != nil) {
            let x: CGFloat = -(eh_clickEdgeInsets?.left ?? 0)
            let y: CGFloat = -(eh_clickEdgeInsets?.top ?? 0)
            let width: CGFloat = bounds.width + (eh_clickEdgeInsets?.left ?? 0) + (eh_clickEdgeInsets?.right ?? 0)
            let height: CGFloat = bounds.height + (eh_clickEdgeInsets?.top ?? 0) + (eh_clickEdgeInsets?.bottom ?? 0)
            bounds = CGRect(x: x, y: y, width: width, height: height) //负值是方法响应范围
        }
        return bounds.contains(point)
    }
    

}


/// 扩大点击范围
extension UIImageView{
    
    // 改进写法【推荐】
    private struct RuntimeKey {
        static let clickEdgeInsets = UnsafeRawPointer.init(bitPattern: "clickEdgeInsets_imageView".hashValue)
        /// ...其他Key声明
    }
    /// 需要扩充的点击边距
    public var eh_clickEdgeInsets: UIEdgeInsets? {
        set {
            objc_setAssociatedObject(self, UIImageView.RuntimeKey.clickEdgeInsets!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get {
            return objc_getAssociatedObject(self, UIImageView.RuntimeKey.clickEdgeInsets!) as? UIEdgeInsets ?? UIEdgeInsets.zero
        }
    }
        
    // 重写系统方法修改点击区域
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        super.point(inside: point, with: event)
        var bounds = self.bounds
        if (eh_clickEdgeInsets != nil) {
            let x: CGFloat = -(eh_clickEdgeInsets?.left ?? 0)
            let y: CGFloat = -(eh_clickEdgeInsets?.top ?? 0)
            let width: CGFloat = bounds.width + (eh_clickEdgeInsets?.left ?? 0) + (eh_clickEdgeInsets?.right ?? 0)
            let height: CGFloat = bounds.height + (eh_clickEdgeInsets?.top ?? 0) + (eh_clickEdgeInsets?.bottom ?? 0)
            bounds = CGRect(x: x, y: y, width: width, height: height) //负值是方法响应范围
        }
        return bounds.contains(point)
    }
    

}




