//
//  ThrillistDetailViewController.swift
//  Facebook
//
//  Created by Andrew Lyons on 16 Oct 14.
//  Copyright (c) 2014 Andrew Lyons. All rights reserved.
//

import UIKit

class ThrillistDetailViewController: UIViewController
{
    var showKeyboard = false
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.contentSize = imageView.image!.size
        
        //        commentTextField.delegate = self

        // Add two notifications for the keyboard. One when the keyboard is shown and
        // one when it's about to hide.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: "UIKeyboardWillShowNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: "UIKeyboardWillHideNotification", object: nil)

        if showKeyboard
        {
            commentTextField.becomeFirstResponder()
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
        {
            commentView.frame.origin.y -= (keyboardSize.height - 50)
        }
    }
    
    func keyboardWillHide(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
        {
            commentView.frame.origin.y += (keyboardSize.height - 50)
        }
        
    }
    
    @IBAction func onLikeButton(sender: AnyObject)
    {
        likeButton.selected = !likeButton.selected
    }

    @IBAction func onCommentButton(sender: AnyObject)
    {
        commentTextField.becomeFirstResponder()
    }
    @IBAction func onBack(sender: AnyObject)
    {
        navigationController!.popViewControllerAnimated(true)
    }
    
    @IBAction func onTapView(sender: AnyObject)
    {
        commentTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
        textField.resignFirstResponder()
        return true
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
