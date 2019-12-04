//
//  CardOfANewViewController.swift
//  TrackProject
//
//  Created by Денис Дубовиков on 13/10/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//

import UIKit
import CoreData

class CardOfANewViewController: UIViewController {
    
    var managedObjectContext: NSManagedObjectContext?
    
    let viewController = ViewController()
    
    let ColorPalette = Palette.shared
    
    var titleOfTheNew: String?
    var authorName: String?
    var imageOfTheNewURL: URL?
    var textNew: String?
    
    var titleLabel: UILabel!
    var authorLabel: UILabel!
    var imageOfTheNew: UIImage!
    var imageViewOfTheNew: UIImageView!
    var backButton: UIButton!
    var textView: UITextView!
    
    var imageOfTheNewRect: CGRect!
    
    var flagShowSaveButton: Bool!
    
    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
             view.backgroundColor = .white
        }
        
        setupSaveButton()
        setupImageViewOfTheNew()
        setupBackButton()
        setupTextView()
        setupAuthorLabel()
    }
    
    
    
    
//MARK: Back Button
    func setupBackButton() {
            backButton = UIButton(frame: CGRect(x: 0, y: 90, width: 50, height: 50))
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
//MARK: Title Label
    func setupTitleLabel() {
        let titleLabelRect = CGRect(x: 10, y: imageOfTheNewRect.height * 2 / 3, width: imageOfTheNewRect.width - 20, height: imageOfTheNewRect.height / 3)
                
        titleLabel = UILabel(frame: titleLabelRect)
        titleLabel.numberOfLines = 2
        
        titleLabel.text = titleOfTheNew!
        titleLabel.font = UIFont(name: "Helvetica Neue", size: 34)
        titleLabel.textColor = UIColor.white
        
        imageViewOfTheNew.addSubview(titleLabel)
    }
    
    
    
    
//MARK: Activity Indicator
    func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: imageOfTheNewRect.size.width / 2 - 20, y: imageOfTheNewRect.size.height / 2 - 20, width: 40, height: 40))
        
        activityIndicator.layer.zPosition = 10

        activityIndicator.style = .gray
        activityIndicator.isHidden = true
        
        imageViewOfTheNew.addSubview(activityIndicator)
    }
    
    
    

//MARK: Image Of The New
    func setupImageViewOfTheNew() {
        
        let viewWidth = view.frame.size.width
        
        imageOfTheNewRect = CGRect(x: (viewWidth - viewWidth / 1.05) / 2, y: (viewWidth - viewWidth / 1.05) / 2 + (navigationController?.navigationBar.frame.maxY ?? 0), width: viewWidth / 1.05, height: viewWidth / 1.3)
        imageViewOfTheNew = UIImageView(frame: imageOfTheNewRect)
        
        imageViewOfTheNew.contentMode = UIView.ContentMode.scaleAspectFill
        imageViewOfTheNew.clipsToBounds = true
        imageViewOfTheNew.layer.cornerRadius = 20
        imageViewOfTheNew.backgroundColor = UIColor(displayP3Red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        
        let titleLabelRect = CGRect(x: 10, y: imageOfTheNewRect.height * 2 / 3, width: imageOfTheNewRect.width - 20, height: imageOfTheNewRect.height / 3)
                
        titleLabel = UILabel(frame: titleLabelRect)
        titleLabel.numberOfLines = 2
        
        titleLabel.text = titleOfTheNew!
        titleLabel.font = UIFont(name: "Helvetica Neue", size: 34)
        titleLabel.textColor = UIColor.white
        titleLabel.layer.zPosition = 100
        
        setupActivityIndicator()
        print(activityIndicator.frame)
        
        var flagImageReceived: Bool = false
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        
        DispatchQueue.global().async {
            
            if let data = try? Data(contentsOf: self.imageOfTheNewURL!) {
                if let image = UIImage(data: data) {
                    self.imageViewOfTheNew.image = image
                    
                    flagImageReceived = true
                    
                    let gradient = CAGradientLayer()
                    gradient.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.imageViewOfTheNew.frame.size.width, height: self.imageViewOfTheNew.frame.size.height))
                    gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
                    gradient.locations = [0.5, 1]

                    self.imageViewOfTheNew.layer.addSublayer(gradient)
                }
            } else {
                //default image
                print("invalid url")
            }
            
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
        
//        if flagImageReceived {
//            //gradient
//            let gradient = CAGradientLayer()
//            gradient.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: imageViewOfTheNew.frame.size.width, height: imageViewOfTheNew.frame.size.height))
//            gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
//            gradient.locations = [0.5, 1]
//            
//            imageViewOfTheNew.layer.addSublayer(gradient)
//        }
        
        imageViewOfTheNew.addSubview(titleLabel)
        view.addSubview(imageViewOfTheNew)
    }
    
    
    
    
    func setupAuthorLabel() {
        
        let viewWidth = view.frame.size.width
        
        authorLabel = UILabel(frame: CGRect(x: (viewWidth - viewWidth / 1.05) / 2, y: imageViewOfTheNew.frame.maxY + 10, width: viewWidth / 1.05, height: 50))
        
        authorLabel.backgroundColor = view.backgroundColor
        authorLabel.text = authorName
        authorLabel.textColor = ColorPalette.textColor
        authorLabel.textAlignment = .left
        authorLabel.font = UIFont(name: "Helvetica Neue", size: 25)
        
        view.addSubview(authorLabel)
    }
    
    
    
    
//MARK: Text View
    func setupTextView() {
        let viewWidth = view.frame.size.width
        
        let textViewRect = CGRect(x: (viewWidth - viewWidth / 1.05) / 2, y: self.imageOfTheNewRect.maxY + 70, width: view.frame.size.width - 40, height: view.frame.size.height - self.imageOfTheNewRect.maxX - 20)
        
        textView = UITextView(frame: textViewRect)
        textView.text = textNew
        textView.font = UIFont(name: "Helvetica Neue", size: 18)
        textView.textColor = viewController.ColorPalette.textColor
        textView.isEditable = false
        
        view.addSubview(textView)
    }
    
    
    
    
//MARK: Save new button
    func setupSaveButton() {
        if flagShowSaveButton {
            navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))]
        }
    }
    
    @objc func saveButtonPressed() {
        saveNew()
    }
    
    // MARK: Save the new to CoreData
        func saveNew() {
            guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
    //        print(NSEntityDescription.entity(forEntityName: "New", in: delegate.managedObjectContext))
    //        print(NSEntityDescription.entity(forEntityName: "ListNews", in: delegate.managedObjectContext))

            if let newEntity = NSEntityDescription.entity(forEntityName: "New", in: delegate.managedObjectContext), let listNewsEntity = NSEntityDescription.entity(forEntityName: "ListNews", in: delegate.managedObjectContext) {
                let new = New(entity: newEntity, insertInto: delegate.managedObjectContext)
                new.title = titleOfTheNew ?? "no title"
                new.urlToImage = imageOfTheNewURL ?? URL(fileURLWithPath: "nil")
                new.author = authorName ?? "no author"
                new.content = textNew ?? "no content"
                
                delegate.saveContext()
            }
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
