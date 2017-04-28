//
//  TableViewController.swift
//  ACFinalQuiz
//
//  Created by YenShao on 2017/4/28.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import Firebase

class TableViewController: UITableViewController {
    
    let pullToRefreshControl = UIRefreshControl()
    var tempImage:UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        
        //加入下拉更新
        tableView.refreshControl = pullToRefreshControl
        pullToRefreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        
    }
    
    
    @IBAction func addBtn(_ sender: UIBarButtonItem)
    {
        performSegue(withIdentifier: "addSegue", sender: nil)
    }
        

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell

        cell.bookNameLabel.text = books[indexPath.row].name
        
        let cacheURL = URL(string: books[indexPath.row].imageURL)
        cell.bookImage.sd_setImage(with: cacheURL)
        //cell.bookImage.sd_setImage(with: cacheURL, placeholderImage: UIImage(named: "picture_placeholder.png"))
        
        
        //cell.bookImage.image = UIImage(named: "picture_placeholder")

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "detailSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegue"
        {
            let vc = segue.destination as! DetailTbvc
            vc.index = (tableView.indexPathForSelectedRow?.row)!
            vc.imageURL = books[vc.index].imageURL
            
        }
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete
        {
            //刪database
            let deletKey = books[indexPath.row].autoKey
            DBProvider.Instance.dbRef.child("Books").child(deletKey).removeValue()
            
            books.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    
    
    func loadData()
    {
        let queryOrder = DBProvider.Instance.dbRef.child("Books").queryOrdered(byChild: "name")
        
        
        queryOrder.observe(.value, with: { (snapshots) in
            
            books = []
            
            if let snapshot = snapshots.children.allObjects as? [FIRDataSnapshot]
            {
                for snap in snapshot
                {
                    if let snapDict = snap.value as? Dictionary<String, String
                        >
                    {
                        
                        let autoKey = snap.key
                        let name = snapDict["name"]!
                        let website = snapDict["website"]!
                        let place = snapDict["place"]!
                        let phone = snapDict["phone"]!
                        let detail = snapDict["detail"]!
                        let imageString = snapDict["imageURL"]!
                        let book = Books(name: name, imageURL: imageString, place: place, phone: phone, website: website, detail: detail, autoKey: autoKey)
                        books.append(book)
                        
                    }
                }
            }
            self.tableView.reloadData()
            
        })
        
    }
    
    
    // MARK: - 下拉更新
    func refreshTable()
    {
        loadData()
        tableView.reloadData()
        pullToRefreshControl.endRefreshing()
    }
    

}














