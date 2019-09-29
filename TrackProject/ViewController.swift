//
//  ViewController.swift
//  TrackProject
//
//  Created by Денис Дубовиков on 29/09/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        print("Func: viewDidLoad")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Func: viewDidAppear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Func: viewWillAppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
           print("Func: viewDidDisappear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("Func: viewWillDissappear")
    }
    
    override func viewDidLayoutSubviews() {
           print("Func: viewDidLayoutSubviews")
    }
    
    override func viewWillLayoutSubviews() {
        print("Func: viewWillLayoutSubviews")
    }


}

