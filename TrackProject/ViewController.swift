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
    
    var buttonAccount: UIButton!
    var buttonAtTheTop: UIButton!
    var topView: UIView!
    
    var images = ["img1", "img2", "img3", "img4"]
    var titles = ["Rent your bus!", "The secret of Michigan", "Try yourself now", "Hot discussions"]
    
    var categories = ["Main", "Travel", "Education", "Other"]
    var categoriesSelected = [false, false, false, false]
    var countCategoriesSelected: Int!
    
    var countOfArticles = 0
    var imagesURLParsed: [URL] = []
    var titlesParsed: [String] = []
    var contentsParsed: [String] = []
        
    var UIViewWithPickerView: UIView!
    var pickerViewOnUIView: UIPickerView!
    
    var myRequest = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=fc3c4a1a6478477c950bf27f2500ded9")
        
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
        
        readUserDefaults()
        
        createButtonAccount()
        setButtonAccount()
        
        createButtonAtTheTop()
        setButtonAtTheTop(indexCategory: 0)
        
        setTopView()
        createUIViewWithPickerView()
        
        navigationController?.popToRootViewController(animated: true)
        
        self.navigationController?.navigationBar.addSubview(topView)
        
        parseData()
    }
    
    
    
    
    
// MARK: Reads the data from userdefaults
    func readUserDefaults() {
        let userDefaults = UserDefaults.standard
        
        if userDefaults.value(forKey: "categoriesSelected") != nil {
            categoriesSelected = userDefaults.value(forKey: "categoriesSelected") as! [Bool]
        }
        
        if userDefaults.value(forKey: "contCategoriesSelected") != nil {
            countCategoriesSelected = userDefaults.value(forKey: "countCategoriesSelected") as? Int
        }
    }

    
    
    
    
// MARK: Parses the data (url)
    func parseData() {
        let task = URLSession.shared.dataTask(with: myRequest!) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("status code: \(response.statusCode)")
                }
                
                let product: myResp = try! JSONDecoder().decode(myResp.self, from: data!)
                
                self.countOfArticles = min(15, product.totalResults ?? 15)
                
                for i in 0...self.countOfArticles {
                    self.imagesURLParsed.append(product.articles[i].urlToImage ?? URL(fileURLWithPath: "nil"))
                    self.titlesParsed.append(product.articles[i].title ?? "no title")
                    self.contentsParsed.append(product.articles[i].content ?? "no content")
                }
                
                print(product)
                
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
            }
        }
        
        task.resume()
    }
    
    
    
    
    
// MARK: Creates the button at the top
    func createButtonAtTheTop() {
        let navBarFrame: CGRect = navigationController?.navigationBar.frame ?? CGRect(x: 50, y: 50, width: 30, height: 30)
        
        buttonAtTheTop = UIButton(frame: CGRect(x: navBarFrame.size.width / 2 - navBarFrame.size.width / 6, y: navBarFrame.size.height / 2 - navBarFrame.size.height / 6, width: navBarFrame.size.width / 3, height: navBarFrame.size.height / 3))
    }
  
    
    
    
    
// MARK: Sets up the button at the top
    func setButtonAtTheTop(indexCategory: Int) {
        buttonAtTheTop.isHidden = true
        
        buttonAtTheTop.setTitle("", for: .normal)
        buttonAtTheTop.titleLabel?.frame.size.width = buttonAtTheTop.frame.size.width
        buttonAtTheTop.setTitleColor(UIColor.black, for: .normal)
        buttonAtTheTop.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 20)
        buttonAtTheTop.setTitle(categories[indexCategory], for: .normal)
        
        
        buttonAtTheTop.addTarget(self, action: #selector(buttonAtTheTopPressed(_:)), for: .touchUpInside)
        
        buttonAtTheTop.isHidden = false
    }
    
    
    
    
    
    @objc func buttonAtTheTopPressed(_ sender: Any) {
        UIViewWithPickerView.isHidden = !UIViewWithPickerView.isHidden
    }
  
    
    
    
    
// MARK: Creates the account button
    func createButtonAccount() {
        let navBarFrame: CGRect = (navigationController?.navigationBar.frame ?? nil)!
        buttonAccount = UIButton(frame: CGRect(x: navBarFrame.size.width - (navBarFrame.size.height / 1.5 + navBarFrame.size.height / 6), y: navBarFrame.size.height / 2 - navBarFrame.size.height / 3, width: navBarFrame.size.height / 1.5, height: navBarFrame.size.height / 1.5))
    }
   
    
    
    
    
// MARK: Sets up the account button
    func setButtonAccount() {
        buttonAccount.backgroundColor = .clear
        buttonAccount.setImage(UIImage(named: "Account"), for: .normal)
        buttonAccount.imageView?.contentMode = .scaleAspectFit
        
        
        buttonAccount.addTarget(self, action: #selector(buttonAccountPressed(_:)), for: .touchUpInside)
    }
    
    
    
    

    @objc func buttonAccountPressed(_ sender: Any) {
        let accountVC = AccountViewController()
            
        accountVC.categories = categories
        accountVC.categoriesSelected = categoriesSelected
        
        self.navigationController?.pushViewController(accountVC, animated: true)
    }
    
    
    
    
// MARK: Adds the blur effect on navBar
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = (self.navigationController?.navigationBar.bounds.insetBy(dx: 0, dy: 0).offsetBy(dx: 0, dy: 0))!
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.addSubview(blurView)
        self.navigationController?.navigationBar.sendSubviewToBack(blurView)
    }

    
    
    
    
// MARK: Sets up the view at the top (on navBar)
    func setTopView() {
        let topViewFrame = CGRect(x: 0, y: 0, width: (navigationController?.navigationBar.frame.size.width)!, height: (navigationController?.navigationBar.frame.size.height)!)
        
        topView = UIView(frame: topViewFrame)
        
        setButtonAccount()
        setButtonAtTheTop(indexCategory: 0)
        
        topView.addSubview(buttonAccount)
        topView.addSubview(buttonAtTheTop)
    }

    
    

// MARK: TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countOfArticles
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TBVCCell") as! TableViewCell
        let imgURL = imagesURLParsed[indexPath.row]
    
        //getting the image
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imgURL) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.TableViewCellImageView.image = image
                    }
                }
            }
        }
        
        cell.TableViewCellTitle.textColor = UIColor.white
        cell.TableViewCellTitle.font = UIFont(name: "Helvetica Neue", size: 36)
        cell.TableViewCellTitle.text = titlesParsed[indexPath.row]
        cell.TableViewCellImageView.contentMode = UIView.ContentMode.scaleAspectFill
        cell.TableViewCellImageView.clipsToBounds = true
        cell.TableViewCellImageView.layer.cornerRadius = 20
        cell.TableViewCellImageView.self.frame.size.height = CGFloat(300)
        cell.TableViewCellImageView.self.frame.size.width = CGFloat(cell.frame.size.width - 40)
                
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: cell.TableViewCellImageView.frame.size.width, height: cell.TableViewCellImageView.frame.size.height))
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.5, 1]
        
        cell.TableViewCellImageView.layer.sublayers?.removeAll()
        cell.TableViewCellImageView.layer.addSublayer(gradient)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        let nextVC = CardOfANewViewController()

        nextVC.titleOfTheNew = titlesParsed[indexPath.row]
        nextVC.imageOfTheNewURL = imagesURLParsed[indexPath.row]
        nextVC.textNew = contentsParsed[indexPath.row]
        
        print(imagesURLParsed[indexPath.row])
                
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }

    
    
    
// MARK: PickerView
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
        setButtonAtTheTop(indexCategory: row)
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

