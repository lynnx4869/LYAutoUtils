//
//  LYAutoLoading.swift
//  LYAutoUtils
//
//  Created by xianing on 2017/5/22.
//  Copyright © 2017年 lyning. All rights reserved.
//

import UIKit

public class LYAutoLoading {
    
    static public let shared: LYAutoLoading = LYAutoLoading()
    
    public var color: UIColor?
    public var centerImage: UIImage? = UIImage(named: "ly_loading", in: Bundle.normal_module, compatibleWith: nil)
    
    private var isShow: Bool = false
    private var autoLoadingView: LYAutoLoadingView?
    
    public func show() {
        if !isShow {
            autoLoadingView = LYAutoLoadingView(color: color, centerImage: centerImage)
            UIApplication.shared.keyWindow?.addSubview(autoLoadingView!)
            
            isShow = true
        }
    }
    
    public func hide() {
        if isShow {
            autoLoadingView?.removeFromSuperview()
            autoLoadingView = nil
            
            isShow = false
        }
    }
    
    public func isLoading() -> Bool {
        return isShow
    }
}

fileprivate class LYAutoLoadingView: UIView {
    
    private let logoImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
    
    init(color: UIColor?, centerImage: UIImage?) {
        let oFrame = CGRect(x: 0, y: 0, width: LyConsts.ScreenWidth, height: LyConsts.ScreenHeight)

        super.init(frame: oFrame)
        
        frame = oFrame
        
        let bgView = UIView(frame: oFrame)
        bgView.backgroundColor = .clear
        bgView.alpha = 0.5
        addSubview(bgView)
        
        if color == nil {
            self.logoImage.image = centerImage
        } else {
            self.logoImage.image = centerImage?.imageChange(color: color!)
        }
        
        createLoading()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createLoading() {
        let loadingBoard = UIView()
        loadingBoard.frame = CGRect(x: 0, y: 0, width: 140, height: 100)
        loadingBoard.center = center
        loadingBoard.backgroundColor = .white
        loadingBoard.layer.masksToBounds = true
        loadingBoard.layer.cornerRadius = 14.0
        loadingBoard.layer.borderColor = UIColor.lightGray.cgColor
        loadingBoard.layer.borderWidth = 0.25
        addSubview(loadingBoard)
        
        logoImage.center = CGPoint(x: 70, y: 50)
        loadingBoard.addSubview(logoImage)
    }
    
    override func didMoveToWindow() {
        startLogoAnim()
    }
    
    private func startLogoAnim() {
        let anim = CABasicAnimation(keyPath: "transform.rotation.z")
        anim.beginTime = CACurrentMediaTime()
        anim.toValue = 2.0 * Double.pi
        anim.duration = 3.0
        anim.repeatCount = HUGE
        anim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        logoImage.layer.add(anim, forKey: "rotationAnimation")
    }
    
}
