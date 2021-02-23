//
//  LYAutoUtils.swift
//  LYAutoUtils
//
//  Created by xianing on 2017/9/27.
//  Copyright © 2017年 lyning. All rights reserved.
//

import Foundation

open class LYAutoUtils {}

extension Bundle {
    
    static var normal_module: Bundle? = {
        let bundleName = "LYAutoUtils"

        var candidates = [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,

            // Bundle should be present here when the package is linked into a framework.
            Bundle(for: LYAutoUtils.self).resourceURL,

            // For command-line tools.
            Bundle.main.bundleURL,
        ]
        
        #if SWIFT_PACKAGE
        // For SWIFT_PACKAGE.
        candidates.append(Bundle.module.bundleURL)
        #endif

        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".xcassets")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        
        return nil
    }()
}
