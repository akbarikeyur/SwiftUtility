//
//  UploadImageVC.swift
//  SwiftUtility
//
//  Created by Keyur.
//  Copyright © 2020 Keyur. All rights reserved.
//


import UIKit


open class UploadImageVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imgPicker = UIImagePickerController()
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        self.imgPicker.delegate = self

    }

    // MARK: - Upload Image
    /**
     *
     * This function is use for upload image.
     * User can select image from gallery or camera.
     * Using onCaptureImageThroughCamera function user can capture image through camera.
     * Using onCaptureImageThroughGallery function user can select image from gallery.
     * imagePickerController is delegate methode of image picker controller.
     *
     * @param
     */
    public func uploadImage()
    {
        let actionSheet: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let cancelButton = UIAlertAction(title: getTranslate("cancel_button"), style: .cancel) { _ in
            
        }
        actionSheet.addAction(cancelButton)

        let cameraButton = UIAlertAction(title: getTranslate("take_photo"), style: .default)
        { _ in
            self.onCaptureImageThroughCamera()
        }
        actionSheet.addAction(cameraButton)

        let galleryButton = UIAlertAction(title: getTranslate("gallery_photo"), style: .default)
        { _ in
            self.onCaptureImageThroughGallery()
        }
        actionSheet.addAction(galleryButton)

        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = actionSheet.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []

            }
        }

        UIApplication.topViewController()!.present(actionSheet, animated: true, completion: nil)
    }

    @objc open func onCaptureImageThroughCamera()
    {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            displayToast("device_no_camera")
        }
        else {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.allowsEditing = false
            imgPicker.sourceType = .camera
            UIViewController.top?.present(imgPicker, animated: true, completion: {() -> Void in
            })
        }
    }

    @objc open func onCaptureImageThroughGallery()
    {
        UIApplication.topViewController()!.dismiss(animated: true, completion: nil)
        DispatchQueue.main.async {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.allowsEditing = false
            imgPicker.sourceType = .photoLibrary
            UIApplication.topViewController()!.present(imgPicker, animated: true, completion: {() -> Void in
                
            })
        }
    }

    open func selectedImage(choosenImage : UIImage) {
        
    }
    
    open func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imgPicker.dismiss(animated: true, completion: {() -> Void in
        })
        if let choosenImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            let croppedImage1 = compressImage(choosenImage, to: CGSize(width: 800, height: 800))
            selectedImage(choosenImage: croppedImage1)
            UIApplication.topViewController()!.dismiss(animated: true) {

            }
        }
      
    }

    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



