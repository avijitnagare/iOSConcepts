//
//  Car.swift
//  iOSConcepts
//
//  Created by Avijit Nagare on 24/04/19.
//  Copyright © 2019 Avijit Nagare. All rights reserved.
//

import Foundation

class Car {
    
    var miles = 0
    var type: CarType
    var transmissionMode: CarTransmissionMode
    
    init(type: CarType, transmission:CarTransmissionMode) {
        self.type = type
        self.transmissionMode=transmission
    }
    
    func start(minute:Int) {
        var speed = 0
        if self.type == .Economy && self.transmissionMode == .Drive {
            speed = 35
        }
        
        if self.type == .OffRoad && self.transmissionMode == .Drive {
            speed = 50
        }
        
        if self.type == .Sport && self.transmissionMode == .Drive {
            speed = 70
        }
        
        self.miles = speed * (minute/60)
    }
    
    
    func foo() -> Bool {
        return true
    }
    
    
    
}

enum CarType {
    case Economy
    case OffRoad
    case Sport
}

enum CarTransmissionMode {
    case Park
    case Reverse
    case Neutral
    case Drive
}
