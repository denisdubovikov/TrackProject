//
//  SavedNews.swift
//  TrackProject
//
//  Created by Денис Дубовиков on 04/12/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//

import UIKit
import CoreData

class SavedNews: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var savedNewsTableView: UITableView!
    
    var countOfArticlesSaved = 0
    var imagesURLSaved: [URL] = []
    var titlesSaved: [String] = []
    var contentsSaved: [String] = []
    var authorsSaved: [String] = []
    
    var titlesSavedDuplicates: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
             view.backgroundColor = .white
        }
        
        deleteDuplicates()
        
        getNew()
        
        setupTableView()
        view.addSubview(savedNewsTableView)

        // Do any additional setup after loading the view.
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
                    guard let new = record as? New else {
                        return
                    }
                    
                    let title = new.title
                    let imageURL = new.urlToImage
                    let content = new.content
                    let authorName = new.author
                    
                    self.imagesURLSaved.append(imageURL ?? URL(fileURLWithPath: "nil"))
                    self.titlesSaved.append(title ?? "no title")
                    self.authorsSaved.append(authorName ?? "no author")
                    self.contentsSaved.append(content ?? "no content")
                    self.countOfArticlesSaved += 1
                }
            } catch {
                print("CoreData error: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteDuplicates() {
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
                    
                    var flag: Bool = false
                    
                    for i in 0..<self.titlesSavedDuplicates.count {
                        if title == self.titlesSavedDuplicates[i] {
                            flag = true
                        }
                    }
                    
                    if !flag {
                        self.titlesSavedDuplicates.append(title ?? "no title")
                    } else {
                        delegate.managedObjectContext.delete(new)
                    }
                    
                }
            } catch {
                print("CoreData error: \(error.localizedDescription)")
            }
        }
    }
    
    
    
//MARK: Table view
    func setupTableView() {
            let mainPageTableViewFrame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            
            savedNewsTableView = UITableView(frame: mainPageTableViewFrame)
            savedNewsTableView.layer.zPosition = -1
            
    //        print("Frame: ")
    //        print(mainPageTableView.frame)
            
            savedNewsTableView.register(TableViewCell.self, forCellReuseIdentifier: "TBVCCell")
            
            savedNewsTableView.backgroundColor = .clear
            savedNewsTableView.separatorStyle = .none
            
            savedNewsTableView.rowHeight = view.frame.size.width / 1.25
    //        savedNewsTableView.cont
            
            savedNewsTableView.isUserInteractionEnabled = true
            
            savedNewsTableView.delegate = self
            savedNewsTableView.dataSource = self
            
//            configureRefreshControl()
//
//            if #available(iOS 10.0, *) {
//                mainPageTableView.refreshControl = refreshControl
//            } else {
//                mainPageTableView.addSubview(refreshControl)
//            }
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
            
            return countOfArticlesSaved
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TBVCCell") as! TableViewCell
            let imgURL = imagesURLSaved[indexPath.row]
            
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
            cell.cellTitleLabel.text = titlesSaved[indexPath.row]
            
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
            
            //getting the image
            DispatchQueue.global().async {
    //            let newURLString = "http://api.resmush.it/ws.php?img=" + imgURL.absoluteString + "&qlty=50"
    //            let newURL:URL = URL(string: "http://api.resmush.it/ws.php?img=" + imgURL.absoluteString + "&qlty=50")!
    //
    //            var imageProduct: responseCompressedImage?
    //
    //            let task = URLSession.shared.dataTask(with: newURL) { (data, response, error) in
    //                        guard let dataResponce = data, error == nil else {
    //                            print(error?.localizedDescription ?? "Response Error");
    //                            return }
    //                        do {
    //                            print(dataResponce)
    //                            let decoder = JSONDecoder()
    //
    //                            imageProduct = try decoder.decode(responseCompressedImage.self, from: dataResponce)
    //
    //                            }
    //
    //                        catch let parsingError {
    //                            print("Error: ", parsingError)
    //                        }
    //                    }
    //
    //            task.resume()
                
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

            nextVC.titleOfTheNew = titlesSaved[indexPath.row]
            nextVC.imageOfTheNewURL = imagesURLSaved[indexPath.row]
            nextVC.textNew = contentsSaved[indexPath.row]
            nextVC.authorName = authorsSaved[indexPath.row]
            nextVC.flagShowSaveButton = false
            
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
    

    

}
