//
//  MagneticComponent.swift
//  CalculateHeading
//
//  Created by Nazmi Yavuz on 23.06.2021.
//

import Foundation

struct MagneticComponent {
    
    // MARK: - Properties
    
    // properties for entring
    let aircraft: Component
    let wind: Component
    
    //calculated properties
    var groundSpeed: Int {
        return calculateGroundSpeed()
    }
    
    var magneticHeading: Int {
        return calculateMagneticHeading()
    }
    
    // MARK: - Private Properties
    private let fromDirection = Double.pi / 180
    private let toDirection = 180 / Double.pi
    
    // MARK: - Functions
    
    private func calculateGroundSpeed() -> Int {
        
        let difference = aircraft.direction - wind.direction
        
        let groundSpeed = (-1 * wind.velocity * cos(difference * fromDirection)) + aircraft.velocity
        
        return Int(round(groundSpeed))
    }
    
    private func calculateMagneticHeading() -> Int {
        
        let difference = aircraft.direction - wind.direction
        
        let relativeWindVelocity = (-1 * sin(difference * fromDirection)) * wind.velocity
        
        let tanAlpha = relativeWindVelocity / Double(groundSpeed)
        
        let alpha = atan(tanAlpha) * toDirection
        
        let heading = alpha + aircraft.direction
        
        return Int(round(heading))
    }
    
}
