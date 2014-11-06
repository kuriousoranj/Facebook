//
//  RequestsViewController.swift
//  Facebook
//
//  Created by Andrew Lyons on 16 Oct 14.
//  Copyright (c) 2014 Andrew Lyons. All rights reserved.
//

import UIKit

class RequestsViewController: UIViewController {

    @IBOutlet weak var peopleScrollView: UIScrollView!
    @IBOutlet weak var peopleImageview: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        peopleScrollView.contentSize = peopleImageview.image!.size
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
