//
//  AnimatedLabel.swift
//  BoardBuddy
//
//  Created by Francisco Diarte on 5/15/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

enum CountingMethod {
    case easeInOut, easeIn, easeOut, linear
}

enum AnimationDuration {
    case laborious, plodding, strolling, brisk, instant
    
    var value: Double {
        switch self {
        case .laborious: return 20.0
        case .plodding: return 15.0
        case .strolling: return 7.0
        case .brisk: return 2.0
        case .instant: return 0.0
        }
    }
}

enum DecimalPoints {
    case zero, one, two
    
    var format: String {
        switch self {
        case .zero: return "%.0f"
        case .one: return "%.1f"
        case .two: return "%.2f"
        }
    }
}

typealias OptionalCallback = (() -> Void)
typealias OptionalFormatBlock = (() -> String)

class AnimatedLabel: UILabel {
    
    var animationDuration = AnimationDuration.strolling
    var decimalPoints = DecimalPoints.zero
    var countingMethod = CountingMethod.easeInOut
    var completion: OptionalCallback?
    var customFormatBlock: OptionalFormatBlock?
    
    fileprivate var rate: Float = 0
    fileprivate var startingValue: Float = 0
    fileprivate var destinationValue: Float = 0
    fileprivate var progress: TimeInterval = 0
    fileprivate var lastUpdate: TimeInterval = 0
    fileprivate var totalTime: TimeInterval = 0
    fileprivate var easingRate: Float = 0
    fileprivate var timer: CADisplayLink?
    
    
    fileprivate var currentValue: Float {
        if progress >= totalTime { return destinationValue }
        return startingValue + (update(t: Float(progress / totalTime)) * (destinationValue - startingValue))
    }
    
    
    func count(from: Float, to: Float, duration: TimeInterval? = nil) {
        startingValue = from
        destinationValue = to
        timer?.invalidate()
        timer = nil
        
        if (duration == 0.0) {
            // No animation
            setTextValue(value: to)
            completion?()
            return
        }
        
        easingRate = 3.0
        progress = 0.0
        totalTime = duration ?? animationDuration.value
        lastUpdate = Date.timeIntervalSinceReferenceDate
        rate = 3.0
        
        addDisplayLink()
    }
    
    func countFromCurrent(to: Float, duration: TimeInterval? = nil) {
        count(from: currentValue, to: to, duration: duration ?? nil)
    }
    
    func countFromZero(to: Float, duration: TimeInterval? = nil) {
        count(from: 0, to: to, duration: duration ?? nil)
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        progress = totalTime
        completion?()
    }
    
    fileprivate func addDisplayLink() {
        timer = CADisplayLink(target: self, selector: #selector(self.updateValue(timer:)))
        timer?.add(to: .main, forMode: .defaultRunLoopMode)
        timer?.add(to: .main, forMode: .UITrackingRunLoopMode)
    }
    
    fileprivate func update(t: Float) -> Float {
        var t = t
        
        switch countingMethod {
        case .linear:
            return t
        case .easeIn:
            return powf(t, rate)
        case .easeInOut:
            var sign: Float = 1
            if Int(rate) % 2 == 0 { sign = -1 }
            t *= 2
            return t < 1 ? 0.5 * powf(t, rate) : (sign*0.5) * (powf(t-2, rate) + sign*2)
        case .easeOut:
            return 1.0-powf((1.0-t), rate);
        }
    }
    
    @objc fileprivate func updateValue(timer: Timer) {
        let now: TimeInterval = Date.timeIntervalSinceReferenceDate
        progress += now - lastUpdate
        lastUpdate = now
        
        if progress >= totalTime {
            self.timer?.invalidate()
            self.timer = nil
            progress = totalTime
        }
        
        setTextValue(value: currentValue)
        if progress == totalTime { completion?() }
    }
    
    fileprivate func setTextValue(value: Float) {
        let intVersion = Int(value)
        //        text = String(format: customFormatBlock?() ?? decimalPoints.format, value)
        text = "$ \(intVersion)"
    }
}
