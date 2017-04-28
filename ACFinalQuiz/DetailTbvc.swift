//
//  DetailTbvc.swift
//  ACFinalQuiz
//
//  Created by YenShao on 2017/4/28.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import SafariServices

class DetailTbvc: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var bookImage: UIImageView!
    
    @IBOutlet weak var placeBtnText: UIButton!
    
    @IBOutlet weak var phoneBtnText: UIButton!
    
    @IBOutlet weak var websiteBtnText: UIButton!
    
    
    
    
    
    var index = 0
    var imageURL:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //scrollView.contentSize = (bookImage.image?.size)!
        

        nameLabel.text = books[index].name
        detailLabel.text = books[index].detail
        placeBtnText.setTitle(books[index].place, for: .normal)
        phoneBtnText.setTitle(books[index].phone, for: .normal)
        websiteBtnText.setTitle(books[index].website, for: .normal)
        if let url = imageURL
        {
            let cacheURL = URL(string: url)
            bookImage.sd_setImage(with: cacheURL)
        }
        else
        {
            print("XXXXX")
        }
        
    }
    override func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return bookImage
    }
    
    @IBAction func placeBtn(_ sender: UIButton)
    {
        performSegue(withIdentifier: "showPlaceSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPlaceSegue"
        {
            let vc = segue.destination as! MapVC
            vc.place = books[index].place
        }
        else
        {
            let sclvc = segue.destination as! ScrollVC
            sclvc.myImage = bookImage.image
        }
    }
    
    

    
    @IBAction func webBtn(_ sender: UIButton)
    {
        if let url = URL(string: books[index].website)
        {
            
            let sf = SFSafariViewController(url: url) //這算是一個viewController
            present(sf, animated: true, completion: nil) //所以就要用present推出來
        }
        
    }
    
    
    @IBAction func callPhone(_ sender: UIButton)
    {
        if let phoneCallURL = URL(string: "tel://\(books[index].phone)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
        
    }
    
    
    
    
    

    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    } */

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
