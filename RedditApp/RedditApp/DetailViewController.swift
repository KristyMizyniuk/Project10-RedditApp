////
////  DetailViewController.swift
////  RedditApp
////
////  Created by Христина Мізинюк on 26.04.2023.
////
//
import UIKit
import SnapKit

class DetailViewController: UIViewController {
    @IBOutlet var detailImageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func showImage(imageView: UIImageView) {
        detailImageView.image = imageView.image
    }
    
    class NotificationView: UIView {
        private let label = UILabel()
        
        init(message: String) {
            super.init(frame: .zero)
            backgroundColor = .lightGray
            layer.cornerRadius = 8
            layer.masksToBounds = true
            
            label.text = message
            label.textAlignment = .center
            label.numberOfLines = 0
            label.textColor = .white
            addSubview(label)
            
            label.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-10)
                make.leading.equalToSuperview().offset(15)
                make.trailing.equalToSuperview().offset(-15)
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if let image = detailImageView.image {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error != nil {
            let notificationView = NotificationView(message: "Failed to save image ❌")
            view.addSubview(notificationView)
            
            notificationView.snp.makeConstraints { make in
                make.centerX.equalTo(view.snp.centerX)
                make.verticalEdges.equalTo(view.snp.verticalEdges)
                make.width.equalToSuperview().multipliedBy(0.8)
            }
            
            UIView.animate(withDuration: 0.3, delay: 2.0, options: [], animations: {
                notificationView.alpha = 0
            }, completion: { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    notificationView.removeFromSuperview()
                }
            })
        } else {
            let notificationView = NotificationView(message: "Image saved 📥")
            view.addSubview(notificationView)
            
            notificationView.snp.makeConstraints { make in
                make.centerX.equalTo(view.snp.centerX)
                make.directionalVerticalEdges.greaterThanOrEqualTo(view.snp.directionalVerticalEdges)
                make.height.equalTo(200)
                make.width.equalTo(view.snp.width).multipliedBy(0.8)
                
            
            }
            
            UIView.animate(withDuration: 0.3, delay: 2.0, options: [], animations: {
                notificationView.alpha = 0
            }, completion: { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    notificationView.removeFromSuperview()
                }
            })
        }
    }
}
