//
//  ViewController.swift
//  LYAutoUtils
//
//  Created by xianing on 2017/5/22.
//  Copyright © 2017年 lyning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let autoSwitchs = LYAutoSwitchs(frame: CGRect(x: 0, y: 64, width: LyConsts.ScreenWidth, height: 40), color: .blue)
        autoSwitchs.titles = ["123", "456", "789", "OVO", "-_-", "*_*", "^_^", "<(￣︶￣)>"]
        autoSwitchs.clickCallback = {
            (index) in
            print(autoSwitchs.titles[index])
        }
        view.addSubview(autoSwitchs)
                
        DispatchQueue.global().async {
            if let fileString = Bundle.main.path(forResource: "148274", ofType: "png") {
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: fileString) {
                    if let image = UIImage(contentsOfFile: fileString) {
                        if let newData = image.compress() {
                            let imagePath = NSHomeDirectory() + "/Documents/148274.png"
                            fileManager.createFile(atPath: imagePath,
                                                   contents: newData,
                                                   attributes: nil)
                            
                            debugPrint(NSHomeDirectory())
                        }
                    }
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showLoading(_ sender: UIButton) {
        let loading = LYAutoLoading.shared
        loading.color = UIColor.blue
        
        loading.show()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) { 
            loading.hide()
        }
    }

    @IBAction func showPop(_ sender: UIButton) {
        LYAutoPop.show(message: "这个是一个错误", type: .error, duration: 3.0)
    }
    
    @IBAction func alert(_ sender: UIButton) {
        LYAutoAlert.show(title: "提示",
                         subTitle: "这是一个提示",
                         check: true,
                         viewController: self,
                         confirm: nil,
                         cancel: nil,
                         sureAction:
        { (title) in
            print(title)
        }) { (title) in
            print(title)
        }
    }
    
    @IBAction func sheet(_ sender: UIButton) {
        LYAutoAlert.show(title: "",
                         btns: ["1", "2", "3"],
                         viewController: self) { (title) in
                            print(title)
        }
    }
    
    @IBAction func datepick(_ sender: UIButton) {
        let datepicker = LYAutoDatePicker.show(type: .YMDHmS,
                                               time: nil,
                                               maxTime: nil,
                                               minTime: nil,
                                               color: nil) { (times) in
            print(times.description(with: Locale.current))
        }
        
        present(datepicker, animated: true, completion: nil)
    }
    
}

