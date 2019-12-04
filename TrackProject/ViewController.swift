//
//  ViewController.swift
//  TrackProject
//
//  Created by Денис Дубовиков on 29/09/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let ColorPalette = Palette.shared
    
    var myDelegate: ViewControllerDelegate?
    
    private let refreshControl = UIRefreshControl()
            
    var menuButton: UIButton!
    var buttonAccount: UIButton!
    var buttonAtTheTop: UIButton!
    
    var refreshDataButton: UIButton!
    var refreshImageView: UIImageView!
    var refreshLabel: UILabel!
    
    var topView: UIView!
    var noNewsParsedImageView: UIImageView!
    
    var categoriesToChose: [String] = []
    var categoriesAll = ["🇷🇺Russia", "🇺🇸USA", "🇫🇷France", "💰Business", "😑Politics", "🌄Travel", "🎓Education", "🌦Weather", "👔Fashion"]
    var favoriteCategoriesSelected = [false, false, false, false, false, false, false, false, false]
    var countFavoriteCategoriesSelected: Int!
    var categorySelected: String? = nil
    var currentSelectedCategory = 1
    
    var countOfArticles = 0
    var imagesURLParsed: [URL] = []
    var titlesParsed: [String] = []
    var contentsParsed: [String] = []
    var authorsParsed: [String] = []
        
    var UIViewWithPickerView: UIView!
    var pickerViewOnUIView: UIPickerView!
    
    var mainPageTableView: UITableView!
    
    var lastContentOffset: CGPoint!
    
    var myRequest = URL(string: "https://newsapi.org/v2/top-headlines?country=ru&apiKey=fc3c4a1a6478477c950bf27f2500ded9")
    
    var managedObjectContext: NSManagedObjectContext?
    
    
    
    
        
    struct MyResp: Codable {
     var status: String?
        var totalResults: Int?
        struct cArticles: Codable {
            struct Source: Codable {
                var id: String?
                var name: String?
            }
            var source: Source?
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
    
    
    
    
    struct anyCodable: Codable {}
    
    struct responseCompressedImage: Codable {
        var src: String?
        var dest: String?
        var src_size: Int?
        var dest_size: Int?
        var pecent: Int?
        var expires: String?
        var error: String?
        var error_long: String?
    }
    
    var urlDict: [String: URL] = [
        "Russia": URL(string: "https://newsapi.org/v2/top-headlines?country=ru&apiKey=fc3c4a1a6478477c950bf27f2500ded9")!,
        "USA": URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=fc3c4a1a6478477c950bf27f2500ded9")!,
        "France": URL(string: "https://newsapi.org/v2/top-headlines?country=fr&apiKey=fc3c4a1a6478477c950bf27f2500ded9")!,
        "Business": URL(string: "https://newsapi.org/v2/top-headlines?category=business&apiKey=fc3c4a1a6478477c950bf27f2500ded9")!,
        "Politics": URL(string: "https://newsapi.org/v2/top-headlines?category=politics&apiKey=fc3c4a1a6478477c950bf27f2500ded9")!,
        "Travel": URL(string: "https://newsapi.org/v2/top-headlines?q=travel&apiKey=fc3c4a1a6478477c950bf27f2500ded9")!,
        "Education": URL(string: "https://newsapi.org/v2/top-headlines?q=education&apiKey=fc3c4a1a6478477c950bf27f2500ded9")!,
        "Weather": URL(string: "https://newsapi.org/v2/top-headlines?q=weather&apiKey=fc3c4a1a6478477c950bf27f2500ded9")!,
        "Fashion": URL(string: "https://newsapi.org/v2/top-headlines?q=fashion&apiKey=fc3c4a1a6478477c950bf27f2500ded9")!]
    
    var myDict: [Int: String] = [
        1: "Russia",
        2: "USA",
        3: "France",
        4: "Business",
        5: "Politics",
        6: "Travel",
        7: "Education",
        8: "Weather",
        9: "Fashion",]
    

    override func viewDidLoad() {
                
        super.viewDidLoad()
        
        
        
        makePaletteObjc()
        
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        
        
        makeCategoriesToChoose()
        
        readUserDefaults()

        setupTableView()
        
        view.addSubview(mainPageTableView)
        
        setupTopView()
        
        createUIViewWithPickerView()
        
        setupRefreshDataButton()
        
        setupNoNewsParsed()
        
        navigationController?.popToRootViewController(animated: true)
        
        self.navigationController?.navigationBar.addSubview(topView)
        
//        getNew()
        
        DispatchQueue.main.async {
            self.parseData()
            self.mainPageTableView.reloadData()
//            print("Here 1")
        }
        
        print("Here 2")
        
    }
    

    
    
//MARK: Bridging - palette
    func makePaletteObjc() {
        let reader = ThemeManager_swift()
        
        ColorPalette.isDarkModeAvailable = reader.isDarkModeAvailable
        ColorPalette.isDarkModeOn = reader.isDarkModeOn
                
        ColorPalette.textColor = reader.textColor
        ColorPalette.buttonAccountImageName = reader.buttonAccountImageName
        ColorPalette.menuButtonImageName = reader.menuButtonImageName
        ColorPalette.cameraButtonImageName = reader.cameraButtonImageName
        
        
        print(reader.isDarkModeAvailable)
        print(reader.isDarkModeOn)
        
        
        
        
    }
    
    
    
    
//MARK: Make categories to choose
    func makeCategoriesToChoose() {
        categoriesToChose.removeAll()

        categoriesToChose.append("⭐️Favorites")
        categoriesToChose.append(contentsOf: categoriesAll)
    }
    
    
    
    
// MARK: Read userdefaults
    func readUserDefaults() {
        let userDefaults = UserDefaults.standard
        
        if userDefaults.value(forKey: "categoriesSelected") != nil {
            favoriteCategoriesSelected = userDefaults.value(forKey: "categoriesSelected") as! [Bool]
        }
        
        if userDefaults.value(forKey: "countCategoriesSelected") != nil {
            countFavoriteCategoriesSelected = userDefaults.value(forKey: "countCategoriesSelected") as? Int
        }
        
        if userDefaults.value(forKey: "categorySelected") != nil {
            categorySelected = userDefaults.value(forKey: "categorySelected") as! String
        }
    }

    
    
    
    
// MARK: Parse data (url)
    func parseData() {
        var product: MyResp?
        let task = URLSession.shared.dataTask(with: myRequest!) { (data, response, error) in
            guard let dataResponce = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error");
                return }
            
            let json = try? JSONSerialization.jsonObject(with: dataResponce, options: []) as? [String: AnyObject]
            
            if let json = json {
                print(json.description)
            }
                        
            do {
                let decoder = JSONDecoder()
                print(dataResponce)
                
                product = try decoder.decode(MyResp.self, from: dataResponce)
                if product?.status == "ok" {
                    
                    let count = min(19, product?.totalResults ?? 0)

                    
                    
                    for i in 0..<count {
                        self.imagesURLParsed.append(product!.articles[i].urlToImage ?? URL(fileURLWithPath: "nil"))
                        self.titlesParsed.append(product!.articles[i].title ?? "no title")
                        self.contentsParsed.append(product!.articles[i].description ?? "no description")
                        self.authorsParsed.append(product!.articles[i].author ?? "no author")
//                        self.saveNew(product: product!, num: i)
                        
//                        print(product!.articles[i].content)
//                        print(self.contentsParsed.last)
                    }
                    
                    self.countOfArticles += count
                    
                    
                    DispatchQueue.main.async {
                        self.mainPageTableView.reloadData()
                    }
                }
            }
            catch let parsingError {
                print("Error: ", parsingError)
                
                if self.countOfArticles == 0 {
                    if self.noNewsParsedImageView.isHidden {
                            print("Yes")
//                        self.noNewsParsedAnimate()
                        } else {
                        self.noNewsParsedImageView.isHidden = true
                        self.noNewsParsedImageView.frame = CGRect(x: 0, y: -self.view.frame.size.width / 4 * 3, width: self.view.frame.size.width, height: self.view.frame.size.width / 4 * 3)
                            print("No")
                        }
                    }
            }
        }
        
//        print(self.contentsParsed)
        
        task.resume()
    }
    
    func setupNoNewsParsed() {
        //some alert
        noNewsParsedImageView = UIImageView(frame: CGRect(x: 0, y: -view.frame.size.width / 4 * 3, width: view.frame.size.width, height: view.frame.size.width / 4 * 3))
        
        noNewsParsedImageView.contentMode = .scaleAspectFit
        noNewsParsedImageView.image = UIImage(named: "Ooops")
        
        noNewsParsedImageView.isHidden = true
        
        view.addSubview(noNewsParsedImageView)
    }
    
    
    func noNewsParsedAnimate() {
        
        
        if noNewsParsedImageView.isHidden {
            noNewsParsedImageView.isHidden = false
            
            noNewsParsedImageView.frame = CGRect(x: 0, y: -view.frame.size.width / 4 * 3, width: view.frame.size.width, height: view.frame.size.width / 4 * 3)
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.noNewsParsedImageView.center.y += self.view.frame.size.width / 4 * 3 + (self.navigationController?.navigationBar.frame.size.height ?? 0) ?? 0
            }) { (finished) in
                guard finished else {
                    return
                }
                //finished
//                self.menuButton.isUserInteractionEnabled = true
//                self.buttonAccount.isUserInteractionEnabled = true
//                self.buttonAtTheTop.isUserInteractionEnabled = true
                }
        } else {
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.noNewsParsedImageView.center.y -= self.view.frame.size.width / 4 * 3 * 2
            }) { (finished) in
                guard finished else {
                    return
                }
                self.noNewsParsedImageView.isHidden = true
                }
        }
    }
    
// MARK: Save the new to CoreData
    func saveNew(product: MyResp, num: Int) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
//        print(NSEntityDescription.entity(forEntityName: "New", in: delegate.managedObjectContext))
//        print(NSEntityDescription.entity(forEntityName: "ListNews", in: delegate.managedObjectContext))

        if let newEntity = NSEntityDescription.entity(forEntityName: "New", in: delegate.managedObjectContext), let listNewsEntity = NSEntityDescription.entity(forEntityName: "ListNews", in: delegate.managedObjectContext) {
            let new = New(entity: newEntity, insertInto: delegate.managedObjectContext)
            new.title = product.articles[num].title ?? "no title"
            new.urlToImage = product.articles[num].urlToImage ?? URL(fileURLWithPath: "nil")
            new.author = product.articles[num].author ?? "no author"
            
            delegate.saveContext()
        }
    }
    
    
    
    
// MARK:  Get news from CoreData
    func getNew() {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let newsFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "New")
        delegate.managedObjectContext.performAndWait
        {
            do {
                let result = try delegate.managedObjectContext.fetch(newsFetchRequest)
                
                result.forEach
                { (record) in
                    guard let new = record as? New,
                        let author = new.author else {
                        return
                    }
                    let title = new.title
                    let imageURL = new.urlToImage
                    let content = new.content
                    let authorName = new.author
                    
                    self.imagesURLParsed.append(imageURL ?? URL(fileURLWithPath: "nil"))
                    self.titlesParsed.append(title ?? "no title")
                    self.authorsParsed.append(authorName ?? "no author")
                    self.contentsParsed.append(content ?? "no content")
                    self.countOfArticles += 1
                }
            } catch {
                print("CoreData error: \(error.localizedDescription)")
            }
        }
    }
    
    
    
    
//MARK: Menu button
    func setupMenuButton() {
        let navBarFrame: CGRect = (navigationController?.navigationBar.frame ?? nil)!
        menuButton = UIButton(frame: CGRect(x: navBarFrame.size.height / 6, y: navBarFrame.size.height / 2 - navBarFrame.size.height / 3, width: navBarFrame.size.height / 1.3, height: navBarFrame.size.height / 1.3))
        
        menuButton.backgroundColor = .clear
        menuButton.setImage(UIImage(named: ColorPalette.menuButtonImageName), for: .normal)
        menuButton.imageView?.contentMode = .scaleAspectFit
        
        menuButton.addTarget(self, action: #selector(menuButtonPressed), for: .touchUpInside)
    }
    
    @objc func menuButtonPressed() {
        
//        if !UIViewWithPickerView.isHidden {
//            UIViewWithPickerView.alpha = 0
//            UIViewWithPickerView.center.y += 270
//            UIViewWithPickerView.isHidden = true
//        }
        
        myDelegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    
    
    
// MARK: Button at the top
    func createButtonAtTheTop() {
        let navBarFrame: CGRect = navigationController?.navigationBar.frame ?? CGRect(x: 50, y: 50, width: 30, height: 30)
        
        buttonAtTheTop = UIButton(frame: CGRect(x: navBarFrame.size.width / 2 - navBarFrame.size.width / 6, y: navBarFrame.size.height / 2 - navBarFrame.size.height / 6, width: navBarFrame.size.width / 3, height: navBarFrame.size.height / 3))
    }
  
    
    
    
    
    func setButtonAtTheTop(indexCategory: Int) {
        buttonAtTheTop.isHidden = true
        
        buttonAtTheTop.setTitle("", for: .normal)
        buttonAtTheTop.titleLabel?.frame.size.width = buttonAtTheTop.frame.size.width
        buttonAtTheTop.setTitleColor(ColorPalette.textColor, for: .normal)
        buttonAtTheTop.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 20)
        buttonAtTheTop.setTitle(categoriesToChose[indexCategory], for: .normal)
        
        
        buttonAtTheTop.addTarget(self, action: #selector(buttonAtTheTopPressed(_:)), for: .touchUpInside)
        
        buttonAtTheTop.isHidden = false
    }
    
    
    
    
    
    @objc func buttonAtTheTopPressed(_ sender: Any) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonAtTheTopPressed(_:)))
        var flag: Bool = false


        buttonAtTheTop.isUserInteractionEnabled = false
        buttonAccount.isUserInteractionEnabled = false
        
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            if self.UIViewWithPickerView.isHidden {
                self.UIViewWithPickerView.isHidden = false
                self.UIViewWithPickerView.center.y -= 270
                self.UIViewWithPickerView.alpha = 1
                self.pickerViewOnUIView.selectRow(self.currentSelectedCategory, inComponent: 0, animated: true)
                self.mainPageTableView.addGestureRecognizer(tapGesture)
            } else {
                if self.refreshDataButton.isHidden {
                    if self.currentSelectedCategory != self.pickerViewOnUIView.selectedRow(inComponent: 0) {
                        self.currentSelectedCategory = self.pickerViewOnUIView.selectedRow(inComponent: 0)
                        self.refreshDataButtonAnimate()
                    }
                }
                
                self.UIViewWithPickerView.center.y += 270
                self.UIViewWithPickerView.alpha = 0
                flag = true
            }
        }) { (finished) in
            guard finished else {
                return
            }
                        
            if flag {
                self.UIViewWithPickerView.isHidden = true
                self.mainPageTableView.removeGestureRecognizer(self.mainPageTableView.gestureRecognizers!.last!)
                
                self.mainPageTableView.isScrollEnabled = true
            }
            
            self.buttonAccount.isUserInteractionEnabled = !self.buttonAccount.isUserInteractionEnabled
            self.buttonAtTheTop.isUserInteractionEnabled = !self.buttonAtTheTop.isUserInteractionEnabled
            
//            print("finished")
        }
        
    }
  
    
    
    
    
// MARK: Account button
    func createButtonAccount() {
        let navBarFrame: CGRect = (navigationController?.navigationBar.frame ?? nil)!
        buttonAccount = UIButton(frame: CGRect(x: navBarFrame.size.width - (navBarFrame.size.height / 1.3 + navBarFrame.size.height / 6), y: navBarFrame.size.height / 2 - navBarFrame.size.height / 3, width: navBarFrame.size.height / 1.3, height: navBarFrame.size.height / 1.3))
    }
    
    func setButtonAccount() {
        buttonAccount.backgroundColor = .clear
        buttonAccount.setImage(UIImage(named: ColorPalette.buttonAccountImageName), for: .normal)
        buttonAccount.imageView?.contentMode = .scaleAspectFit
        
        buttonAccount.addTarget(self, action: #selector(buttonAccountPressed), for: .touchUpInside)
    }
    
    
    
    

    @objc func buttonAccountPressed() {
        let accountVC = AccountViewController()

        accountVC.categoriesAll = categoriesAll
        accountVC.categoriesSelected = favoriteCategoriesSelected
        accountVC.ColorPalette = ColorPalette
        
        if !UIViewWithPickerView.isHidden {
            if mainPageTableView.gestureRecognizers?.last != nil {
                mainPageTableView.removeGestureRecognizer((mainPageTableView.gestureRecognizers?.last)!)
            }
            UIViewWithPickerView.alpha = 0
            UIViewWithPickerView.center.y += 270
            UIViewWithPickerView.isHidden = true
        }
    
        self.navigationController?.pushViewController(accountVC, animated: true)
        
    }
    
    
    
    
// MARK: Blur Effect On NavBar
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = (self.navigationController?.navigationBar.bounds.insetBy(dx: 0, dy: 0).offsetBy(dx: 0, dy: 0))!
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.addSubview(blurView)
        self.navigationController?.navigationBar.sendSubviewToBack(blurView)
    }

//    func showAccountVC() {
//        navigationController?.pushViewController(account, animated: <#T##Bool#>)
//    }
    
    
    
    
// MARK: Top View (on navBar)
    func setupTopView() {
        let topViewFrame = CGRect(x: 0, y: 0, width: (navigationController?.navigationBar.frame.size.width)!, height: (navigationController?.navigationBar.frame.size.height)!)
        
        topView = UIView(frame: topViewFrame)
        
        createButtonAccount()
        createButtonAtTheTop()
        
        setupMenuButton()
        setButtonAccount()
        setButtonAtTheTop(indexCategory: 1)
        
        topView.addSubview(menuButton)
        topView.addSubview(buttonAccount)
        topView.addSubview(buttonAtTheTop)
    }

    
    

// MARK: TableView
    func setupTableView() {
        let mainPageTableViewFrame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        
        mainPageTableView = UITableView(frame: mainPageTableViewFrame)
        mainPageTableView.layer.zPosition = -1
        
//        print("Frame: ")
//        print(mainPageTableView.frame)
        
        mainPageTableView.register(TableViewCell.self, forCellReuseIdentifier: "TBVCCell")
        
        mainPageTableView.backgroundColor = .clear
        mainPageTableView.separatorStyle = .none
        
        mainPageTableView.rowHeight = view.frame.size.width / 1.25
//        mainPageTableView.cont
        
        mainPageTableView.isUserInteractionEnabled = true
        
        mainPageTableView.delegate = self
        mainPageTableView.dataSource = self
        
        configureRefreshControl()
        
        if #available(iOS 10.0, *) {
            mainPageTableView.refreshControl = refreshControl
        } else {
            mainPageTableView.addSubview(refreshControl)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if countOfArticles != 0 {
//            if !noNewsParsedImageView.isHidden {
//                noNewsParsedImageView.isHidden = true
//                noNewsParsedImageView.frame = CGRect(x: 0, y: -view.frame.size.width / 4 * 3, width: view.frame.size.width, height: view.frame.size.width / 4 * 3)
//                print("No")
//            }
//        }
        
        return countOfArticles
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TBVCCell") as! TableViewCell
        let imgURL = imagesURLParsed[indexPath.row]
        
        cell.selectionStyle = .none
        
        cell.frame.size.width = view.frame.size.width
        cell.frame.size.height = view.frame.size.width / 1.25
        
        //title label
        cell.cellTitleLabel.frame = CGRect(x: 20, y: cell.frame.size.height * 2 / 3, width: cell.frame.size.width - 40, height: (cell.frame.size.height - 20) / 3)
        cell.cellTitleLabel.layer.zPosition = 10
        cell.cellTitleLabel.numberOfLines = 2
        cell.cellTitleLabel.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        cell.cellTitleLabel.textColor = UIColor.white
        cell.cellTitleLabel.font = UIFont(name: "Helvetica Neue", size: 34)
        cell.cellTitleLabel.text = titlesParsed[indexPath.row]
        
        //height = width / 1.22
        cell.cellImageView.frame = CGRect(x: (cell.frame.size.width - cell.frame.size.width / 1.05) / 2, y: (cell.frame.size.width - cell.frame.size.width / 1.05) / 2, width: cell.frame.size.width / 1.05, height: cell.frame.size.width / 1.3)
        
//        print(cell.frame.size.width)
        
        //activity indicator
        cell.cellActivityIndicatorView.frame = CGRect(x: cell.frame.size.width / 2 - 20, y: cell.frame.size.height / 2 - 20, width: 40, height: 40)
        cell.cellActivityIndicatorView.layer.zPosition = 10
        
        cell.cellActivityIndicatorView.style = .gray
        cell.cellActivityIndicatorView.isHidden = true
        
        
        cell.cellActivityIndicatorView.isHidden = false
        cell.cellActivityIndicatorView.startAnimating()
        
        var flagImageReceived: Bool = false
        
        // TODO: use urlsession
        //getting the image
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imgURL) {
                if let image = UIImage(data: data) {
                    cell.cellImageView.image = image

                    flagImageReceived = true

                    let gradient = CAGradientLayer()
                    gradient.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: cell.cellImageView.frame.size.width, height: cell.cellImageView.frame.size.height))
                    gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
                    gradient.locations = [0.5, 1]

                    cell.cellImageView.layer.sublayers?.removeAll()
                    cell.cellImageView.layer.addSublayer(gradient)

                    cell.cellActivityIndicatorView.stopAnimating()
                    cell.cellActivityIndicatorView.isHidden = true
                }
            } else {
                //invalid url
            }
            
            cell.cellActivityIndicatorView.stopAnimating()
            cell.cellActivityIndicatorView.isHidden = true
        }
        
        cell.cellImageView.backgroundColor = .lightGray
        cell.cellImageView.contentMode = UIView.ContentMode.scaleAspectFill
        cell.cellImageView.clipsToBounds = true
        cell.cellImageView.layer.cornerRadius = 20
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        let nextVC = CardOfANewViewController()

        nextVC.titleOfTheNew = titlesParsed[indexPath.row]
        nextVC.imageOfTheNewURL = imagesURLParsed[indexPath.row]
        nextVC.textNew = contentsParsed[indexPath.row]
        nextVC.authorName = authorsParsed[indexPath.row]
        nextVC.flagShowSaveButton = true
        
//        print(imagesURLParsed[indexPath.row])
                
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshDataButtonPressed), for: .valueChanged)
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let addToLiked = UITableViewRowAction(style: .default, title: "") { (action, indexPath) in
//
//        }
//
//        let likeView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: view.frame.size.width / 1.25))
//        likeView.backgroundColor = .white
//
//        let likeImageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: view.frame.size.width / 1.25 / 2 - 15, width: 30, height: 30))
//        likeImageView.image = UIImage(named: "Like no")
//
//        likeView.addSubview(likeImageView)
//
//        UIGraphicsBeginImageContextWithOptions(CGSize(width: 30, height: view.frame.size.width / 1.25), true, 0)
//        let context = UIGraphicsGetCurrentContext()
//        likeView.layer.render(in: context!)
//        let likeViewImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//
//        addToLiked.backgroundColor = UIColor(patternImage: likeViewImage!)
//
//        return [addToLiked]
//    }

    
    
    
// MARK: PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        categoriesToChose.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoriesToChose[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        setButtonAtTheTop(indexCategory: row)
    }

    func createUIViewWithPickerView() {
        
        let rectForView = CGRect(x: 0, y: view.frame.size.height, width: view.frame.size.width, height: 300)
        let rectForPicker = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 270)
        
        UIViewWithPickerView = UIView(frame: rectForView)
        UIViewWithPickerView.layer.zPosition = 5
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
        pickerViewOnUIView.layer.zPosition = 5
        
        pickerViewOnUIView.dataSource = self
        pickerViewOnUIView.delegate = self
        
        pickerViewOnUIView.isHidden = false
        pickerViewOnUIView.alpha = 1
        
        pickerViewOnUIView.selectRow(currentSelectedCategory, inComponent: 0, animated: false)
        
        UIViewWithPickerView.addSubview(pickerViewOnUIView)
                
        view.addSubview(UIViewWithPickerView)
    }
    
    
    
//MARK: Refresh data button
    func setupRefreshDataButton() {
        let refreshDataButtonFrame: CGRect = CGRect(x: -view.frame.size.width / 2 - 50, y: view.frame.size.height / 7.5, width: 100, height: 36)
        
        print(view.frame.size.height / 7.5)
        
        refreshDataButton = UIButton(frame: refreshDataButtonFrame)
        
        refreshDataButton.addTarget(self, action: #selector(refreshDataButtonPressed), for: .touchUpInside)
        
        refreshDataButton.clipsToBounds = true
        refreshDataButton.layer.cornerRadius = 18
        refreshDataButton.layer.zPosition = 20
        refreshDataButton.backgroundColor = UIColor(displayP3Red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        
        refreshDataButton.isHidden = true
        
        refreshImageView = UIImageView(frame: CGRect(x: 3, y: 3, width: 30, height: 30))
        refreshImageView.backgroundColor = .none
        refreshImageView.contentMode = .scaleAspectFit
        refreshImageView.image = UIImage(named: "Refresh")
        
        refreshLabel = UILabel(frame: CGRect(x: 38, y: 0, width: 62, height: 36))
        refreshLabel.text = "Refresh"
        refreshLabel.font = UIFont(name: "Helvetica Neue", size: 16)
        
        refreshDataButton.addSubview(refreshImageView)
        refreshDataButton.addSubview(refreshLabel)
        
        view.addSubview(refreshDataButton)
    }
    
    func refreshDataButtonAnimate() {
        refreshDataButton.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            self.refreshDataButton.center.x += self.view.frame.size.width
        }) { (finished) in
            guard finished else {
                return
            }
            
            //animation finished
        }
    }
    
    @objc func refreshDataButtonPressed() {
        //parse news with new url
        
        noNewsParsedImageView.isHidden = true
        noNewsParsedImageView.frame = CGRect(x: 0, y: -view.frame.size.width / 4 * 3, width: view.frame.size.width, height: view.frame.size.width / 4 * 3)
        
        currentSelectedCategory = pickerViewOnUIView.selectedRow(inComponent: 0)
        
        readUserDefaults()
        
        self.imagesURLParsed.removeAll()
        self.titlesParsed.removeAll()
        self.contentsParsed.removeAll()
        self.authorsParsed.removeAll()
        self.countOfArticles = 0
        if refreshDataButton.isHidden {
            
            //refresh data
            
            if currentSelectedCategory == 0 {
                
                DispatchQueue.main.async {
                    for i in 0...8 {
                        if self.favoriteCategoriesSelected[i] {
                            self.myRequest = self.urlDict[self.myDict[i + 1]!]
                            self.parseData()
                        }
                    }
                    
                    self.mainPageTableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
                
                return
            }
            
            myRequest = urlDict[myDict[currentSelectedCategory]!]
            
            self.parseData()
            self.mainPageTableView.reloadData()
            self.refreshControl.endRefreshing()
            
            return
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.refreshDataButton.center.x -= self.view.frame.size.width
        }) { (finished) in
            guard finished else {
                return
            }
            
//            if !self.noNewsParsedImageView.isHidden {
//                self.noNewsParsedAnimate()
//            }
    
            self.refreshDataButton.isHidden = true
            
            //refresh data
            
            if self.currentSelectedCategory == 0 {
                
                DispatchQueue.main.async {
                    for i in 0...8 {
                        if self.favoriteCategoriesSelected[i] {
                            self.myRequest = self.urlDict[self.myDict[i + 1]!]
                            self.parseData()
                        }
                    }
                    
                    self.mainPageTableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
                
                return
            }
            
            self.myRequest = self.urlDict[self.myDict[self.currentSelectedCategory]!]
            
            self.parseData()
            self.mainPageTableView.reloadData()
            self.refreshControl.endRefreshing()
            //animation finished
        }
    }
    
    
    
    
//MARK: Saved news
    @objc func savedNewsButtonPressed() {
        let savedNewsVC = SavedNews()
        
        if !UIViewWithPickerView.isHidden {
            if mainPageTableView.gestureRecognizers?.last != nil {
                mainPageTableView.removeGestureRecognizer((mainPageTableView.gestureRecognizers?.last)!)
            }
            UIViewWithPickerView.alpha = 0
            UIViewWithPickerView.center.y += 270
            UIViewWithPickerView.isHidden = true
        }
        
        self.navigationController?.pushViewController(savedNewsVC, animated: true)
    }
    
    
    
    
//MARK: Helpful functions
    override func viewDidAppear(_ animated: Bool) {
        print("Func: viewDidAppear. Notifies the view controller that its view was added to a view hierarchy.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Func: viewWillAppear. otifies the view controller that its view is about to be added to a view hierarchy.")
        buttonAtTheTop.isHidden = false
        buttonAccount.isHidden = false
        topView.isHidden = false
        UIViewWithPickerView.isHidden = true
        
        buttonAccount.isUserInteractionEnabled = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("Func: viewDidDisappear. Notifies the view controller that its view was removed from a view hierarchy.")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("Func: viewWillDissappear. Notifies the view controller that its view is about to be removed from a view hierarchy.")
        buttonAtTheTop.isHidden = true
        buttonAccount.isHidden = true
        topView.isHidden = true
        UIViewWithPickerView.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        print("Func: viewDidLayoutSubviews. Called to notify the view controller that its view has just laid out its subviews.")
    }
    
    override func viewWillLayoutSubviews() {
        print("Func: viewWillLayoutSubviews. Called to notify the view controller that its view is about to layout its subviews.")
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let currentOffset: CGPoint = scrollView.contentOffset
//
//        if lastContentOffset != nil {
//            if currentOffset.y != lastContentOffset.y && abs(reloadDataButton.alpha - 0.3) > 0.01 && !reloadDataButton.isHidden {
//                reloadDataButtonAnimate()
//            } else {
//                if currentOffset.y == lastContentOffset.y && abs(reloadDataButton.alpha - 0.3) < 0.01 && !reloadDataButton.isHidden {
//                    reloadDataButtonAnimate()
//                }
//            }
//        }
//
//        lastContentOffset = currentOffset
//    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//
//        if abs(reloadDataButton.alpha - 0.3) < 0.01 && !reloadDataButton.isHidden {
//            reloadDataButtonAnimate()
//        }
//
//    }
    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if reloadDataButton.alpha == 0.3 && !reloadDataButton.isHidden {
//            reloadDataButtonAnimate()
//        }
//    }
    
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//
//        if !reloadDataButton.isHidden {
//            UIView.animate(withDuration: 0.1, animations: {
//                self.reloadDataButton.alpha = 0.3
//            }) { (finished) in
//                guard finished else {
//                    return
//                }
//            }
//        }
//    }

}

