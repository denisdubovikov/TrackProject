//
//  MainPageButtonCreator.swift
//  TrackProject
//
//  Created by Денис Дубовиков on 03/11/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//

import Foundation
import UIKit

protocol mainPageButtonCreator {
    func createAccountButton(myFrame: CGRect) -> UIButton
//    func createCategoriesButton() -> UIButton
}

class MainPageButtonCreator: mainPageButtonCreator {
    
    func createAccountButton(myFrame: CGRect) -> UIButton {
        
        let accountButton = UIButton(frame: CGRect(
            x: myFrame.size.width - (myFrame.size.height / 1.5 + myFrame.size.height / 6),
            y:  myFrame.size.height / 2 - myFrame.size.height / 3,
            width: myFrame.size.height / 1.5,
            height: myFrame.size.height / 1.5))
        
        accountButton.backgroundColor = .white
        
        accountButton.setImage(UIImage(named: "Account"), for: .normal)
        accountButton.imageView?.contentMode = .scaleAspectFit
        
//        print(accountButton)
        
        return accountButton
    }
    
    @IBAction func buttonAccountPressed(_ sender: Any) {
        let accountVC = AccountViewController()
        let vc = ViewController()
            
        accountVC.categories = vc.categories
        accountVC.categoriesSelected = vc.categoriesSelected
        
        vc.navigationController?.pushViewController(accountVC, animated: true)
        
    }
    
    
}
