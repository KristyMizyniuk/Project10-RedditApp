//
//  ViewController.swift
//  RedditApp
//
//  Created by Христина Мізинюк on 23.04.2023.
//

import UIKit
import SnapKit

protocol ViewControlerDelegate {
    func showDetailViewController(viewController: DetailViewController)
}
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ViewControlerDelegate {
    
    
    func showDetailViewController(viewController: DetailViewController) {
        self.present(viewController, animated: true)
        
    }
    
    var pageModel: Reddit?
    @IBOutlet var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PageTableViewCell") as! PageTableViewCell
        cell.delegate = self
        
        if let numComments = pageModel?.data.children[indexPath.row].data.numComments {
            cell.numberOfComments.text = "\(numComments)"
        } else {
            cell.numberOfComments.text = ""
        }
        if let pageText = pageModel?.data.children[indexPath.row].data.title {
            cell.pageText.text = pageText
        } else {
            cell.pageText.text = ""
        }
        if let userName = pageModel?.data.children[indexPath.row].data.subredditNamePrefixed {
            cell.userName.text = userName
            
        } else {
            cell.userName.text = ""
        }
            cell.hours.text = "3d"
        
        if let imageUrl = URL(string: pageModel?.data.children[indexPath.row].data.url ?? "") {
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let imageData = try Data(contentsOf: imageUrl)
                    DispatchQueue.main.async {
                        cell.content.image = UIImage(data: imageData)
                    }
                } catch {
                    print("Error loading image from URL: \(imageUrl.absoluteString)")
                }
            }
        } else {
            
            cell.content.image = nil
        }
        
        return cell
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.register(UINib(nibName: "PageTableViewCell", bundle: nil), forCellReuseIdentifier: "PageTableViewCell")
        self.tableView.dataSource = self
        self.tableView.delegate   = self
        
        
        let urlString = "https://www.reddit.com/top.json"
        self.loadJson(fromURLString: urlString) { (result) in
            switch result {
            case .success(let data):
                self.pageModel = self.parse(jsonData: data)
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    private func parse(jsonData: Data) -> Reddit {
        do {
            let decodedData = try JSONDecoder().decode(Reddit.self,
                                                       from: jsonData)
            return decodedData
        } catch {
            print("decode error:\(error)")
        }
        return Reddit(data: RedditData(children: []))
    }
    
    private func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            urlSession.resume()
        }
    }
}

