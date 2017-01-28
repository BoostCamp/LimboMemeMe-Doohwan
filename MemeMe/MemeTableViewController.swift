//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by doohwan Lee on 2017. 1. 18..
//  Copyright © 2017년 doohwan Lee. All rights reserved.
//

import UIKit
//TableView Controllre Class
class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var table: UITableView!
    
    //AppDelegate에 접근하기 위한 객체 생성
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func EditAction(_ sender: Any) {
        //TableView EditButton Active / inActive
        if table.isEditing == true{
            table.isEditing = false
        }else{
            table.isEditing = true
        }
    }
    
    override func viewDidLoad() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        table.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //cell count
        return appDelegate.memes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell01", for: indexPath) as! MemeTableViewCell
        cell.cellImage.image = appDelegate.memes[indexPath.row].memedImgae
        cell.imageText.text = appDelegate.memes[indexPath.row].topText
        cell.bottomText.text = appDelegate.memes[indexPath.row].bottomText
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // sender is memedImage
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
        // editStyle set
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //리스트를 표현하기 위한 array 데이터 삭제
        appDelegate.memes.remove(at: indexPath.row)
        
        //저장용 array 데이터 삭제
        appDelegate.anyArr.remove(at: indexPath.row)
        
        // 변경된 저장용 array 저장 및 동기화
        UserDefaults.standard.set(appDelegate.anyArr, forKey: "memes")
        UserDefaults.standard.synchronize()
        
        // 데이터 삭제 후 화면 cell 삭제
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // 셀 순서 변경을 위해 리스트 표현용 array 순서 변경
        let item = appDelegate.memes[sourceIndexPath.row]
        appDelegate.memes.remove(at: sourceIndexPath.row)
        appDelegate.memes.insert(item, at: destinationIndexPath.row)
    
        //저장용 array 순서 변경 후 저장 및 동기화
        let item1 = appDelegate.anyArr[sourceIndexPath.row]
        appDelegate.anyArr.remove(at: sourceIndexPath.row)
        appDelegate.anyArr.insert(item1, at: destinationIndexPath.row)
        UserDefaults.standard.set(appDelegate.anyArr, forKey: "memes")
        UserDefaults.standard.synchronize()
    }
    
}
