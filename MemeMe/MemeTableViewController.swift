//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by doohwan Lee on 2017. 1. 18..
//  Copyright © 2017년 doohwan Lee. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var table: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func EditAction(_ sender: Any) {
        if table.isEditing == true{
            table.isEditing = false
        }else{
            table.isEditing = true
        }
    }
    override func viewDidLoad() {
        //self.navigationController?.title = "Sent Memes"
        //tabBarItem.title = "Table"
    }
    
    override func viewDidLayoutSubviews() {
    }
    override func viewWillAppear(_ animated: Bool) {
        table.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return appDelegate.memes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell01", for: indexPath) as! MemeTableViewCell
       cell.cellImage.image = appDelegate.memes[indexPath.row].memedImgae
       cell.imageText.text = appDelegate.memes[indexPath.row].topText
       cell.bottomText.text = appDelegate.memes[indexPath.row].bottomText
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "image_segue1", sender: appDelegate.memes[indexPath.row].memedImgae)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "image_segue1"{
        let imageVC = segue.destination as! MemeImageViewController
            let memedImage = sender as! UIImage
            imageVC.memedImage = memedImage
        }
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        appDelegate.memes.remove(at: indexPath.row)
        appDelegate.anyArr.remove(at: indexPath.row)
        UserDefaults.standard.set(appDelegate.anyArr, forKey: "memes")
        UserDefaults.standard.synchronize()
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = appDelegate.memes[sourceIndexPath.row]
        appDelegate.memes.remove(at: sourceIndexPath.row)
        appDelegate.memes.insert(item, at: destinationIndexPath.row)
        
        let item1 = appDelegate.anyArr[sourceIndexPath.row]
        appDelegate.anyArr.remove(at: sourceIndexPath.row)
        appDelegate.anyArr.insert(item1, at: destinationIndexPath.row)
        UserDefaults.standard.set(appDelegate.anyArr, forKey: "memes")
        UserDefaults.standard.synchronize()
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
