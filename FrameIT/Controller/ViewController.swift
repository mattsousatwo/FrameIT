//
//  ViewController.swift
//  FrameIT
//
//  Created by Matthew Sousa on 11/24/18.
//  Copyright © 2018 Matthew Sousa. All rights reserved.
//

import UIKit
import Photos
import AVFoundation

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var creationFrame: UIView!
    @IBOutlet weak var creationImageView: UIImageView!
    @IBOutlet weak var startOverButton: UIButton!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var colorsContainer: UIView!
    @IBOutlet weak var shareButton: UIButton!
    
    var creation = Creation.init()
    
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
    
    
// Alert Controller for user to select a photo or to take a picture 
    func displayImagePickingOptions() {
        print("Display Image Picking Options")
        
        // Initializing an Action Controller - perferred style = action sheet
        let alertController = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        
        // Adding actions to our action controller
        // Camera Alert Action
        let cameraAction = UIAlertAction(title: "Open Camera", style: .default) { (action) in self.displayCamera()
        }
        // Add camera action to alert controller
        alertController.addAction(cameraAction)
    
        // Library Alert Action
        let libraryAction = UIAlertAction(title: "Library Pick", style: .default) { (action) in self.displayLibrary()
        }
        
        // Adding Library Alert Action to AlertController
        alertController.addAction(libraryAction)
        
        // Random Alert Action
        let randomAction = UIAlertAction(title: "Random Photo", style: .default) { (action) in self.pickRandom()
        }
        
        // Adding Random Alert Action to AlertController
        alertController.addAction(randomAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(cancelAction)
     
        present(alertController, animated: true) {
            // code to be run after view is presented
        }
        
    }
    
    
    func displayLibrary() {
        // assining our source type (photo library)
        let sourceType = UIImagePickerController.SourceType.photoLibrary
        
        // checking if our source type is avalible
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
        
            // access the current permission status of photo library
            let status = PHPhotoLibrary.authorizationStatus()
            let noPermissionMessage = "Looks like FrameIT doesn't have access to your photos. Please the use Settings app on your device to permit FrameIT to access your photo library."
            
            switch status {
                // .notDetermined - user never asked to use Photo Library befrore
            case .notDetermined:
                    // then request photo library acess permission
                PHPhotoLibrary.requestAuthorization({ (newStatus) in
                    if newStatus == .authorized {
                        // if accepted display imagePicker
                        self.presentImagePicker(sourceType: sourceType)
                    } else {
                        // else display message
                        self.troubleAlertMessage(message: noPermissionMessage)
                    }
                })
            case .authorized:
                self.presentImagePicker(sourceType: sourceType)
                
            case .denied, .restricted: // case no or never, display message
                self.troubleAlertMessage(message: noPermissionMessage)
            }
            
        }
            
        else { // else if UIImagePickerController photo Library source type is not avalible then print message alert controller
            troubleAlertMessage(message: "Sincere apologies, it looks like we can't access your photo library at this time, please go to Settings on your device to allow FrameIT to access photos.")
        }
        
    }
    
    
    //  Present Image Picker
    func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Safely unwrapping our image to our UIImageView
    func processPicked(image: UIImage?) {
        if let newImage = image {
            creationImageView.image = newImage
        }
    }
    
   // Dismissing and assining UIImagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) { // do after image is selected
    
        // dismissing our UIImagePickerController
        picker.dismiss(animated: true, completion: nil)
        
        // Type casting new selected image as UIImage
        let newImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        // Using processPicked to safely unwrap our selected image to our UIImageView
        processPicked(image: newImage)
    }
    
    // Present Trouble Alert Message Controller
    func troubleAlertMessage(message: String?) {
        let alertController = UIAlertController(title: "Oops...", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Got it", style: .cancel)
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }

    func displayCamera() {
        let sourceType = UIImagePickerController.SourceType.camera
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            
            let noPermissionMessage = "Looks like FrameIT doesn't have access to your camera. Please the use Settings app on your device to permit FrameIT to access your camera."
            
            switch status {
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: {(granted) in
                    if granted {
                        self.presentImagePicker(sourceType: sourceType)
                    } else {
                        self.troubleAlertMessage(message: noPermissionMessage)
                    }
                })
            case .authorized:
                self.presentImagePicker(sourceType: sourceType)
            case .denied, .restricted:
                self.troubleAlertMessage(message: noPermissionMessage)
            }
        }
        else {
            troubleAlertMessage(message: "Sincere apologies, it looks like we can't access your camera at this time.")
        }
    }
    
    
    func pickRandom() {
        print("Pick Random")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }



}

