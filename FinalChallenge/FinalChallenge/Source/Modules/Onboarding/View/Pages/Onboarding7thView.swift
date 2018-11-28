//
//  Onboarding8thView.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 26/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit
import Photos
import CropViewController

class Onboarding7thView: OnboardingPageView {
    
    // MARK: - IBOutlets
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var startReflectingButton: UIButton!
    @IBOutlet weak var bg: UIImageView!
    
    let picker = UIImagePickerController()
    var pickingImage: ImagePicking = .profile
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userImage.layer.cornerRadius = self.userImage.frame.width / 2
        self.userImage.clipsToBounds = true
        
        self.startReflectingButton.layer.cornerRadius = self.startReflectingButton.frame.width / 10
        self.startReflectingButton.clipsToBounds = true        
        
        self.username.setBottomBorder(with: #colorLiteral(red: 0.01960784314, green: 0.06274509804, blue: 0.07843137255, alpha: 1).withAlphaComponent(0.35), and: 0.5)
        
        self.hideKeyboardWhenTappedAround()
        
        self.picker.delegate = self
        
    }
    
    @IBAction func didTapChangeBackgroundImage(_ sender: Any) {
        self.pickingImage = .background
        self.openCameraLibrary()
    }
    
    @IBAction func didTapChangeImage(_ sender: Any) {
        self.pickingImage = .profile
        self.openCameraLibrary()
    }
    
    @IBAction func didClickToStartReflecting(_ sender: Any) {
    }
    
    private func openCameraLibrary() {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true)
            break
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ status in
                
                switch status {
                case .authorized:
                    self.openCameraLibrary()
                case .notDetermined:
                    self.alertUser(withTitle: "Warning", andMessage: "Authorization could not be granted, try again.")
                case .denied, .restricted:
                    self.alertUser(withTitle: "Warning", andMessage: "You either isn't allowed or didn't allow us to access your photo library.")
                }
                
            })
            break
        case .denied, .restricted:
            self.alertUser(withTitle: "Warning", andMessage: "You either isn't allowed or didn't allow us to access your photo library.")
        }
    }
    
    private func alertUser(withTitle title: String, andMessage message: String) {
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension Onboarding7thView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let cropViewController = CropViewController(croppingStyle: self.pickingImage == .profile ? .circular : .default, image: image)
            if self.pickingImage == .background {
                cropViewController.aspectRatioLockEnabled = true
                cropViewController.aspectRatioLockDimensionSwapEnabled = true
                cropViewController.aspectRatioPickerButtonHidden = true
                cropViewController.resetAspectRatioEnabled = false
                cropViewController.customAspectRatio = CGSize.init(width: 4272, height: 2848)
            }
            cropViewController.delegate = self
            self.picker.dismiss(animated: true)
            self.present(cropViewController, animated: true)
        } else {
            self.picker.dismiss(animated: true, completion: {
                self.alertUser(withTitle: "Warning", andMessage: "There was a problem getting the image from your photo library.")
            })
        }
    }
    
    
    
}

extension Onboarding7thView: CropViewControllerDelegate {
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        switch self.pickingImage {
        case .profile:
            self.userImage.image = image
        case .background:
            self.bg.image = image
        }
        cropViewController.dismiss(animated: true)
    }
    
}

enum ImagePicking: String {
    case profile = "profile"
    case background = "background"
}
