//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by doohwan Lee on 2017. 1. 18..
//  Copyright © 2017년 doohwan Lee. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController{

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell02", for: indexPath) as! MemeCollectionViewCell
    
        cell.colCellImage.image = appDelegate.memes[indexPath.row].memedImgae
        
        return cell

    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView?.reloadData()
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "image_segue2", sender: appDelegate.memes[indexPath.row].memedImgae)
    }
    override func viewDidLoad() {
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "image_segue2"{
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
