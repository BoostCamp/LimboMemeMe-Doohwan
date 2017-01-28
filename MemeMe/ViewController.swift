//
//  ViewController.swift
//  MemeMe
//
//  Created by doohwan Lee on 2017. 1. 16..
//  Copyright © 2017년 doohwan Lee. All rights reserved.
//

import UIKit
//MemeViewcontroller class
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, paintDelegate {
    
    @IBOutlet weak var paintButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var Bottom: UITextField!
    @IBOutlet weak var Top: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var navibar: UINavigationBar!
    
    //var store_image : UIImage?
    var image_width : CGFloat?
    var image_Height : CGFloat?
    var pickImage : UIImage?
    //meme top, bottom Text Attributes Set
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black, //Text color
        NSForegroundColorAttributeName: UIColor.white, //text stroke color
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,  //text font, size
        NSStrokeWidthAttributeName: -1.0] // text stroke width (if value is greater than 0, Text color is transparent)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Top text set apply
        Top.defaultTextAttributes = memeTextAttributes
        Top.textAlignment = .center
        Top.delegate = self
        //Bottom text set apply
        Bottom.defaultTextAttributes = memeTextAttributes
        Bottom.textAlignment = .center
        Bottom.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //사진 선택, 촬영 후 이미지 처리
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{ //수정되지 않은 이미지 선택
            if picker.sourceType == .camera { //if camera
                imageView.image = image
                pickImage = image
                image_width =  image.size.width
                image_Height = image.size.height
                dismiss(animated: true, completion: nil)
            }else{
                pickImage = image
                imageView.image = image
                image_width =  image.size.width
                image_Height = image.size.height
                dismiss(animated: true, completion: nil)
            }
        }
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //키보드 return값 설정
        return true
    }
    
    func save(memedImage : UIImage) {
        //리스트 표현 Array에 데이터 저장
        let meme = Meme(topText: Top.text!, bottomText: Bottom.text!, originalImage: imageView.image!, memedImgae: memedImage)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
        //저장용 Array 호출
        defaultsSetting(meme: meme)
    }
    
    func defaultsSetting(meme : Meme) {
        //저장용 Array에 데이터 저장 및 동기화
        let setting = UserDefaults.standard
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.anyArr.append(["topText":meme.topText! as NSString,"bottomText":meme.bottomText! as NSString,"originalImage":UIImagePNGRepresentation(meme.originalImage!)! as NSData,"memedImage":UIImagePNGRepresentation(meme.memedImgae!)! as NSData])
    
        setting.set(appDelegate.anyArr, forKey: "memes")
        setting.synchronize()
    }
    func paintImageSet(image : UIImage){
        let size = CGSize(width: image_width!, height: image_Height!)
        imageView.image = image.imageResize(sizeChange: size)
    }
    
    func generateMemedImage() -> UIImage {
        //스크린 샷
        
        //툴바와 네비게이션 바 숨김
        toolbar.isHidden = true
        navibar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size) // 이미지 context 생성
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true) //Snapshot 촬영후 현재 context에 저장
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()! //현재 image context -> UIImage로 저장
        UIGraphicsEndImageContext() //최상위 이미지 context 스택 제거
        
        //툴바와 네비게이션 바 나타냄
        toolbar.isHidden = false
        navibar.isHidden = false
        
        return memedImage
    }
    
    //화면 상단 바 숨김
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
    @IBAction func shareAction(_ sender: Any) {
        //스냅샵 촬영
        let memedImage = generateMemedImage()
        
        //ActivityViewcontroller
        let ActivityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        //아이패드에서 적용을 위한 popoverPresent 설정
        if let popvc = ActivityVC.popoverPresentationController{
            popvc.sourceView = self.view
        }
        //ActivityViewController 결과 처리
        ActivityVC.completionWithItemsHandler = {activity, completed, items, error in
            
            if completed { // 결과가 성공일 때
                self.save(memedImage: memedImage)  //데이터 저장
                self.dismiss(animated: true, completion: nil) //현재 ViewController Scene 종료
            }else{
                
            }
        }
        present(ActivityVC, animated: true, completion: nil)
    }
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera //사진촬영으로 이미지 가져옴
        present(imagePicker, animated: true)

    }
    @IBAction func pickAnImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary //앨범에서 이미지 가져옴
        present(imagePicker, animated: true)
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil) //현재 ViewController Scene 종료
    }
    @IBAction func paintAction(_ sender: Any) {
        performSegue(withIdentifier: "paint_segue", sender: pickImage)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "paint_segue"{
            let paintVC = segue.destination as! MemeMePaintViewController
            let memedImage = sender as! UIImage
            paintVC.memedImage = memedImage
            paintVC.delegate = self
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        //카메라 사용가능 여부에 따라 버튼 활성화 여부
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        subscribeToKeyboardNotifications() // 키보드 관련 Notification Observer 등록
        
        //이미지 여부에 따라 ActivityViewController 버튼, Paint 버튼 활성화
        if imageView.image == nil {
            shareButton.isEnabled = false
            paintButton.isEnabled = false
        }else{
            shareButton.isEnabled = true
            paintButton.isEnabled = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications() // 키보드 관련 Notification Observer 해제
    }
    
    func rotated() {
        //화면 회전에 따라 ImageView ContentMode 변경
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            imageView.contentMode = .scaleAspectFill
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            imageView.contentMode = .scaleAspectFit
        }
        
    }
    func keyboardWillShow(_ noti : Notification){
        
        if let rectObj = noti.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue, Bottom.isFirstResponder
        {
            // 키보드 높이 가져옴
            let keyboardRect = rectObj.cgRectValue
            // 키보드 높이 만큼 화면 밀기
            self.view.frame.origin.y = 0 - keyboardRect.height
        }
    }
    
    func keyboardWillHide(_ noti : Notification){
        self.view.frame.origin.y = 0
    }
    func subscribeToKeyboardNotifications() {
        //키보드 나타남
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        //키보드 들어감
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        //화면 회전
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
    }
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
}

