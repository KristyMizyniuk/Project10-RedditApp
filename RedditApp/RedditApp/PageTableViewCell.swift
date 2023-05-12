//
//  PageTableViewCell.swift
//  RedditApp
//
//  Created by Христина Мізинюк on 23.04.2023.
//

import UIKit

class PageTableViewCell: UITableViewCell  {
    var delegate: ViewControlerDelegate?
    
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var pageText: UILabel!
    @IBOutlet weak var numberOfComments: UILabel!
    @IBOutlet var content: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            content.isUserInteractionEnabled = true
            content.addGestureRecognizer(tapGestureRecognizer)
        }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
    
        delegate?.showDetailViewController(viewController: vc)
        vc.showImage(imageView: content)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
