//
//  ImagePickerManager.swift
//  SkillSpark
//
//  Created by Gaurav Bidani on 12/10/25.
//

import UIKit
import PhotosUI

protocol ImagePickerDelegate: AnyObject {
    func didSelectImage(_ image: UIImage)
    func didCancelImagePicker()
}

class ImagePickerManager: NSObject {
    
    weak var delegate: ImagePickerDelegate?
    weak var presentingViewController: UIViewController?
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
        super.init()
    }
    
    func showImagePickerOptions() {
        let alert = UIAlertController(
            title: "Select Photo",
            message: "Choose a source",
            preferredStyle: .actionSheet
        )
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Take Photo", style: .default) { _ in
                self.openCamera()
            })
        }
        
        alert.addAction(UIAlertAction(title: "Choose from Library", style: .default) { _ in
            self.openPhotoLibrary()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.delegate?.didCancelImagePicker()
        })
        
        presentingViewController?.present(alert, animated: true)
    }
    
    // MARK: - Open Camera
    func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            showAlert(message: "Camera is not available on this device")
            return
        }
        
        let cameraPicker = UIImagePickerController()
        cameraPicker.sourceType = .camera
        cameraPicker.allowsEditing = true
        cameraPicker.delegate = self
        
        presentingViewController?.present(cameraPicker, animated: true)
    }
    
    // MARK: - Open Photo Library
    func openPhotoLibrary() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        presentingViewController?.present(picker, animated: true)
    }
    
    // MARK: - Helper
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        presentingViewController?.present(alert, animated: true)
    }
}

extension ImagePickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let editedImage = info[.editedImage] as? UIImage {
            delegate?.didSelectImage(editedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            delegate?.didSelectImage(originalImage)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        delegate?.didCancelImagePicker()
    }
}

extension ImagePickerManager: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let result = results.first else {
            delegate?.didCancelImagePicker()
            return
        }
        
        result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
            DispatchQueue.main.async {
                if let image = object as? UIImage {
                    self?.delegate?.didSelectImage(image)
                } else {
                    self?.showAlert(message: "Failed to load image")
                }
            }
        }
    }
}
