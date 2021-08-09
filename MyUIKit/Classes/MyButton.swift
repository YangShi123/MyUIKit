//
//  MyButton.swift
//  loveXC
//
//  Created by Rex on 2021/7/8.
//

import Foundation

enum ButtonImagePosition {
    case left, right, top, bottom
}

class MyButton: UIButton {
    
    /// 字体大小
    var fontSize: CGFloat? {
        willSet {
            titleLabel?.font = UIFont.init(name: (titleLabel?.font.familyName)!, size: newValue!)
        }
    }
    
    /// 图片位置 (在确定frame后再设置，否则无效)
    func imagePosition(_ position: ButtonImagePosition, spacing: CGFloat) {
        guard let label = titleLabel,let imageV = imageView else {
            return
        }
        let imageWidth = imageV.bounds.size.width
        let imageHeight = imageV.bounds.size.height
        let titleWidth = label.bounds.size.width
        let titleHeight = label.bounds.size.height
        let width = frame.size.width
        switch position {
        case .left:
            imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -spacing / 2, bottom: 0, right: spacing / 2)
            titleEdgeInsets = UIEdgeInsets.init(top: 0, left: spacing / 2, bottom: 0, right: -spacing / 2)
        case .right:
            imageEdgeInsets = UIEdgeInsets.init(top: 0, left: (titleWidth + spacing / 2), bottom: 0, right: -(titleWidth + spacing / 2))
            titleEdgeInsets = UIEdgeInsets.init(top: 0, left:  -(imageWidth + spacing / 2), bottom: 0, right: (imageWidth + spacing / 2))
        case .top:
            imageEdgeInsets = UIEdgeInsets.init(top: -titleHeight - spacing / 2, left: (width - imageWidth) / 2, bottom: 0, right: (width - imageWidth) / 2 - titleWidth)
            titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageWidth, bottom: -imageHeight - spacing / 2, right:  0)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets.init(top: 0, left: (width - imageWidth) / 2, bottom: -titleHeight - spacing / 2, right: (width - imageWidth) / 2 - titleWidth)
            titleEdgeInsets = UIEdgeInsets.init(top: -imageHeight - spacing / 2, left: -imageWidth, bottom: 0, right: 0)
        }
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultInit()
    }
    
    init() {
        super.init(frame: .zero)
        defaultInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defaultInit() {
        titleLabel?.font = UIFont(name: App.fontName, size: 14)
        setTitleColor(.white, for: .normal)
    }
}
