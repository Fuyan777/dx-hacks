//
//  ImageShareViewController.swift
//  dx-hacks
//
//  Created by 山田楓也 on 2021/05/29.
//

import UIKit

class ImageShareViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shareImageVIew: UIImageView!
    
    let image: UIImage!
    let textString: String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareImageVIew.image = image
        titleLabel.text = textString
    }
    
    init(
        imageData: UIImage,
        text: String
    ) {
        image = imageData
        textString = text
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
