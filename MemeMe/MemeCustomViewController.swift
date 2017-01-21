//
//  MemeCustomViewController.swift
//  MemeMe
//
//  Created by doohwan Lee on 2017. 1. 19..
//  Copyright © 2017년 doohwan Lee. All rights reserved.
//

import UIKit

class MemeCustomViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var colView: UICollectionView!
    var dialLayout:AWCollectionViewDialLayout!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cell_height:CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let radius = CGFloat(0.39 * 1000)
        let angularSpacing = CGFloat(0.16 * 90)
        let xOffset = CGFloat(0.23 * 320)
        let cell_width = CGFloat(240)
        cell_height = 100
        dialLayout = AWCollectionViewDialLayout(raduis: radius, angularSpacing: angularSpacing, cellSize: CGSize(width: cell_width, height: cell_height) , alignment: WheelAlignmentType.center, itemHeight: cell_height, xOffset: xOffset)
        dialLayout.shouldSnap = true
        dialLayout.shouldFlip = true
        colView.collectionViewLayout = dialLayout
        dialLayout.scrollDirection = .horizontal
        dialLayout.cellSize = CGSize(width: 340, height: 100)
        dialLayout.wheelType = .left
        dialLayout.shouldFlip = false
        dialLayout.dialRadius = 300
        dialLayout.angularSpacing = 18
        dialLayout.xOffset = 70
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        colView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell03", for: indexPath) as! AWCollectionCell
        
        
        // 내용 반영
        cell.icon.image = appDelegate.memes[indexPath.row].memedImgae
        cell.label.text = appDelegate.memes[indexPath.row].topText
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "image_segue3", sender: appDelegate.memes[indexPath.row].memedImgae)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "image_segue3"{
            let imageVC = segue.destination as! MemeImageViewController
            let memedImage = sender as! UIImage
            imageVC.memedImage = memedImage
        }
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
