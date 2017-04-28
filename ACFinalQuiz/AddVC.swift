//
//  AddVC.swift
//  ACFinalQuiz
//
//  Created by YenShao on 2017/4/28.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import Firebase

class AddVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var addimage: UIImageView!
    
    @IBOutlet weak var addName: UITextField!
    
    @IBOutlet weak var addPlace: UITextField!
    
    @IBOutlet weak var addPhone: UITextField!
    
    @IBOutlet weak var addWebsite: UITextField!
    
    @IBOutlet weak var addDetail: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        //在圖片上加入點擊手勢效果
        addimage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfileImage)))
    }
    
    @IBAction func saveBtn(_ sender: UIBarButtonItem)
    {
        if checkTextField()
        {
            let name = addName.text!
            let place = addPlace.text!
            let phone = addPhone.text!
            let website = addWebsite.text!
            let detail = addDetail.text!
            
            //存圖片
            let uidString = NSUUID().uuidString
            let activityImagesRef = DBProvider.Instance.storageRef.child("Book_images").child(uidString)
            let imageData:Data = UIImageJPEGRepresentation(addimage.image!, 0.4)!
            
            activityImagesRef.put(imageData, metadata: nil) { (metadata, error) in
                
                if error != nil
                {
                    print("上傳圖片錯誤: \(String(describing: error?.localizedDescription))")
                    return
                }
                
                //照片儲存位置
                let imageURL:String = (metadata?.downloadURL()?.absoluteString)!
                
                //存資料與圖片
                let data:[String:Any] = ["name":name, "place":place, "phone":phone, "website":website, "imageURL":imageURL, "detail":detail]
                
                DBProvider.Instance.dbRef.child("Books").childByAutoId().setValue(data)

                //成功後轉場
                let _ = self.navigationController?.popViewController(animated: true)
                
            }
            
        }
        else
        {
            
        }
        
    }
    
    
    func selectProfileImage()
    {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        show(imagePickerController, sender: self)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        addimage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
        
    }
    
    
    //MARK: 檢查文字框空白
    func checkTextField() -> Bool
    {
        if addName.text != "" && addPlace.text != "" && addPhone.text != "" && addWebsite.text != "" && addDetail.text != ""
        {
            if addimage.image != nil
            {
                return true
            }
            else
            {
                alertTheUser(title: "尚未完成欄位", message: "請放上一張圖片")
                return false
            }
            
        }
        else
        {
            alertTheUser(title: "尚未完成欄位", message: "請輸入資料")
            return false
        }
    }
    
    func alertTheUser(title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    
    

}












