//
//  CardOfANewViewController.swift
//  TrackProject
//
//  Created by Денис Дубовиков on 13/10/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//

import UIKit

class CardOfANewViewController: UINavigationController {
    
    var titleOfTheNew: String?
    var nameOfImageOfTheNew: String?
    
    var titleLabel: UILabel!
    var imageOfTheNew: UIImage!
    var imageViewOfTheNew: UIImageView!
    var backButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let imageOfTheNewRect = CGRect(x: 20, y: view.frame.size.height / 5, width: view.frame.size.width - 40, height: 300)
        let titleLabelRect = CGRect(x: 0, y: imageOfTheNewRect.height / 2, width: imageOfTheNewRect.width, height: imageOfTheNewRect.height / 2)
        
        imageOfTheNew = UIImage(named: nameOfImageOfTheNew!)
        
        titleLabel = UILabel(frame: titleLabelRect)
        imageViewOfTheNew = UIImageView(frame: imageOfTheNewRect)
        backButton = UIButton(type: .custom)
        
        titleLabel.text = titleOfTheNew!
        titleLabel.font = UIFont(name: "Helvetica Neue", size: 36)
        titleLabel.textColor = UIColor.white
        
        imageViewOfTheNew.image = imageOfTheNew!
        imageViewOfTheNew.contentMode = UIView.ContentMode.scaleAspectFill
        imageViewOfTheNew.clipsToBounds = true
        imageViewOfTheNew.layer.cornerRadius = 20
        
//        self.navigationItem.backBarButtonItem?.title = "Back"
        
//        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: nameOfImageOfTheNew!)
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: nameOfImageOfTheNew!)
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "titlE", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
//        backButton.setTitle("Back", for: .normal)
//        backButton.setTitleColor(.black, for: .normal)
//        backButton.addTarget(self, action: Selector(("backButtonPressed")), for: .touchUpInside)
//        backButton.tintColor = .black
//        backButton.backgroundColor = .orange
        
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: imageViewOfTheNew.frame.size.width, height: imageViewOfTheNew.frame.size.height))
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.5, 1]
        
        imageViewOfTheNew.layer.addSublayer(gradient)
        
        imageViewOfTheNew.addSubview(titleLabel)
        
        view.addSubview(imageViewOfTheNew)
//        view.addSubview(backButton)
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
