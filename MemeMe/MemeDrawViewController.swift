//
//  MemeDrawViewController.swift
//  MemeMe
//
//  Created by doohwan Lee on 2017. 1. 20..
//  Copyright © 2017년 doohwan Lee. All rights reserved.
//

import UIKit

class MemeDrawViewController: UIViewController {

    var backimage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let drawView = 	DrawingView()
        self.view.addSubview(drawView)
        
        drawView.backgroundColor = UIColor(patternImage: backimage!)
        drawView.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontals = NSLayoutConstraint.constraints(withVisualFormat: "|-0-[drawView]-0-|", options: [], metrics: nil, views: ["drawView":drawView])
        let verticals = NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[drawView]-0-|", options: [], metrics: nil, views: ["drawView":drawView])
        
        self.view.addConstraints(horizontals)
        self.view.addConstraints(verticals)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancleAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveAction(_ sender: Any) {
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
