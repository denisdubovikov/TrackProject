//
//  StartScreen.swift
//  TrackProject
//
//  Created by Денис Дубовиков on 02/12/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//

import UIKit

class StartScreen: UIViewController {
    
    var backgroundImageView: UIImageView!
    
    var grassImageView: UIImageView!
    
    var cloud1ImageView: UIImageView!
    var cloud2ImageView: UIImageView!
    var cloud3ImageView: UIImageView!
    var cloud4ImageView: UIImageView!
    
    var tree1ImageView: UIImageView!
    var tree2ImageView: UIImageView!
    
    var sunImageView: UIImageView!
    
    var nightView: UIView!
    
    var helloLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupSun()
        setupBackgroundView()
        setupTrees()
        setupGrassImageView()
        setupClouds()
        setupHelloLabel()
        
        animateGrass()
        animateClouds()
        animateTrees()
        animateSun()
        animateHelloLabel()
        
//        timeOptions()
        // Do any additional setup after loading the view.
    }
    
    func setupBackgroundView() {
        backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        backgroundImageView.image = UIImage(named: "backgroundEmpty")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = 0.5
        
        view.addSubview(backgroundImageView)
//        view.addSubview(backgroundTopImageView)
    }
    
    func setupGrassImageView() {
        grassImageView = UIImageView(frame: CGRect(x: 0, y: view.frame.size.height, width: view.frame.size.width, height: view.frame.size.height / 4))
        
        grassImageView.image = UIImage(named: "grass")
        grassImageView.contentMode = .scaleToFill
        grassImageView.alpha = 0.8
        
        view.addSubview(grassImageView)
    }
    
    func setupClouds() {
        cloud1ImageView = UIImageView(frame: CGRect(x: view.frame.size.width / 10, y: 70, width: view.frame.size.width / 3, height: view.frame.size.width / 4))
        cloud2ImageView = UIImageView(frame: CGRect(x: view.frame.size.width / 2, y: 40, width: view.frame.size.width / 3, height: view.frame.size.width / 4))
        cloud3ImageView = UIImageView(frame: CGRect(x: view.frame.size.width / 2, y: -view.frame.size.width / 4, width: view.frame.size.width / 3, height: view.frame.size.width / 4))
        cloud4ImageView = UIImageView(frame: CGRect(x: view.frame.size.width, y: 20, width: view.frame.size.width / 3, height: view.frame.size.width / 4))
        
        cloud2ImageView.alpha = 0
        
        cloud1ImageView.image = UIImage(named: "cloud3")
        cloud2ImageView.image = UIImage(named: "cloud8")
        cloud3ImageView.image = UIImage(named: "cloud4")
        cloud4ImageView.image = UIImage(named: "cloud5")
        
        cloud1ImageView.contentMode = .scaleAspectFit
        cloud2ImageView.contentMode = .scaleAspectFit
        cloud3ImageView.contentMode = .scaleAspectFit
        cloud4ImageView.contentMode = .scaleAspectFit
        
        view.addSubview(cloud1ImageView)
        view.addSubview(cloud2ImageView)
        view.addSubview(cloud3ImageView)
        view.addSubview(cloud4ImageView)
    }
    
    func setupTrees() {
        
        let viewWidth = view.frame.size.width
        let viewHeight = view.frame.size.height
        
        tree1ImageView = UIImageView(frame: CGRect(x: viewWidth / 12, y: viewHeight, width: viewHeight / 8, height: viewHeight / 4))
        tree2ImageView = UIImageView(frame: CGRect(x: 0, y: viewHeight, width: viewHeight / 8, height: viewHeight / 4))
        
        tree1ImageView.image = UIImage(named: "tree")
        tree2ImageView.image = UIImage(named: "treePineOrange")
        
        tree1ImageView.contentMode = .scaleAspectFit
        tree2ImageView.contentMode = .scaleAspectFit
        
        tree1ImageView.alpha = 0
        tree2ImageView.alpha = 0
        
        view.addSubview(tree2ImageView)
        view.addSubview(tree1ImageView)
    }
    
    func setupSun() {
        sunImageView = UIImageView(frame: CGRect(x: view.frame.size.width, y: -view.frame.size.width, width: view.frame.size.width, height: view.frame.size.width))
        
        sunImageView.alpha = 0
        sunImageView.image = UIImage(named: "flash03")
        sunImageView.contentMode = .scaleAspectFit
        
        view.addSubview(sunImageView)
    }
    
    func setupHelloLabel() {
        helloLabel = UILabel(frame: CGRect(x: 30, y: view.frame.size.height / 4, width: view.frame.size.width - 60, height: 100))
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        if hour >= 11 && hour < 18 {
            helloLabel.text = "Good afternoon!"
        } else {
            if hour >= 6 && hour < 11 {
                helloLabel.text = "Good morning!"
            } else {
                if hour >= 18 && hour < 24 {
                    helloLabel.text = "Good evening!"
                } else {
                    helloLabel.text = "Good night!"
                }
            }
        }
        
        helloLabel.textAlignment = .center
        helloLabel.textColor = .black
        helloLabel.alpha = 0
        helloLabel.font = UIFont(name: "Helvetica Neue", size: 30)
        
        view.addSubview(helloLabel)
    }
    
    func animateGrass() {
        UIView.animate(withDuration: 1.5, animations: {
            self.grassImageView.center.y -= self.view.frame.size.height / 4
            self.grassImageView.alpha = 1
        })
    }
    
    func animateClouds() {
        UIView.animate(withDuration: 3, animations: {
            self.cloud1ImageView.center.x += self.view.frame.size.width / 6
        })
        
        UIView.animate(withDuration: 3, animations: {
            self.cloud2ImageView.alpha = 1
        })
        
        UIView.animate(withDuration: 4, animations: {
            self.cloud3ImageView.center.y += self.view.frame.size.width / 4 + 20
            self.cloud3ImageView.center.x = self.view.frame.size.width / 5.5
        }) { (finished) in
            guard finished else {
                return
            }
            
            //animation finished
            UIView.animate(withDuration: 1, animations: {
                       self.cloud3ImageView.center.y += 1
                   }) { (finished) in
                   guard finished else {
                       return
                   }
                    
                    let nextVC = ContainerController()
                    
                    nextVC.modalPresentationStyle = .fullScreen
                    
//                    self.showDetailViewController(nextVC, sender: self)
                    
                    self.present(nextVC, animated: false, completion: nil)
                }
        }
        
        UIView.animate(withDuration: 3, animations: {
            self.cloud4ImageView.center.x -= self.view.frame.size.width / 3 - 10
            self.cloud4ImageView.center.y -= 7
        })
    }
    
    func animateTrees() {
        UIView.animate(withDuration: 1.7, delay: 0.8, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            self.tree1ImageView.center.y = self.view.frame.size.height - self.view.frame.size.height / 2 / 1.1 + self.view.frame.size.height / 8
            self.tree1ImageView.alpha = 1
        }) { (finished) in
            guard finished else {
                return
            }
            
            //animation finished
        }
        
        UIView.animate(withDuration: 1.6, delay: 1.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            self.tree2ImageView.center.y = self.view.frame.size.height - self.view.frame.size.height / 2 / 1.1 + self.view.frame.size.height / 8
            self.tree2ImageView.alpha = 1
        }) { (finished) in
            guard finished else {
                return
            }
            
            //animation finished
        }
    }
    
    func animateSun() {
        UIView.animate(withDuration: 3, animations: {
            self.sunImageView.center.x -= self.view.frame.size.width / 2
            self.sunImageView.center.y += self.view.frame.size.width * 0.4
            self.sunImageView.alpha = 0.7
        })
    }
    
    func animateHelloLabel() {
        UIView.animate(withDuration: 3, animations: {
            self.helloLabel.alpha = 0.85
        })
    }
    
    func timeOptions() {
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        
        if hour >= 18 {
            nightView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
            
            nightView.backgroundColor = .black
            nightView.alpha = 0.3
            
            view.addSubview(nightView)
        }
    }
}
