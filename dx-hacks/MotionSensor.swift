//
//  MotionSensor.swift
//  dx-hacks
//
//  Created by 山田楓也 on 2021/05/29.
//

import Foundation
import CoreMotion

class SensorManager: NSObject, ObservableObject {
    @Published var isStarted = false
    
    // motion property
    @Published var xMotionStr = "0.0"
    @Published var yMotionStr = "0.0"
    @Published var zMotionStr = "0.0"
    
    // Gyro property
    @Published var xGyroStr = "0.0"
    @Published var yGyroStr = "0.0"
    @Published var zGyroStr = "0.0"
    
    // magnet property
    @Published var xMagnetoStr = "0.0"
    @Published var yMagnetoStr = "0.0"
    @Published var zMagnetoStr = "0.0"
    
    let motionManager = CMMotionManager()
    
    func stop() {
        isStarted = false
        motionManager.stopDeviceMotionUpdates()
        motionManager.stopGyroUpdates()
        motionManager.stopMagnetometerUpdates()
    }
    
    // MARK: Motion
    
    func startMotion() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: { motionData, error in
                self.updateMotionData(deviceMotion: motionData!)
            })
        }
        
        isStarted = true
    }
    
    // motion - 単位はG
    private func updateMotionData(deviceMotion: CMDeviceMotion) {
        xMotionStr = String(deviceMotion.userAcceleration.x)
        yMotionStr = String(deviceMotion.userAcceleration.y)
        zMotionStr = String(deviceMotion.userAcceleration.z)
    }
    
    // MARK: Gyro
    
    func startGyro() {
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.1
            motionManager.startGyroUpdates(to: OperationQueue.current!, withHandler: { gyroData, error in
                self.updateGyroData(deviceGyro: gyroData!)
            })
        }
        
        isStarted = true
    }
    
    // Gyro - 単位は
    private func updateGyroData(deviceGyro: CMGyroData) {
        xGyroStr = String(deviceGyro.rotationRate.x)
        yGyroStr = String(deviceGyro.rotationRate.y)
        zGyroStr = String(deviceGyro.rotationRate.z)
    }
    
    // MARK: Magneto
    
    func startMagnet() {
        if motionManager.isMagnetometerAvailable {
            motionManager.magnetometerUpdateInterval = 0.1
            motionManager.startMagnetometerUpdates(to: OperationQueue.current!, withHandler: { magnetoData, error in
                self.updateMagnetData(deviceMagneto: magnetoData!)
            })
        }
        
        isStarted = true
    }
    
    private func updateMagnetData(deviceMagneto: CMMagnetometerData) {
        xMagnetoStr = String(deviceMagneto.magneticField.x)
        yMagnetoStr = String(deviceMagneto.magneticField.y)
        zMagnetoStr = String(deviceMagneto.magneticField.z)
    }
}
