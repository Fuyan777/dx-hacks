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
    
    var isTapped = false
    let motionManager = CMMotionManager()
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
            
            titleLabel.text = "モーションブレイク"
            actionButton.setTitle("START", for: .normal)
            motionManager.stopDeviceMotionUpdates()
        } else {
            // スタート発火
            isTapped = true
            
            titleLabel.text = "モーション！！！"
            actionButton.setTitle("STOP", for: .normal)
            
            // motion開始
            startMotion()
        }
    }
    
    func startMotion() {
        motionManager.deviceMotionUpdateInterval = 1 / 100

        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: { (motion, error) in
            guard let motion = motion, error == nil else { return }

            print("attitude pitch: \(motion.attitude.pitch * 180 / Double.pi)")
            print("attitude roll : \(motion.attitude.roll * 180 / Double.pi)")
            print("attitude yaw  : \(motion.attitude.yaw * 180 / Double.pi)")
            let sensorPitch = motion.attitude.pitch * 180 / Double.pi
            let sensorRoll = motion.attitude.roll * 180 / Double.pi
            let sensorYaw = motion.attitude.yaw * 180 / Double.pi
            
            if sensorYaw < -100 {
                self.moveImageShareYaw()
            } else if sensorRoll < -100 {
                self.moveImageShareRoll()
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
}

// MARK: - delegate

extension ViewController: UIAdaptivePresentationControllerDelegate {
    // dismissで戻ってきた際の処理
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        isTapped = false
        titleLabel.text = "モーションブレイク"
        actionButton.setTitle("START", for: .normal)
    }
}
