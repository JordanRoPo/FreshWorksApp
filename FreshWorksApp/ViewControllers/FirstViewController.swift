//
//  FirstViewController.swift
//  FreshWorksApp
//
//  Created by Jordan  Romero Porter on 2017-12-15.
//  Copyright © 2017 FreshWorks. All rights reserved.
//

import UIKit
import Foundation

class FirstViewController: ImagePickerViewController {
    
    var imagePicker:ImagePickerManager?
    
    @IBOutlet weak var openImagePickerButton: UIBarButtonItem!
    
    @IBAction func openImagePicker(_ sender: Any) {
        setUpImagePicker()
    }
    
    @IBOutlet weak var tv: FWUITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tv.tableView.delegate = self
        tv.tableView.dataSource = self
        presentImages()
        setUpImagePicker()
    }
    
    func setUpImagePicker() {
        guard imagePicker == nil else {
            imagePicker?.openImagePickerFor(vc: self)
            return
        }
        imagePicker = ImagePickerManager()
    }
    
    override func presentImages() {
        super.presentImages()
        tv.tableView.reloadData()
    }

}

extension FirstViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
        cell.savedImage.image = images[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
}

