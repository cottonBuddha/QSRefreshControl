//
//  ViewController.swift
//  Saint Seiya
//
//  Created by 江齐松 on 16/5/9.
//  Copyright © 2016年 江齐松. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    let v = Tangram.init(frame: CGRect(x: 100, y: 200, width: 100, height: 100))
    override func viewDidLoad() {
        super.viewDidLoad()
        v.backgroundColor = UIColor.gray
        view.addSubview(v)
        view.bringSubview(toFront: slider)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func slideIt(_ sender: AnyObject) {
        
        v.progress = CGFloat(slider.value)

    }
    

}

