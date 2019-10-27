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
//    @IBOutlet weak var UIViewAtTheTop: UIView!
//    @IBOutlet weak var buttonAtTheTop: UIButton!
//    @IBOutlet weak var UIViewAtTheTop: UIView!
    
    var buttonAccount : UIButton!
    var buttonAtTheTop: UIButton!
    var UIViewAtTheTop: UIView!
    
    var images = ["img1", "img2", "img3", "img4"]
    var titles = ["Rent your bus!", "The secret of Michigan", "Try yourself now", "Hot discussions"]
    
    var categories = ["Main", "Travel", "Education", "Other"]
    
    var countOfArticles = -1
    var imagesURLParsed: [URL] = []
    var titlesParsed: [String] = []
        
    var UIViewWithPickerView: UIView!
    var pickerViewOnUIView: UIPickerView!
    
    var myRequest = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=fc3c4a1a6478477c950bf27f2500ded9")
    
//    var myResponse: [String: Any]
    
    struct myResp: Codable {
        var status: String?
        var totalResults: Int?
        struct cArticles: Codable {
            struct source: Codable {
                var id: Int?
                var name: String?
            }
            var author: String?
            var title: String?
            var description: String?
            var url: URL?
            var urlToImage: URL?
            var publishedAt: String?
            var content: String?
        }
        var articles: [cArticles]
    }
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let task = URLSession.shared.dataTask(with: myRequest!) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("status code: \(response.statusCode)")
                }
            
//                let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
                
//                print(responseJSON)
                
                let product: myResp = try! JSONDecoder().decode(myResp.self, from: data!)
                
                self.countOfArticles = 10//product.totalResults ?? -1
                
                print(product.articles)
                
                for i in 0...self.countOfArticles {
                    self.imagesURLParsed.append(product.articles[i].urlToImage ?? URL(fileURLWithPath: "nil"))
                    self.titlesParsed.append(product.articles[i].title ?? "nil")
                }
                
                print(product)
                
                
                
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
                
            }
            
        }
        
        task.resume()
            
        createUIViewWithPickerView()
        
        navigationController?.popToRootViewController(animated: true)
        
//        var buttonAtTheTopFrame = CGRect(x: 0, y: 0, width: 200, height: 30)
        let UIViewAtTheTopFrame = CGRect(x: 0, y: 0, width: (navigationController?.navigationBar.frame.size.width)!, height: (navigationController?.navigationBar.frame.size.height)!)
        
        UIViewAtTheTop = UIView(frame: UIViewAtTheTopFrame)
        buttonAtTheTop = UIButton(frame: CGRect(x: (navigationController?.navigationBar.frame.size.width)! / 2 - (navigationController?.navigationBar.frame.size.width)! / 6, y: (navigationController?.navigationBar.frame.size.height)! / 2 - (navigationController?.navigationBar.frame.size.height)! / 6, width: (navigationController?.navigationBar.frame.size.width)! / 3, height: (navigationController?.navigationBar.frame.size.height)! / 3))

        buttonAccount = UIButton(frame: CGRect(x: (navigationController?.navigationBar.frame.size.width)! - ((navigationController?.navigationBar.frame.size.height)! / 2 + (navigationController?.navigationBar.frame.size.height)! / 6), y:  (navigationController?.navigationBar.frame.size.height)! / 2 - (navigationController?.navigationBar.frame.size.height)! / 6, width: (navigationController?.navigationBar.frame.size.height)! / 3, height: (navigationController?.navigationBar.frame.size.height)! / 3))
                
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
//        UIViewAtTheTop.frame.size.width = view.frame.size.width
//        UIViewAtTheTop.frame.size.height = 30
        
//        UIViewAtTheTop.frame = (navigationController?.navigationBar.frame)!
        
        blurView.frame = (self.navigationController?.navigationBar.bounds.insetBy(dx: 0, dy: 0).offsetBy(dx: 0, dy: 0))!
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.addSubview(blurView)
        self.navigationController?.navigationBar.sendSubviewToBack(blurView)

                
//        UIViewAtTheTop.addSubview(blurView)
//        UIViewAtTheTop.alpha = 1
//        UIViewAtTheTop.insertSubview(blurView, at: 0)
                                
//        navigationItem.titleView?.addSubview(buttonAtTheTop)
        
//        UIViewAtTheTop.addSubview(buttonAtTheTop)
        
        setButtonAtTheTop(index: 0)
        setButtonAccount()
        
        buttonAtTheTop.isHidden = false
        buttonAccount.isHidden = false
        
//        navigationController?.navigationBar.backgroundColor = .clear
        
//        view.addSubview(UIViewAtTheTop)
//        view.addSubview(buttonAtTheTop)
        
        UIViewAtTheTop.addSubview(buttonAtTheTop)
        UIViewAtTheTop.addSubview(buttonAccount)
        
//        self.navigationController?.navigationBar.backItem.
        
//        self.navigationController?.navigationBar.backItem?.rightBarButtonItem?.action = Selector()
        
        self.navigationController?.navigationBar.addSubview(UIViewAtTheTop)
        
        buttonAtTheTop.layer.zPosition = 100
        buttonAccount.layer.zPosition = 100

        
//        print(UIViewAtTheTop.frame.size.height / 1.6)
        
//        myTableView.contentInset = UIEdgeInsets(top: UIViewAtTheTop.frame.size.height / 1.6, left: 0, bottom: 0, right: 0)
        
//        UINavigationBar.appearance().addSubview(UIViewAtTheTop)
        
        
//        print(buttonAtTheTop.titleLabel?.frame.size.width)
        
        
    }
    
    func setButtonAtTheTop(index: Int) {
        
        buttonAtTheTop.isHidden = true
        buttonAtTheTop.setTitle("", for: .normal)
        buttonAtTheTop.titleLabel?.frame.size.width = buttonAtTheTop.frame.size.width
        buttonAtTheTop.setTitleColor(UIColor.black, for: .normal)
        buttonAtTheTop.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 20)
        buttonAtTheTop.setTitle(categories[index], for: .normal)
        buttonAtTheTop.addTarget(self, action: #selector(ButtonAtTheTopPressed(_:)), for: .touchUpInside)
        
//        buttonAtTheTop.isHidden = false
    }
    
    func setButtonAccount() {

        buttonAccount.backgroundColor = .red
        buttonAccount.addTarget(self, action: #selector(ButtonAccountPressed(_:)), for: .touchUpInside)
    }

    // MARK: - Table view data source


    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return countOfArticles == -1 ? images.count : countOfArticles
    }


    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TBVCCell") as! TableViewCell
        
//        var cellImg: UIImage
        
        if countOfArticles == -1 {
//            cellImg = UIImage(named: images[indexPath.row])!
//            cell.TableViewCellImageView.image = cellImg
            return cell
        } else {
            let imgURL = imagesURLParsed[indexPath.row]
//            cellImg = UIImage(data: NSData(contentsOfFile: imagesURLParsed[indexPath.row]) as Data)!
            
            if imgURL != nil {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: imgURL) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                cell.TableViewCellImageView.image = image
                            }
                        }
                    }
                }
            } else {
                cell.TableViewCellImageView.image = UIImage(named: "img1")
            }
            
            cell.TableViewCellTitle.text = titlesParsed[indexPath.row]
        }
        
        
        cell.TableViewCellImageView.contentMode = UIView.ContentMode.scaleAspectFill
//        cell.TableViewCellImageView.image = cellImg
        cell.TableViewCellImageView.clipsToBounds = true
        cell.TableViewCellImageView.layer.cornerRadius = 20
        cell.TableViewCellImageView.self.frame.size.height = CGFloat(300)
        cell.TableViewCellImageView.self.frame.size.width = CGFloat(cell.frame.size.width - 40)
        
//        print(cell.TableViewCellImageView.frame)
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: cell.TableViewCellImageView.frame.size.width, height: cell.TableViewCellImageView.frame.size.height))
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.5, 1]
        
        cell.TableViewCellImageView.layer.sublayers?.removeAll()
        cell.TableViewCellImageView.layer.addSublayer(gradient)
        
        cell.TableViewCellTitle.textColor = UIColor.white
//        cell.TableViewCellTitle.text = titles[indexPath.row]
        cell.TableViewCellTitle.font = UIFont(name: "Helvetica Neue", size: 36)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        let nextVC = CardOfANewViewController()

        nextVC.titleOfTheNew = titlesParsed[indexPath.row]
        
        nextVC.imageOfTheNewURL = imagesURLParsed[indexPath.row]
        
        print(imagesURLParsed[indexPath.row])
                
        self.navigationController?.pushViewController(nextVC, animated: true)
        
//        self.present(nextVC, animated: true, completion: nil)
                
        
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
        
        setButtonAtTheTop(index: row)
        
        buttonAtTheTop.isHidden = false

        
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
        
//        print(pickerViewOnUIView.numberOfRows(inComponent: 0))
    }
    
    
    @IBAction func ButtonAtTheTopPressed(_ sender: Any) {
        
        UIViewWithPickerView.isHidden = !UIViewWithPickerView.isHidden
        
    }
    
    @IBAction func ButtonAccountPressed(_ sender: Any) {
        
        let accountVC = AccountViewController()
            
        accountVC.categories = categories
        
        self.navigationController?.pushViewController(accountVC, animated: true)
        
    }
    
    
    
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("Func: viewDidAppear. Notifies the view controller that its view was added to a view hierarchy.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Func: viewWillAppear. otifies the view controller that its view is about to be added to a view hierarchy.")
        buttonAtTheTop.isHidden = false
        buttonAccount.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("Func: viewDidDisappear. Notifies the view controller that its view was removed from a view hierarchy.")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("Func: viewWillDissappear. Notifies the view controller that its view is about to be removed from a view hierarchy.")
        buttonAtTheTop.isHidden = true
        buttonAccount.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        print("Func: viewDidLayoutSubviews. Called to notify the view controller that its view has just laid out its subviews.")
    }
    
    override func viewWillLayoutSubviews() {
        print("Func: viewWillLayoutSubviews. Called to notify the view controller that its view is about to layout its subviews.")
    }


}

