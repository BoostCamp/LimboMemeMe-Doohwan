//
//  Meme.swift
//  MemeMe
//
//  Created by doohwan Lee on 2017. 1. 17..
//  Copyright © 2017년 doohwan Lee. All rights reserved.
//

import Foundation
import UIKit

    struct  Meme {
        var topText : String?
        var bottomText : String?
        var originalImage : UIImage?
        var memedImgae : UIImage?
    }

//UIImgae 사이즈 변경 함수 추가
extension UIImage {
    
    func imageResize (sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }
    
}
    //자리수 조정 함수 추가
extension Float {
    mutating func roundToPlaces(places : Int) -> Float
    {
            let divisor = pow(10.0, Float(places))
        return Darwin.round(self * divisor) / divisor
    }
}
