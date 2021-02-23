//
//  LYAutoPop.swift
//  LYAutoUtils
//
//  Created by xianing on 2017/5/22.
//  Copyright © 2017年 lyning. All rights reserved.
//

import UIKit

public enum LYAutoPopType: Int {
    case success
    case warming
    case error
}

open class LYAutoPop {
    
    public static func show(message: String, type: LYAutoPopType, duration: TimeInterval) {
        let y = UIApplication.shared.statusBarFrame.height + 44
        let autoPopView = LYAutoPopView(frame: CGRect(x: 0, y: y, width: LyConsts.ScreenWidth, height: 30), message: message, type: type)
        UIApplication.shared.keyWindow?.addSubview(autoPopView)
        
        let anim = CABasicAnimation(keyPath: "opacity")
        anim.beginTime = CACurrentMediaTime()
        anim.fromValue = 0.0
        anim.toValue = 1.0
        anim.duration = 1.0
        anim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        autoPopView.layer.add(anim, forKey: "fade")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+duration) { 
            [weak autoPopView] in
            if autoPopView != nil {
                autoPopView?.layer.removeAllAnimations()
                autoPopView?.removeFromSuperview()
            }
        }
    }
    
}

fileprivate class LYAutoPopView: UIView {
    
    private let leftIcon = UIImageView(frame: CGRect(x: 10, y: 8, width: 14, height: 14))
    private let messageLabel = UILabel(frame: CGRect(x: 34, y: 0, width: LyConsts.ScreenWidth-44, height: 30))
    
    init(frame: CGRect, message: String, type: LYAutoPopType) {
        super.init(frame: frame)
        
        addSubview(leftIcon)
        
        messageLabel.font = UIFont.systemFont(ofSize: 12)
        messageLabel.textColor = .white
        addSubview(messageLabel)
        
        setType(message: message, type: type)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeSelf))
        addGestureRecognizer(tap)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setType(message: String, type: LYAutoPopType) {
        messageLabel.text = message
        
        if type == .success {
            backgroundColor = 0x16a085.color()
            leftIcon.image = UIImage(named: "ly_message_ok", in: Bundle.normal_module, compatibleWith: nil)
        } else {
            backgroundColor = 0xd9544f.color()
            leftIcon.image = UIImage(named: "ly_message_warning", in: Bundle.normal_module, compatibleWith: nil)
        }
    }
    
    @objc private func removeSelf() {
        removeFromSuperview()
    }
    
}
