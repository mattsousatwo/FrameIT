//
//  ViewController.swift
//  FrameIT
//
//  Created by Matthew Sousa on 11/24/18.
//  Copyright © 2018 Matthew Sousa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var creationFrame: UIView!
    @IBOutlet weak var creationImageView: UIImageView!
    @IBOutlet weak var startOverButton: UIButton!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var colorsContainer: UIView!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBAction func startOver(_ sender: Any) {
        print("Starting Over Button Pressed!")
    }
    
    @IBAction func applyColor(_ sender: Any) {
        print("Color Choose!")
    }
    
    @IBAction func share(_ sender: Any) {
//        print("Share Now!")
        displayImagePickingOptions()
    }
    
    func displayImagePickingOptions() {
        print("Display Image Picking Options")
        
        // Initializing an Action Controller - perferred style = action sheet
        let alertController = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        
        // Adding actions to our action controller
        // Camera Alert Action
        // Here we have a closure, a block of code similar to a function, without a name, that is taken in as a parameter of UIAlertAction as the "handler" parameter. This describes what will happen after the alert is chosen
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in print("Launch Device Camera")
        }
        // Add camera action to alert controller
        alertController.addAction(cameraAction)
    
        // Library Alert Action
        let libraryAction = UIAlertAction(title: "Library", style: .default) { (action) in print("Launch Device Photo Library")
        }
        
        // Adding Library Alert Action to AlertController
        alertController.addAction(libraryAction)
        
        // Random Alert Action
        let randomAction = UIAlertAction(title: "Random", style: .default) { (action) in print("Picking from local images")
        }
        
        // Adding Random Alert Action to AlertController
        alertController.addAction(randomAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in print("Cancel")
        }
        
        alertController.addAction(cancelAction)
     
        present(alertController, animated: true) {
            // code to be run after view is presented
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }



}

