//
//  ViewController.swift
//  TrackProject
//
//  Created by Денис Дубовиков on 29/09/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var UIViewAtTheTop: UIView!
    @IBOutlet weak var buttonAtTheTop: UIButton!
    
//    var UIViewAtTheTop: UIView!
//    var buttonAtTheTop: UIButton!
    
    
    var images = ["img1", "img2", "img3", "img4"]
    var titles = ["Rent your bus!", "The secret of Michigan", "Try yourself now", "Hot discussions"]
    
    var categories = ["Main", "Travel", "Education", "Other"]
        
    var UIViewWithPickerView: UIView!
    var pickerViewOnUIView: UIPickerView!
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        createUIViewWithPickerView()
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = UIViewAtTheTop.bounds
        
//        blurView.frame = UINavigationBar.appearance().bounds
        
//        UIViewAtTheTop = UIView(frame: UINavigationBar.appearance().bounds)
                
        UIViewAtTheTop.addSubview(blurView)
        UIViewAtTheTop.alpha = 1
        UIViewAtTheTop.insertSubview(blurView, at: 0)
        
//        buttonAtTheTop = UIButton(frame: CGRect(origin: CGPoint(x: UIViewAtTheTop.frame.size.width / 2, y: UIViewAtTheTop.frame.size.height / 2), size: CGSize(width: UIViewAtTheTop.frame.size.width / 2, height: UIViewAtTheTop.frame.size.height)))
        
//        UIViewAtTheTop.addSubview(buttonAtTheTop)
        
        setButtonAtTheTop(index: 0)
        
        myTableView.contentInset = UIEdgeInsets(top: UIViewAtTheTop.frame.size.height / 2, left: 0, bottom: 0, right: 0)
        
//        UINavigationBar.appearance().addSubview(UIViewAtTheTop)
        
        
//        print(buttonAtTheTop.titleLabel?.frame.size.width)
        
        
    }
    
    func setButtonAtTheTop(index: Int) {
        
        buttonAtTheTop.isHidden = false
        
//        buttonAtTheTop.isHighlighted = false
        
        buttonAtTheTop.setTitle(categories[index], for: .normal)
        
        buttonAtTheTop.setTitleColor(UIColor.black, for: .normal)
        buttonAtTheTop.titleLabel?.frame.size.width = buttonAtTheTop.frame.size.width
        buttonAtTheTop.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 20)
    }

    // MARK: - Table view data source


    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return images.count
    }


    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TBVCCell") as! TableViewCell
        
        let cellImg: UIImage = UIImage(named: images[indexPath.row])!
        
        
        cell.TableViewCellImageView.contentMode = UIView.ContentMode.scaleAspectFill
        
        cell.TableViewCellImageView.image = cellImg
        cell.TableViewCellImageView.clipsToBounds = true
        cell.TableViewCellImageView.layer.cornerRadius = 20
        cell.TableViewCellImageView.self.frame.size.height = CGFloat(300)
        cell.TableViewCellImageView.self.frame.size.width = CGFloat(cell.frame.size.width - 40)
        
        print(cell.TableViewCellImageView.frame)
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: cell.TableViewCellImageView.frame.size.width, height: cell.TableViewCellImageView.frame.size.height))
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.5, 1]
        
        cell.TableViewCellImageView.layer.addSublayer(gradient)
        
        cell.TableViewCellTitle.textColor = UIColor.white
        cell.TableViewCellTitle.text = titles[indexPath.row]
        cell.TableViewCellTitle.font = UIFont(name: "Helvetica Neue", size: 36)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextVC = CardOfANewViewController(nibName: "name", bundle: nil)
        
        nextVC.titleOfTheNew = titles[indexPath.row]
        nextVC.nameOfImageOfTheNew = images[indexPath.row]
        
        navigationController?.pushViewController(nextVC, animated: true)
        
        self.present(nextVC, animated: true, completion: nil)
        
//        let myStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
//        buttonAtTheTop.titleLabel!.frame.size.width = buttonAtTheTop.frame.size.width
//        buttonAtTheTop.titleLabel!.text = categories[row]
//        print(categories[row])
        
        setButtonAtTheTop(index: row)
        
//        print(buttonAtTheTop.titleLabel?.text)
    }

    func createUIViewWithPickerView() {
        
        let rectForView = CGRect(x: 0, y: view.frame.size.height - 300, width: view.frame.size.width, height: view.frame.size.height / 2)
        let rectForPicker = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 300)
        
        //height: view.frame.size.height / 2 : чтобы на квадратных экранах не было cornerRadius снизу, а то углы не заблюрятся
        //а выдвигать снизу будем на 300 на любом экране
        
        UIViewWithPickerView = UIView(frame: rectForView)
        UIViewWithPickerView.isHidden = true
        UIViewWithPickerView.clipsToBounds = true
        UIViewWithPickerView.layer.cornerRadius = 20
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = UIViewWithPickerView.bounds
        
        UIViewWithPickerView.addSubview(blurView)
        UIViewWithPickerView.alpha = 1
        UIViewWithPickerView.insertSubview(blurView, at: 0)
        
        pickerViewOnUIView = UIPickerView(frame: rectForPicker)
        
        pickerViewOnUIView.dataSource = self
        pickerViewOnUIView.delegate = self
        
        pickerViewOnUIView.isHidden = false
        pickerViewOnUIView.alpha = 1
        
        UIViewWithPickerView.addSubview(pickerViewOnUIView)
        
        view.addSubview(UIViewWithPickerView)
        
        print(pickerViewOnUIView.numberOfRows(inComponent: 0))
    }
    
    
    
    
    @IBAction func ButtonAtTheTopPressed(_ sender: Any) {
        
        UIViewWithPickerView.isHidden = !UIViewWithPickerView.isHidden
        
    }
    
    
    
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("Func: viewDidAppear. Notifies the view controller that its view was added to a view hierarchy.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Func: viewWillAppear. otifies the view controller that its view is about to be added to a view hierarchy.")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("Func: viewDidDisappear. Notifies the view controller that its view was removed from a view hierarchy.")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("Func: viewWillDissappear. Notifies the view controller that its view is about to be removed from a view hierarchy.")
    }
    
    override func viewDidLayoutSubviews() {
        print("Func: viewDidLayoutSubviews. Called to notify the view controller that its view has just laid out its subviews.")
    }
    
    override func viewWillLayoutSubviews() {
        print("Func: viewWillLayoutSubviews. Called to notify the view controller that its view is about to layout its subviews.")
    }


}

