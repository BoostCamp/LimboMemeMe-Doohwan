//
//  MemeImageViewController.swift
//  MemeMe
//
//  Created by doohwan Lee on 2017. 1. 18..
//  Copyright © 2017년 doohwan Lee. All rights reserved.
//

import UIKit
//MemedImage viewController
class MemeImageViewController: UIViewController {

    @IBOutlet weak var memeImage: UIImageView!
    
    var memedImage : UIImage?
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        //Device Orientation Observer등록
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        //Device Orientaion에 따라 ImgaeView ContentMode 설정
        if UIDevice.current.orientation == UIDeviceOrientation.portrait {
            memeImage.contentMode = .scaleAspectFill
        }else {
            memeImage.contentMode = .scaleAspectFit
        }
        memeImage.image = memedImage

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func rotated() {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            memeImage.contentMode = .scaleAspectFit
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            memeImage.contentMode = .scaleAspectFill
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        //Device Orientation Observer해제
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)

    }
    

    
}
