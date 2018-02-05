//
//  TouchpointDetailViewController.swift
//  Touchpoint
//
//  Created by user132895 on 2/3/18.
//  Copyright © 2018 TouchPoint. All rights reserved.
//

import UIKit

class TouchpointDetailViewController: UIViewController {

    @IBOutlet weak var TPDateBkgnd: UIButton!
    @IBOutlet weak var daysSinceTP: UITextField!
    @IBOutlet weak var unitsSinceTP: UITextField!

    
    //MARK:
    override func viewDidLoad() {
        super.viewDidLoad()

        TPDateBkgnd.backgroundColor = UIColor.red
        TPDateBkgnd.layer.cornerRadius = 10
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
