//
//  MenuController.swift
//  TrackProject
//
//  Created by Денис Дубовиков on 30/11/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//

import UIKit

class MenuController: UIViewController {
    
    var myDelegate: ViewControllerDelegate!
    
    let ColorPalette = Palette.shared
    
    let accountVC = AccountViewController()
//    let viewController = ViewController()

    
    var menuTableView: UITableView!
    
    var menuTitles = ["Profile", "Saved", "Settings"]
    var menuImages = ["Account_v4", "Saved", "Settings gear"]
    var menuImagesDarkMode = ["Account_v4_darkMode", "Saved_darkMode", "Settings gear_darkMode"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMenuImages()

        configureTableView()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    func configureMenuImages() {
        if ColorPalette.isDarkModeOn {
            menuImages = menuImagesDarkMode
        }
    }
    
    
    
    
    func configureTableView() {
        menuTableView = UITableView()
        menuTableView.delegate = self
        menuTableView.dataSource = self

        menuTableView.register(MenuCell.self, forCellReuseIdentifier: "MenuCell")
        
//        menuTableView.backgroundColor = .white
        menuTableView.separatorStyle = .none
        menuTableView.rowHeight = 80
        
        view.addSubview(menuTableView)
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
        menuTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        menuTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        menuTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        menuTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }

}

extension MenuController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(menuImages.count, menuTitles.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuTableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
        cell.cellMenuOptionImage.image = UIImage(named: menuImages[indexPath.row])
        cell.cellMenuOptionLabel.text = menuTitles[indexPath.row]
        cell.cellMenuOptionLabel.textColor = ColorPalette.textColor
        if #available(iOS 13.0, *) {
            cell.cellMenuOptionLabel.backgroundColor = .systemBackground
            cell.backgroundColor = .systemBackground
        }
        
//        myDelegate.setupColors(withColors: <#T##Palette#>)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 || indexPath.row == 1 {
            myDelegate?.handleMenuToggle(forMenuOption: menuTitles[indexPath.row])
        } else {
            myDelegate?.handleMenuToggle(forMenuOption: nil)
        }
    }
    
    
}
