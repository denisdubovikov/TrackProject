//
//  AccountViewController.swift
//  TrackProject
//
//  Created by Денис Дубовиков on 16/10/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var ColorPalette = Palette.shared
    
    var categoriesAll: [String] = []
    var categoriesSelected: [Bool] = []
    
    var countCategoriesSelected: Int!
    
    var photoImageView: UIImageView!
    var accountPhoto: UIImage!
    
    var userNameTextField: UITextField!
    var userName: String!
    
    var userSurnameTextField: UITextField!
    var userSurname: String!
    
    
    var cameraButton: UIButton!
    var viewUnderCameraButton: UIView!
    
//    var saveGCDButton: UIButton!
//    var saveNSOperationButton: UIButton!
    var backButton: UIButton!
    var doneButton:UIButton!
    
    var imagePicker = UIImagePickerController()
    
    var selectionView: UIView!
    var selectionTbView: UITableView!
    var selectionViewHideButton: UIButton!
    
    var showCategoriesButton: UIButton!
    
    var activityIndicatorView: UIView!
    var activityIndicator: UIActivityIndicatorView!
    var savedView: UIView!
    var savedImageView: UIImageView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
             view.backgroundColor = .white
        }
       
        
        //do not change the order!!
        
        readUserDefaults()

        setupPhotoImageView()
        setupBackButton()
        setupSelectionView()
        setupUserNameTextField()
        setupUserSurnameTextField()
//        setupSaveGCDButton()
//        setupSaveNSOperationButton()
        setupShowCategoriesButton()
        setupActivityIndicatorView()
        
        setupDoneButton()
//        setupSavedView()
        
//        view.backgroundColor = .white
                
        view.addSubview(userNameTextField)
        view.addSubview(userSurnameTextField)
        view.addSubview(photoImageView)
        view.addSubview(selectionView)
//        view.addSubview(saveGCDButton)
//        view.addSubview(saveNSOperationButton)
        view.addSubview(activityIndicatorView)
        view.addSubview(showCategoriesButton)
//        view.addSubview(savedView)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
//MARK: Read userdefaults
    func readUserDefaults() {
        let usrDefaults = UserDefaults.standard
    
        if usrDefaults.value(forKey: "username") == nil {
            userName = ""
        } else {
            userName = usrDefaults.value(forKey: "username") as? String
        }
        
        if usrDefaults.value(forKey: "usersurname") == nil {
            userSurname = ""
        } else {
            userSurname = usrDefaults.value(forKey: "usersurname") as? String
        }
                
//        if usrDefaults.value(forKey: "userprofilephoto") == nil {
//            accountPhoto = UIImage(named: "")
//        } else {
//            accountPhoto = UIImage(data: (usrDefaults.data(forKey: "userprofilephoto")!))
//        }
        
        accountPhoto = retrieveImage(forKey: "userprofilephoto")
        
        if usrDefaults.value(forKey: "categoriesSelected") != nil {
            categoriesSelected = usrDefaults.value(forKey: "categoriesSelected") as! [Bool]
//            print(categoriesSelected)
        }
        
        if usrDefaults.value(forKey: "countCategoriesSelected") != nil {
            countCategoriesSelected = usrDefaults.value(forKey: "countCategoriesSelected") as? Int
        } else {
            countCategoriesSelected = 0
        }
    }
    
    
    
    
//MARK: Account photo imageView
    func setupPhotoImageView() {
        photoImageView = UIImageView(frame: CGRect(x: (view.frame.size.width - view.frame.size.width / 1.05) / 2, y: (navigationController?.navigationBar.frame.maxY)! + (view.frame.size.width - view.frame.size.width / 1.05) / 2, width: view.frame.size.width / 1.05, height: view.frame.size.width / 1.3))
        photoImageView.contentMode = UIView.ContentMode.scaleAspectFill
        photoImageView.backgroundColor = .gray
        photoImageView.image = accountPhoto
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 20
        
        photoImageView.isUserInteractionEnabled = true
        
        setupCameraButton()
        
        photoImageView.addSubview(viewUnderCameraButton)
    }
    
    
    
    
//MARK: User name surname textFields
    func setupUserNameTextField() {
        userNameTextField = UITextField(frame: CGRect(x: (view.frame.size.width - view.frame.size.width / 1.05) / 2, y: photoImageView.frame.maxY + (view.frame.size.width - view.frame.size.width / 1.05) / 2, width: view.frame.size.width / 1.05, height: 30))
        
//        userNameTextField.textColor = .black
//        userNameTextField.layer.borderWidth = 1
        userNameTextField.clipsToBounds = true
        userNameTextField.layer.cornerRadius = 10
        userNameTextField.clearButtonMode = .whileEditing
        userNameTextField.borderStyle = .roundedRect
        
        userNameTextField.resignFirstResponder()
        
        if userName != "" {
            userNameTextField.text = userName
        } else {
            userNameTextField.placeholder = "User name"
        }
        
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(userNameTextField.endEditing(_:)))
        
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    func setupUserSurnameTextField() {
        userSurnameTextField = UITextField(frame: CGRect(x: (view.frame.size.width - view.frame.size.width / 1.05) / 2, y: userNameTextField.frame.maxY + (view.frame.size.width - view.frame.size.width / 1.05) / 2, width: view.frame.size.width / 1.05, height: 30))
        
//        userSurnameTextField.textColor = .black
        userSurnameTextField.layer.borderWidth = 0
        userSurnameTextField.clipsToBounds = true
        userSurnameTextField.layer.cornerRadius = 10
        userSurnameTextField.clearButtonMode = .whileEditing
        userSurnameTextField.borderStyle = .roundedRect
        
        userSurnameTextField.resignFirstResponder()
        
        if userSurname != "" {
            userSurnameTextField.text = userSurname
        } else {
            userSurnameTextField.placeholder = "User surname"
        }
        
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(userSurnameTextField.endEditing(_:)))
        
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
    
//MARK: Activity indicator
    func setupActivityIndicatorView() {
        activityIndicatorView = UIView(frame: CGRect(x: view.frame.size.width / 2 - 30, y: photoImageView.frame.maxY - 65, width: 60, height: 60))
        activityIndicatorView.clipsToBounds = true
        activityIndicatorView.layer.cornerRadius = 10
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 10, width: 40, height: 40))
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = activityIndicatorView.bounds
        
        activityIndicatorView.addSubview(blurView)
        activityIndicatorView.alpha = 1
        activityIndicatorView.insertSubview(blurView, at: 0)
        
        activityIndicator.layer.zPosition = 100
        
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicatorView.isHidden = true
        
        activityIndicatorView.addSubview(activityIndicator)
    }
    
    
    
    
//MARK: Camera button
    func setupCameraButton() {
        imagePicker.delegate = self
        
        cameraButton = UIButton(frame: CGRect(x: 15, y: 15, width: 70, height: 70))
        
        cameraButton.layer.cornerRadius = 20
        cameraButton.setImage(UIImage(named: ColorPalette.cameraButtonImageName), for: .normal)
        cameraButton.imageView?.contentMode = .scaleAspectFit
        cameraButton.showsTouchWhenHighlighted = true
        cameraButton.addTarget(self, action: #selector(cameraButtonPressed), for: .touchUpInside)
        
        setupViewUnderCameraButton()
        
        viewUnderCameraButton.addSubview(cameraButton)
    }
    
    func setupViewUnderCameraButton() {
        viewUnderCameraButton = UIView(frame: CGRect(x: photoImageView.frame.width / 2 - 50, y: photoImageView.frame.height / 2 - 50, width: 100, height: 100))
        
        viewUnderCameraButton.layer.cornerRadius = 50
        viewUnderCameraButton.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.3)
        viewUnderCameraButton.isUserInteractionEnabled = true
    }
    
    @objc func cameraButtonPressed() {
//        imagePicker.sourceType = .photoLibrary
//        imagePicker.allowsEditing = true
//        present(imagePicker, animated: true, completion: nil)
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openPhotoLibrary()
        }))

        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

        /*If you want work actionsheet on ipad
        then you have to use popoverPresentationController to present the actionsheet,
        otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = view
            alert.popoverPresentationController?.sourceRect = view.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }

        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if (UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func openPhotoLibrary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    
//MARK: Back button
    func setupBackButton() {
        
//        self.navigationItem.setHidesBackButton(true, animated: true)
        
//        let backButtonView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//
//        let backButtonImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//
//        backButtonImageView.image = UIImage(named: "BackArrow")
//        backButtonImageView.contentMode = .scaleAspectFit
//
//        backButtonView.addSubview(backButtonImageView)
//
//        let backTapRecognizer = UIGestureRecognizer(target: self, action: #selector(backButtonPressed))
//
//        backButtonView.addGestureRecognizer(backTapRecognizer)
//
//        let backButtonItem = UIBarButtonItem(customView: backButtonView)
//
//        self.navigationItem.leftBarButtonItem = backButtonItem
    }
        
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
//MARK: Save GCD button
    func setupDoneButton() {
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(GCDPressed))]
    }
    
//    3
    
    @objc func GCDPressed() {
        activityIndicator.startAnimating()
        activityIndicatorView.isHidden = false
        
        if self.photoImageView.image != nil {
                        let img: UIImage = self.photoImageView.image!
        //                img.jpegData(compressionQuality: 0.5)
                        
                        self.store(image: img, forKey: "userprofilephoto")
                    }
        
        
        
        DispatchQueue.global().async {
            let usrDefaults = UserDefaults.standard
            
//            if self.photoImageView.image != nil {
//                let img: UIImage = self.photoImageView.image!
////                img.jpegData(compressionQuality: 0.5)
//
//                self.store(image: img, forKey: "userprofilephoto")
//            }
            
            usrDefaults.set(self.userNameTextField.text!, forKey: "username")
            usrDefaults.set(self.userSurnameTextField.text!, forKey: "usersurname")
            usrDefaults.set(self.categoriesSelected, forKey: "categoriesSelected")
            usrDefaults.set(self.countCategoriesSelected, forKey: "countCategoriesSelected")
            
            usrDefaults.synchronize()
            
//            self.savedViewAnimate()
        }
        
        activityIndicatorView.isHidden = true
        activityIndicator.stopAnimating()
                   
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
//MARK: Save NSO button
//    func setupSaveNSOperationButton() {
//        saveNSOperationButton = UIButton(frame: CGRect(x: view.frame.size.width - 10 - view.frame.size.width / 3, y: view.frame.size.height * 3 / 4, width: view.frame.size.width / 3, height: 30))
//        saveNSOperationButton.backgroundColor = .gray
//        saveNSOperationButton.titleLabel?.textColor = .black
//        saveNSOperationButton.setTitle("NSOperation", for: .normal)
//        saveNSOperationButton.clipsToBounds = true
//        saveNSOperationButton.layer.cornerRadius = 15
//        saveNSOperationButton.showsTouchWhenHighlighted = true
//        saveNSOperationButton.addTarget(self, action: #selector(NSOperationPressed), for: .touchUpInside)
//    }
//
//    @objc func NSOperationPressed() {
//
//    }
    
    
    
    
//MARK: Saved view
    func setupSavedView() {
        savedView = UIView(frame: CGRect(x: view.frame.size.width / 2 - 13, y: photoImageView.frame.midY / 2 - 5, width: 26, height: 10))
        
        savedView.backgroundColor = .white
        savedView.alpha = 0
        savedView.clipsToBounds = true
        savedView.layer.cornerRadius = 5
        
        savedImageView = UIImageView(frame: CGRect(x: 4, y: 1.5, width: 18, height: 7))
        
        savedImageView.image = UIImage(named: "SavedLabel")
        savedImageView.contentMode = .scaleAspectFit
        savedView.isHidden = true
        
        savedView.addSubview(savedImageView)
    }
    
    func savedViewAnimate() {
        savedView.isHidden = false
        
        UIView.animate(withDuration: 0.7, animations: {
            self.savedView.transform = CGAffineTransform(scaleX: 4, y: 4)
            self.savedView.alpha = 0.7
        }) { (finished) in
            guard finished else {
                return
            }
            
//            self.view.willRemoveSubview(self.savedView)
            
            self.savedView.removeFromSuperview()
            
            self.setupSavedView()
            
            self.view.addSubview(self.savedView)
        }
    }
    
    
    
//MARK: Show categories button
    func setupShowCategoriesButton() {
        showCategoriesButton = UIButton(frame: CGRect(x: (view.frame.size.width - view.frame.size.width / 1.05) / 2, y: userSurnameTextField.frame.maxY + (view.frame.size.width - view.frame.size.width / 1.05) / 2, width: view.frame.size.width / 1.05, height: 30))
        showCategoriesButton.backgroundColor = .clear
        showCategoriesButton.setTitle("Categories: \(countCategoriesSelected ?? -1) selected", for: .normal)
        showCategoriesButton.setTitleColor(ColorPalette.textColor, for: .normal)
//        showCategoriesButton.layer.borderWidth = 1
//        showCategoriesButton.layer.borderColor = (UIColor.black).cgColor
        showCategoriesButton.clipsToBounds = true
        showCategoriesButton.layer.cornerRadius = 5
        showCategoriesButton.addTarget(self, action: #selector(showCategoriesButtonPressed), for: .touchUpInside)
    }
    
    @objc func showCategoriesButtonPressed() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showCategoriesButtonPressed))
//        tapGesture.cancelsTouchesInView = false
        
        var flag: Bool = false
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            if self.selectionView.isHidden {
                self.showCategoriesButton.isEnabled = false
//                self.saveGCDButton.isEnabled = false
//                self.saveNSOperationButton.isEnabled = false
                self.cameraButton.isEnabled = false
                
                self.selectionView.isHidden = false
                self.selectionView.center.y -= 300
                self.selectionView.alpha = 1
                
//                self.view.addGestureRecognizer(tapGesture)
            } else {
                self.showCategoriesButton.isEnabled = true
//                self.saveGCDButton.isEnabled = true
//                self.saveNSOperationButton.isEnabled = true
                self.cameraButton.isEnabled = true
                
                self.selectionView.center.y += 300
                self.selectionView.alpha = 0
                flag = true
            }
        }) { (finished) in
            guard finished else {
                return
            }
            
            if flag {
                self.selectionView.isHidden = true
//                self.view.removeGestureRecognizer(self.view.gestureRecognizers!.last!)
                
//                self.selectionView.
            }
        }
        
    }
    
    
    
    
//MARK: Image picker controller
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.photoImageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
//MARK: Selection view
    func setupSelectionView() {
        let selectionViewFrame = CGRect(x: 0, y: view.frame.size.height, width: view.frame.size.width, height: 350)
        
        selectionView = UIView(frame: selectionViewFrame)
        
        setupSelectionTbView()
//        setupSelectionViewHideButton()
        
        selectionView.clipsToBounds = true
        selectionView.layer.cornerRadius = 20
                
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = selectionView.bounds
        
        selectionView.addSubview(blurView)
        selectionView.alpha = 1
        selectionView.insertSubview(blurView, at: 0)
        
        selectionView.addSubview(selectionTbView)
//        selectionView.addSubview(selectionViewHideButton)
        
        selectionView.layer.zPosition = 10
    }
    
    func setupSelectionTbView() {
        let selectionTbViewFrame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 300)
        
        selectionTbView = UITableView(frame: selectionTbViewFrame)
        
        selectionTbView.register(CellSelectionAccountVC.self, forCellReuseIdentifier: "selectionTVCell")
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = selectionTbView.bounds
        
        selectionTbView.backgroundColor = .clear
        selectionTbView.separatorStyle = .none
        
        selectionTbView.delegate = self
        selectionTbView.dataSource = self
        
    }
    
    func setupSelectionViewHideButton() {
        let selectionViewHideButtonFrame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30)
        
        selectionViewHideButton = UIButton(frame: selectionViewHideButtonFrame)
        
        selectionViewHideButton.layer.zPosition = 15
        selectionViewHideButton.backgroundColor = .red
        selectionViewHideButton.addTarget(self, action: #selector(showCategoriesButtonPressed), for: .touchUpInside)
    }
    
    
    
    
//MARK: Table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoriesAll.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CellSelectionAccountVC = tableView.dequeueReusableCell(withIdentifier: "selectionTVCell") as! CellSelectionAccountVC
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
                
        cell.cellLabel.frame = CGRect(x: 20, y: 0, width: view.frame.size.width / 2 - 20, height: 50)
        cell.cellLabel.text = categoriesAll[indexPath.row]
        
        cell.cellButtonSelected.frame = CGRect(x: view.frame.size.width - 50, y: 10, width: 30, height: 30)
        cell.cellButtonSelected.setImage(UIImage(named: "Star_v2"), for: .normal)
        
        if categoriesSelected[indexPath.row] {
//            cell.cellButtonSelected.backgroundColor = .green
            cell.cellButtonSelected.imageView?.alpha = 1
        } else {
            cell.cellButtonSelected.imageView?.alpha = 0.3
//            cell.cellButtonSelected.backgroundColor = .blue
        }
        
        cell.cellButtonSelected.addTarget(self, action: #selector(cellButtonSelectedPressed(sender:)), for: .touchUpInside)
        
        
//        cell.isUserInteractionEnabled = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        categoriesSelected[indexPath.row] = !categoriesSelected[indexPath.row]
        
        let cell: CellSelectionAccountVC = tableView.dequeueReusableCell(withIdentifier: "selectionTVCell") as! CellSelectionAccountVC
        
        if categoriesSelected[indexPath.row] {
            cell.cellButtonSelected.imageView?.alpha = 1
            countCategoriesSelected += 1
        } else {
            cell.cellButtonSelected.imageView?.alpha = 0.3
            countCategoriesSelected -= 1
        }
        
        showCategoriesButton.setTitle("Categories: \(Int(countCategoriesSelected) ) selected", for: .normal)
        
        tableView.reloadData()
        
        print(categoriesSelected)
    }
    
    @objc func cellButtonSelectedPressed(sender: UIButton) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectionView.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        
        if touch?.view != selectionTbView {
            if !selectionView.isHidden {
                showCategoriesButtonPressed()
            }
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
    
    
//MARK: Saving photo in file directory
    private func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        
        return documentURL.appendingPathComponent(key + ".png")
    }
    
    private func store(image: UIImage, forKey key: String) {
        if let pngRepresentation = image.pngData() {
            if let filePath = filePath(forKey: key) {
                do  {
                    try pngRepresentation.write(to: filePath,
                                                options: .atomic)
                } catch let err {
                    print("Saving file resulted in error: ", err)
                }
            }
        }
    }
    
    private func retrieveImage(forKey key: String) -> UIImage? {
        if let filePath = self.filePath(forKey: key),
            let fileData = FileManager.default.contents(atPath: filePath.path),
            let image = UIImage(data: fileData) {
            return image
        }
        
        return nil
    }
    
    

}
