//
//  MemeMePaintViewController.swift
//  MemeMe
//
//  Created by doohwan Lee on 2017. 1. 26..
//  Copyright © 2017년 doohwan Lee. All rights reserved.
//

import UIKit

// paintDelegate 생성
protocol paintDelegate : class{
    func paintImageSet(image : UIImage)
}

class MemeMePaintViewController: UIViewController {
   //델리게이트 객체 생성
    var delegate : paintDelegate?
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var pathLabel: UILabel!
    @IBOutlet weak var mergeView: UIView!
    @IBOutlet weak var DrawBackground: UIImageView!
    @IBOutlet weak var DrawView: MemeMeDrawView!
    
    var memedImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //배경 값 투명
        DrawView.backgroundColor = UIColor(white: 1, alpha: 0.0)
        DrawBackground.image = memedImage
        pathLabel.text = slider.value.description
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sliderAction(_ sender: Any) {
        //Float값 소수점 1자리수
        let value = slider.value.roundToPlaces(places: 1)
        pathLabel.text = value.description
        //선 굵기 변경
        DrawView.width = CGFloat(value)
    }
    @IBAction func saveAction(_ sender: Any) {
        
        // 이미지 context 생성
        UIGraphicsBeginImageContext(self.mergeView.frame.size)
        //Snapshot 촬영후 현재 context에 저장
        mergeView.drawHierarchy(in: mergeView.frame, afterScreenUpdates: true)
        //현재 image context -> UIImage로 저장
        let paintedImage = UIGraphicsGetImageFromCurrentImageContext()!
        //최상위 이미지 context 스택 제거
        UIGraphicsEndImageContext()
        
        delegate?.paintImageSet(image: paintedImage)
        dismiss(animated: true, completion: nil)

    }
    @IBAction func cancelAction(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
