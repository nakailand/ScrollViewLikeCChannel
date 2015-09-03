//
//  ViewController.swift
//  ScrollViewLikeCChannel
//
//  Created by 中島　頌太 on 2015/08/27.
//  Copyright © 2015年 nakazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mainScrollView = MainScrollView(frame: self.view.bounds)
        self.view.addSubview(mainScrollView)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

