//
//  ViewController.swift
//  dx-hacks
//
//  Created by 山田楓也 on 2021/05/29.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton! {
        didSet {
            actionButton.addTarget(self, action: #selector(tappedAction), for: .touchUpInside)
        }
    }
    @IBOutlet weak var selectedImageButton: UIButton! {
        didSet {
            selectedImageButton.addTarget(self, action: #selector(shareAction), for: .touchUpInside)
        }
    }
    
    var isTapped = false
    let motionManager = CMMotionManager()
    let motionWriter = MotionWriter()
    let model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.testGetRecord()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @objc func tappedAction() {
        if isTapped {
            // ストップ
            isTapped = false
            
            titleLabel.text = "モーションブレイク\nはじめよう！"
            actionButton.setImage(UIImage(named: "start_button"), for: .normal)
            motionManager.stopDeviceMotionUpdates()
        } else {
            // スタート発火
            isTapped = true
            
            titleLabel.text = "モーション送信中..."
            actionButton.setImage(UIImage(named: "stop_button"), for: .normal)
            
            // motion開始
            startMotion()
        }
    }
    
    @objc func shareAction() {
        // imageSelectedVCへの画面遷移
        let imageSelected = ImageSelectedViewController()
        self.present(imageSelected, animated: true, completion: nil)
    }
    
    func startMotion() {
        motionManager.deviceMotionUpdateInterval = 1 / 100

        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: { (motion, error) in
            guard let motion = motion, error == nil else { return }
            
            // gyro
//            print("attitude pitch: \(motion.attitude.pitch * 180 / Double.pi)")
//            print("attitude roll : \(motion.attitude.roll * 180 / Double.pi)")
//            print("attitude yaw  : \(motion.attitude.yaw * 180 / Double.pi)")
//            let sensorPitch = motion.attitude.pitch * 180 / Double.pi
//            let sensorRoll = motion.attitude.roll * 180 / Double.pi
//            let sensorYaw = motion.attitude.yaw * 180 / Double.pi
            
            // motion
//            print("attitude x: \(motion.userAcceleration.x)")
//            print("attitude y : \(motion.userAcceleration.y)")
            print("attitude z  : \(motion.userAcceleration.z)")
            
            let sensorX = motion.userAcceleration.x
            let sensorY = motion.userAcceleration.y
            let sensorZ = motion.userAcceleration.z
            
            /*
             x: 水平
             y: 垂直
             z: 奥行き
             */
            let thresholdX = 0.6
            let thresholdY = -0.8
            let thresholdZ = -1.0
            
            // 基本動作
//            if sensorX > thresholdX {
//                self.moveImageShareYaw()
//            } else if sensorY < thresholdY {
//                self.moveImageShareRoll()
//            }
            
            // 押し出す動作
            if sensorZ < thresholdZ {
                self.moveImageShareYaw()
            }
            
            // ハート型（WIP）
            if sensorY < thresholdY {
                if sensorX > thresholdX {
                    self.moveImageShareLove()
                }
            }
        })
    }
    
    // 写真共有の際の画面遷移(Yaw)
    func moveImageShareYaw() {
        motionManager.stopDeviceMotionUpdates()
        model.testGetRecord()
        isTapped = false
        
        // imageShareVCへの画面遷移
        let imageShareVC = ImageShareViewController(
            imageData: UIImage(named: "image") ?? UIImage(),
            text: "自慢の娘！"
        )
        imageShareVC.presentationController?.delegate = self
        self.present(imageShareVC, animated: true, completion: nil)
    }
    
    // 写真共有の際の画面遷移(Roll)
    func moveImageShareRoll() {
        motionManager.stopDeviceMotionUpdates()
        model.testGetRecord()
        isTapped = false
        
        // imageShareVCへの画面遷移（Roll）
        let imageShareVC = ImageShareViewController(
            imageData: UIImage(named: "wanko") ?? UIImage(),
            text: "うちのワンチャン"
        )
        imageShareVC.presentationController?.delegate = self
        self.present(imageShareVC, animated: true, completion: nil)
    }

    // 写真共有の際の画面遷移(Roll)
    func moveImageShareLove() {
        motionManager.stopDeviceMotionUpdates()
        isTapped = false
        
        // imageShareVCへの画面遷移（Roll）
        let imageShareVC = ImageShareViewController(
            imageData: UIImage(named: "love") ?? UIImage(),
            text: "ラブ"
        )
        imageShareVC.presentationController?.delegate = self
        self.present(imageShareVC, animated: true, completion: nil)
    }
}

// MARK: - delegate

extension ViewController: UIAdaptivePresentationControllerDelegate {
    // dismissで戻ってきた際の処理
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        isTapped = false
        titleLabel.text = "モーションブレイク\nはじめよう！"
        actionButton.setImage(UIImage(named: "start_button"), for: .normal)
    }
}
