//
//  AccountViewController.swift
//  TrackProject
//
//  Created by Денис Дубовиков on 16/10/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var categories: [String] = []
    var categoriesSelected: [Bool] = []
    
    var countCategoriesSelected: Int!
    
    var photoImageView: UIImageView!
    var userNameTextField: UITextField!
    
    var choseProfilePictureButton: UIButton!
    
    var saveGCDButton: UIButton!
    var saveNSOperationButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    var selectionView: UIView!
    var selectionTbView: UITableView!
    var selectionViewHideButton: UIButton!
    
    var showCategoriesButton: UIButton!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let selectionViewFrame = CGRect(x: 0, y: view.frame.size.height / 2, width: view.frame.size.width, height: view.frame.size.height)
        let selectionTbViewFrame = CGRect(x: 0, y: 30, width: view.frame.size.width, height: view.frame.size.height / 2 - 30)
        let selectionViewHideButtonFrame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30)
        
        selectionView = UIView(frame: selectionViewFrame)
        selectionTbView = UITableView(frame: selectionTbViewFrame)
        selectionViewHideButton = UIButton(frame: selectionViewHideButtonFrame)
        
        setSelectionView()
        
//        selectionView.isHidden = true
        
        imagePicker.delegate = self
        
        let usrDefaults = UserDefaults.standard
        
        view.backgroundColor = .white

        let accountPhoto: UIImage = UIImage(named: "50-cent")!
        
        photoImageView = UIImageView(frame: CGRect(x: 20, y: 100, width: view.frame.size.width - 40, height: 300))
        photoImageView.contentMode = UIView.ContentMode.scaleAspectFill
        photoImageView.backgroundColor = .gray
//        photoImageView.image = accountPhoto
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 20
        photoImageView.self.frame.size.height = CGFloat(300)
        photoImageView.self.frame.size.width = CGFloat(view.frame.size.width - 40)
        
        userNameTextField = UITextField(frame: CGRect(x: 20, y: 500, width: view.frame.size.width - 40, height: 30))
        
        if usrDefaults.value(forKey: "username") == nil {
            userNameTextField.placeholder = "Username"
        } else {
            userNameTextField.text = usrDefaults.value(forKey: "username") as? String
        }
                
        if usrDefaults.value(forKey: "userprofilephoto") == nil {
            photoImageView.image = accountPhoto
        } else {
            DispatchQueue.main.async {
                self.photoImageView.image = UIImage(data: (usrDefaults.data(forKey: "userprofilephoto")!))
            }
        }
        
        if usrDefaults.value(forKey: "categoriesSelected") != nil {
            categoriesSelected = usrDefaults.value(forKey: "categoriesSelected") as! [Bool]
        }
        
        if usrDefaults.value(forKey: "countCategoriesSelected") != nil {
            countCategoriesSelected = usrDefaults.value(forKey: "countCategoriesSelected") as? Int
        } else {
            countCategoriesSelected = 0
        }
                
        view.addSubview(userNameTextField)
        view.addSubview(photoImageView)
        view.addSubview(selectionView)
        
        setChoseProfilePictureButton()
        
        setSaveGCDButton()
        setSaveNSOperationButton()
        
        setShowCategoriesButton()
        
        // Do any additional setup after loading the view.
    }
    
    func setChoseProfilePictureButton() {
        
        choseProfilePictureButton = UIButton(frame: CGRect(x: photoImageView.frame.maxX - 50, y: photoImageView.frame.maxY + 20, width: 50, height: 50))
        
        choseProfilePictureButton.setImage(UIImage(named: "Camera_2"), for: .normal)
        choseProfilePictureButton.imageView?.contentMode = .scaleAspectFit
        choseProfilePictureButton.showsTouchWhenHighlighted = true
        choseProfilePictureButton.addTarget(self, action: #selector(setChoseProfilePictureButtonPressed), for: .touchUpInside)
        
        view.addSubview(choseProfilePictureButton)
    }
    
    @IBAction func setChoseProfilePictureButtonPressed() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func setSaveGCDButton() {
        saveGCDButton = UIButton(frame: CGRect(x: 10, y: view.frame.size.height * 3 / 4, width: view.frame.size.width / 3, height: 30))
        saveGCDButton.backgroundColor = .gray
        saveGCDButton.titleLabel?.textColor = .black
        saveGCDButton.setTitle("GCD", for: .normal)
        saveGCDButton.clipsToBounds = true
        saveGCDButton.layer.cornerRadius = 15
        saveGCDButton.showsTouchWhenHighlighted = true
        saveGCDButton.addTarget(self, action: #selector(GCDPressed), for: .touchUpInside)
        
        view.addSubview(saveGCDButton)
    }
    
    @IBAction func GCDPressed() {
        
        DispatchQueue.global().async {
            let usrDefaults = UserDefaults.standard
            
            usrDefaults.set(self.userNameTextField.text!, forKey: "username")
            usrDefaults.set(self.photoImageView.image!.pngData(), forKey: "userprofilephoto")
            usrDefaults.set(self.categoriesSelected, forKey: "categoriesSelected")
            usrDefaults.set(self.countCategoriesSelected, forKey: "countCategoriesSelected")
            
            usrDefaults.synchronize()
        }
    }
    
    func setSaveNSOperationButton() {
        saveNSOperationButton = UIButton(frame: CGRect(x: view.frame.size.width - 10 - view.frame.size.width / 3, y: view.frame.size.height * 3 / 4, width: view.frame.size.width / 3, height: 30))
        saveNSOperationButton.backgroundColor = .gray
        saveNSOperationButton.titleLabel?.textColor = .black
        saveNSOperationButton.setTitle("NSOperation", for: .normal)
        saveNSOperationButton.clipsToBounds = true
        saveNSOperationButton.layer.cornerRadius = 15
        saveNSOperationButton.showsTouchWhenHighlighted = true
        saveNSOperationButton.addTarget(self, action: #selector(NSOperationPressed), for: .touchUpInside)
        
        view.addSubview(saveNSOperationButton)
    }
    
    @IBAction func NSOperationPressed() {
        
    }
    
    func setShowCategoriesButton() {
        showCategoriesButton = UIButton(frame: CGRect(x: 20, y: 550, width: view.frame.size.width - 40, height: 30))
        showCategoriesButton.backgroundColor = .white
        showCategoriesButton.setTitle("Categories: \(countCategoriesSelected ?? -1) selected", for: .normal)
        showCategoriesButton.setTitleColor(.black, for: .normal)
        showCategoriesButton.layer.borderWidth = 1
        showCategoriesButton.layer.borderColor = (UIColor.black).cgColor
        showCategoriesButton.clipsToBounds = true
        showCategoriesButton.layer.cornerRadius = 5
        showCategoriesButton.addTarget(self, action: #selector(showCategoriesButtonPressed), for: .touchUpInside)

        view.addSubview(showCategoriesButton)
    }
    
    @IBAction func showCategoriesButtonPressed() {
        selectionView.isHidden = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.photoImageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func setSelectionView() {
        
        setSelectionTbView()
        setSelectionViewHideButton()
        
        selectionView.clipsToBounds = true
        selectionView.layer.cornerRadius = 20
                
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = selectionView.bounds
        
        selectionView.addSubview(blurView)
        selectionView.alpha = 1
        selectionView.insertSubview(blurView, at: 0)
        
        selectionView.addSubview(selectionTbView)
        selectionView.addSubview(selectionViewHideButton)
        
        selectionView.layer.zPosition = 10
    }
    
    func setSelectionTbView() {
        
        selectionTbView.register(CellSelectionAccountVC.self, forCellReuseIdentifier: "selectionTVCell")
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = selectionTbView.bounds
        
        selectionTbView.backgroundColor = .clear
        selectionTbView.separatorStyle = .none
        
        selectionTbView.delegate = self
        selectionTbView.dataSource = self
        
    }
    
    func setSelectionViewHideButton() {
        selectionViewHideButton.backgroundColor = .white
        selectionViewHideButton.layer.zPosition = 15
        selectionViewHideButton.backgroundColor = .red
        selectionViewHideButton.addTarget(self, action: #selector(selectionViewHideButtonPressed(_:)), for: .touchUpInside)
    }
    
    @IBAction func selectionViewHideButtonPressed(_ sender: Any) {
        selectionView.isHidden = true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CellSelectionAccountVC = tableView.dequeueReusableCell(withIdentifier: "selectionTVCell") as! CellSelectionAccountVC
        
//        cellSelected = indexPath.row
        
        cell.backgroundColor = .clear
                
        cell.cellLabel.frame = CGRect(x: 20, y: 0, width: view.frame.size.width / 2 - 20, height: 50)
        cell.cellLabel.text = categories[indexPath.row]
        
        cell.cellButtonSelected.frame = CGRect(x: view.frame.size.width - 50, y: 10, width: 30, height: 30)
        
        if categoriesSelected[indexPath.row] {
            cell.cellButtonSelected.backgroundColor = .green
        } else {
            cell.cellButtonSelected.backgroundColor = .blue
        }
        
        cell.cellButtonSelected.addTarget(self, action: #selector(cellButtonSelectedPressed(sender:)), for: .touchUpInside)
        
        
//        cell.isUserInteractionEnabled = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        categoriesSelected[indexPath.row] = !categoriesSelected[indexPath.row]
        
        let cell: CellSelectionAccountVC = tableView.dequeueReusableCell(withIdentifier: "selectionTVCell") as! CellSelectionAccountVC
        
        if categoriesSelected[indexPath.row] {
            cell.cellButtonSelected.backgroundColor = .green
            countCategoriesSelected += 1
        } else {
            cell.cellButtonSelected.backgroundColor = .blue
            countCategoriesSelected -= 1
        }
        
        showCategoriesButton.setTitle("Categories: \(Int(countCategoriesSelected) ) selected", for: .normal)
        
        tableView.reloadData()
        
        print(categoriesSelected)
    }
    
    @IBAction func cellButtonSelectedPressed(sender: UIButton) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectionView.isHidden = true
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
