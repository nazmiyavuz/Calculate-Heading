//
//  ViewController.swift
//  CalculateHeading
//
//  Created by Nazmi Yavuz on 23.06.2021.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - UIViews
    
    @IBOutlet weak var aircraftDirection: UITextField!
    @IBOutlet weak var aircraftVelocity: UITextField!
    
    @IBOutlet weak var windDirection: UITextField!
    @IBOutlet weak var windVelocity: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    // MARK: - Properties
    
    private var magneticComponent: MagneticComponent?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Private Functions
    
    private func showErrorAlert() {
        // creating alert controller
        let alert = UIAlertController(
            title: "Caution!",
            message: "Please check your entries.", preferredStyle: .alert)
        // creating buttons for action sheet
        let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        // add buttons to the alert controller
        alert.addAction(cancel)
        // show alert controller
        present(alert, animated: true, completion: nil)
        
    }

    // MARK: - Button Actions
    @IBAction func calculateButtonPressed(_ sender: UIBarButtonItem) {
        
        if !aircraftDirection.hasText || !aircraftVelocity.hasText ||
            !windDirection.hasText || !windVelocity.hasText {
            showErrorAlert()
            return
        }
        guard let aircraftDirection = aircraftDirection.text,
              let aircraftVelocity = aircraftVelocity.text,
              let windDirection = windDirection.text,
              let windVelocity = windVelocity.text else {
            
            showErrorAlert()
            return
        }
        
        magneticComponent = MagneticComponent(
            aircraft: Component(direction: Double(aircraftDirection) ?? 0.0,
                                velocity: Double(aircraftVelocity) ?? 0.0),
            wind: Component(direction: Double(windDirection) ?? 0.0,
                            velocity: Double(windVelocity) ?? 0.0))
        
        guard let magnetic = magneticComponent else { fatalError() }
        resultLabel.text = """
                            Magnetic Components:
                            
                            
                            Magnetic Heading: \(magnetic.magneticHeading)º
                            
                            Ground Speed    : \(magnetic.groundSpeed) kt
                            """
        
    }
    
    @IBAction func clearButtonPressed(_ sender: UIBarButtonItem) {
        aircraftDirection.text = ""
        aircraftVelocity.text = ""
        windDirection.text = ""
        windVelocity.text = ""
        resultLabel.text = ""
        self.setEditing(false, animated: true)
    }
    
    
}

