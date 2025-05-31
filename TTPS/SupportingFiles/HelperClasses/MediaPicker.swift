//
//  MediaPicker.swift
//  Keepook
//
//  Created by yapapp on 4/5/19.
//  Copyright © 2019 YapApp. All rights reserved.
//

import UIKit
import Photos

fileprivate struct Constants {
    static var chooseOption = "Choose Option"
    static var takePhoto = "Take Photo"
    static var chooseGallery = "Choose Gallery"
    static var cancel = "Cancel"
    static var alert = "Alert"
    static var setting = "Settings"
    static var permissionMessage = "You have denied the permissions, you can allow permissions from settings."
}

@objc protocol MediaPickerDelegate {
    func mediaPicker(_ mediaPicker: MediaPicker, didChooseImage image: UIImage?, imageName: String?)
    @objc optional func mediaPickerDidCancel(_ mediaPicker: MediaPicker)
}

class MediaPicker: NSObject {
    
    private var picker: UIImagePickerController!
    static var shared = MediaPicker()
    weak var delegate: MediaPickerDelegate?
    var allowEditing = true
    
    func openActionSheetForImagePicker() {
        let optionMenu = UIAlertController(title: nil, message: Constants.chooseOption, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: Constants.takePhoto, style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.checkAuthorizationAndOpenPicker(with: .camera)
        })
        let libraryAction = UIAlertAction(title: Constants.chooseGallery, style: .default, handler:{
            (alert: UIAlertAction!) -> Void in
            self.checkAuthorizationAndOpenPicker(with: .photoLibrary)
        })
        let cancelAction = UIAlertAction(title: Constants.cancel, style: .cancel, handler:{
            (alert: UIAlertAction!) -> Void in
        })
        optionMenu.addAction(cameraAction)
        optionMenu.addAction(libraryAction)
        optionMenu.addAction(cancelAction)
        UIApplication.topVC()?.present(optionMenu, animated: true, completion: nil)
    }
    
    func checkAuthorizationAndOpenPicker(with type: UIImagePickerController.SourceType) {
        if type == .camera {
            self.checkAVPermission { (finish) in
                if finish {
                    self.openPicker(with: type)
                }else {
                    //show open setting Alert
                    self.showSettingAlert()
                }
            }
        }else if type == .photoLibrary {
            self.checkPhotoLibraryPermission { (finish) in
                if finish {
                    self.openPicker(with: type)
                }else {
                    //show open setting Alert
                    self.showSettingAlert()
                }
            }
        }
    }
    
    private func openPicker(with sourceType: UIImagePickerController.SourceType) {
        DispatchQueue.main.async {
            self.picker = UIImagePickerController()
//            var sourceType = sourceType
//            if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) && sourceType == .camera {
//                sourceType = .photoLibrary
//            }
//
//            self.picker.delegate = self
//            self.picker.sourceType = sourceType
//            self.picker.allowsEditing = self.allowEditing
//
//            UIApplication.topVC()?.present(self.picker, animated: true, completion: nil)
            
            
            if sourceType == .camera
            {
                if UIImagePickerController.isSourceTypeAvailable(.camera)
                {
                    self.picker.delegate = self
                    self.picker.sourceType = .camera
                    self.picker.cameraDevice = .rear
                    self.picker.allowsEditing = self.allowEditing
                    UIApplication.topVC()?.present(self.picker, animated: true, completion: nil)
                }
            }
            else
            {
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
                {
                    self.picker.delegate = self
                    self.picker.sourceType = .photoLibrary
                    self.picker.allowsEditing = self.allowEditing
                    UIApplication.topVC()?.present(self.picker, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func checkAVPermission(with type: AVMediaType = .video, completion: @escaping (Bool) -> ()) {
        if AVCaptureDevice.authorizationStatus(for: type) == .authorized {
            //already authorized
            completion(true)
        } else {
            AVCaptureDevice.requestAccess(for: type, completionHandler: { (granted: Bool) in
                if granted {
                    //access allowed
                    completion(true)
                } else {
                    //access denied
                    completion(false)
                }
            })
        }
    }
    
    private func checkPhotoLibraryPermission(completion: @escaping (Bool) -> ()) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            //handle authorized status
            completion(true)
        case .denied, .restricted :
            //handle denied status
            completion(false)
        case .limited:
            completion(true)
        case .notDetermined:
            // ask for permissions
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    // as above
                    completion(true)
                case .denied, .restricted:
                    // as above
                    completion(false)
                case .notDetermined:
                    // won't happen but still
                    completion(false)
                case .limited:
                    completion(true)
                @unknown default:
                    return
                }
            }
        @unknown default:
            return
        }
    }
}

// MARK: - IMAGE PICKER CONTROLLER DELEGATE
extension MediaPicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let key: UIImagePickerController.InfoKey = self.allowEditing ? .editedImage: .originalImage
        let image = info[key] as? UIImage
        var imageName: String?
        if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
            let assetResources = PHAssetResource.assetResources(for: asset)
            imageName = assetResources.first?.originalFilename
        }
        picker.dismiss(animated: true, completion: nil)
        self.delegate?.mediaPicker(self, didChooseImage: image, imageName: imageName)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
        self.delegate?.mediaPickerDidCancel?(self)
    }
}

// MARK: - ALERT
extension MediaPicker {
    private func showSettingAlert() {
        let alert = UIAlertController(title: Constants.alert, message: "You have denied the permissions, you can allow permissions from settings.", preferredStyle: .alert)
        let settingButton = UIAlertAction(title: Constants.setting, style: .default) { (action) in
            //open setting
            UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }
        let cancelButton = UIAlertAction(title: Constants.cancel, style: .default, handler: nil)
        alert.addAction(settingButton)
        alert.addAction(cancelButton)
        DispatchQueue.main.async {
            UIApplication.topVC()?.present(alert, animated: true, completion: nil)
        }
    }
}
