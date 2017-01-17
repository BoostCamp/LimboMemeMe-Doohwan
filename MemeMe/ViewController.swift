//
//  ViewController.swift
//  MemeMe
//
//  Created by doohwan Lee on 2017. 1. 16..
//  Copyright © 2017년 doohwan Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var Bottom: UITextField!
    @IBOutlet weak var Top: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!

    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.black,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: 3.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Top.defaultTextAttributes = memeTextAttributes
        Top.textAlignment = .center
        Top.delegate = self
        Bottom.defaultTextAttributes = memeTextAttributes
        Bottom.textAlignment = .center
        Bottom.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage, picker.sourceType == .photoLibrary	{
            imageView.image = image
            dismiss(animated: true, completion: nil)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func save() {
        // Create the meme
        let meme = Meme(topText: Top.text!, bottomText: Bottom.text!, originalImage: imageView.image!, memedImgae: generateMemedImage())
    }
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        toolbar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        toolbar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
        
        return memedImage
    }
    
    @IBAction func shareAction(_ sender: Any) {
        let memedImage = generateMemedImage()
        let ActivityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        //ActivityVC.completionWithItemsHandler
        present(ActivityVC, animated: true, completion: nil)
    }
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true)

    }
    @IBAction func pickAnImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
        if imageView.image == nil {
            shareButton.isEnabled = false
        }else{
            shareButton.isEnabled = true
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }
    func keyboardWillShow(_ noti : Notification){
        if let rectObj = noti.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue, Bottom.isFirstResponder
        {
            let keyboardRect = rectObj.cgRectValue
            self.view.frame.origin.y = 0 - keyboardRect.height
        }
    }
    
    func keyboardWillHide(_ noti : Notification){
        self.view.frame.origin.y = 0
    }
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
}

