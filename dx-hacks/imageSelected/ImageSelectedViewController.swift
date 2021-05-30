//
//  ImageSelectedViewController.swift
//  dx-hacks
//
//  Created by 山田楓也 on 2021/05/30.
//

import UIKit

class ImageSelectedViewController: UIViewController {
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var shareButton: UIButton! {
        didSet {
            shareButton.addTarget(self, action: #selector(shareAction), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var selectedImageButton: UIButton! {
        didSet {
            selectedImageButton.addTarget(self, action: #selector(selectedImage), for: .touchUpInside)
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func shareAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func selectedImage() {
        setImage()
    }
}

// MARK: - Image Picker

extension ImageSelectedViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func setImage() {
        let pickerController = UIImagePickerController()
        //PhotoLibraryから画像を選択
        pickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        //デリゲートを設定する
        pickerController.delegate = self
        //ピッカーを表示する
        present(pickerController, animated: true, completion: nil)
    }
    
    // 画像が選択された時に呼ばれる.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        //選択された画像を取得.
        if let myImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageView.image = myImage
        }
    }
}
