//
//  InfoViewController.swift
//  Destini-iOS13
//
//  Created by Chris Stanley on 13/04/2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit
import StoreKit

class InfoViewController: UIViewController {


    @IBOutlet weak var infoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
     
    infoLabel.text = "This app was created just for fun\n\nPlease do review my first iOS-13 app"
       
    }
    

    @IBAction func returnButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func reviewButtonPressed(_ sender: UIButton) {
        
       
    }


}
