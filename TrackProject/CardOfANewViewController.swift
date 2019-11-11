//
//  CardOfANewViewController.swift
//  TrackProject
//
//  Created by Денис Дубовиков on 13/10/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//

import UIKit

class CardOfANewViewController: UIViewController {
    
    var titleOfTheNew: String?
    var imageOfTheNewURL: URL?
    var textNew: String?
    
    var titleLabel: UILabel!
    var imageOfTheNew: UIImage!
    var imageViewOfTheNew: UIImageView!
    var backButton: UIButton!
    var textView: UITextView!
    
    var imageOfTheNewRect: CGRect!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        imageOfTheNewRect = CGRect(x: 20, y: (self.navigationController?.navigationBar.frame.maxY)! + 20, width: view.frame.size.width - 40, height: 300)
        let titleLabelRect = CGRect(x: 10, y: imageOfTheNewRect.height / 2, width: imageOfTheNewRect.width, height: imageOfTheNewRect.height / 2)
                
        titleLabel = UILabel(frame: titleLabelRect)
        imageViewOfTheNew = UIImageView(frame: imageOfTheNewRect)
        backButton = UIButton(frame: CGRect(x: 0, y: 90, width: 50, height: 50))
        
        titleLabel.text = titleOfTheNew!
        titleLabel.font = UIFont(name: "Helvetica Neue", size: 36)
        titleLabel.textColor = UIColor.white
        
                    
        if imageOfTheNewURL != nil {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: self.imageOfTheNewURL!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.imageViewOfTheNew.image = image
                        }
                    }
                }
            }
        }
        
//        imageViewOfTheNew.image = imageOfTheNew!
        imageViewOfTheNew.contentMode = UIView.ContentMode.scaleAspectFill
        imageViewOfTheNew.clipsToBounds = true
        imageViewOfTheNew.layer.cornerRadius = 20
        
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: imageViewOfTheNew.frame.size.width, height: imageViewOfTheNew.frame.size.height))
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.5, 1]
        
        imageViewOfTheNew.layer.addSublayer(gradient)
        
        imageViewOfTheNew.addSubview(titleLabel)
        
        setBackButton()
        setTextView()
        
        view.addSubview(imageViewOfTheNew)
    }
    
    func setBackButton() {
                
//        self.navigationController?.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .undo, target: self, action: #selector(backButtonPressed(_:)))
        
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "BACK", style: .plain, target: self, action: #selector(backButtonPressed(_:)))
        
//        print(Selector("backButtonPressed"))
    }
    
    @objc func backButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setTextView() {
        let textViewRect = CGRect(x: 20, y: self.imageOfTheNewRect.maxX + 20, width: view.frame.size.width - 40, height: view.frame.size.height - self.imageOfTheNewRect.maxX - 20)
        
        textView = UITextView(frame: textViewRect)
        textView.text = textNew
        textView.font = UIFont(name: "Helvetica Neue", size: 18)
        textView.isEditable = false
        
        view.addSubview(textView)

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
