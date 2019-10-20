//
//  AccountViewController.swift
//  TrackProject
//
//  Created by Денис Дубовиков on 16/10/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var photoImageView: UIImageView!
    var userNameTextField: UITextField!
    
    var choseProfilePictureButton: UIButton!
    
    var saveGCDButton: UIButton!
    var saveNSOperationButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
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
        
        view.addSubview(userNameTextField)
        view.addSubview(photoImageView)
        
        setChoseProfilePictureButton()
        
        setSaveGCDButton()
        setSaveNSOperationButton()
        
        // Do any additional setup after loading the view.
    }
    
    func setChoseProfilePictureButton() {
        choseProfilePictureButton = UIButton(frame: CGRect(x: photoImageView.frame.maxX - 60, y: photoImageView.frame.maxY + 20, width: 60, height: 60))
//        choseProfilePictureButton.layer.borderWidth = 2
        
        choseProfilePictureButton.setImage(UIImage(named: "cameraLabel"), for: .normal)
        choseProfilePictureButton.imageView?.contentMode = .scaleAspectFill
//        choseProfilePictureButton.imageView?.image = UIImage(named: "cameraLabel")
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
        DispatchQueue.main.async {
            let usrDefaults = UserDefaults.standard
            
            usrDefaults.set(self.userNameTextField.text!, forKey: "username")
            usrDefaults.set(self.photoImageView.image!.pngData(), forKey: "userprofilephoto")
            
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.photoImageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
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
