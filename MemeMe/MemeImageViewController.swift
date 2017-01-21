//
//  MemeImageViewController.swift
//  MemeMe
//
//  Created by doohwan Lee on 2017. 1. 18..
//  Copyright © 2017년 doohwan Lee. All rights reserved.
//

import UIKit

class MemeImageViewController: UIViewController {

    @IBOutlet weak var memeImage: UIImageView!
    var memedImage : UIImage?
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        memeImage.image = memedImage
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
