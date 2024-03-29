//
//  FeedViewController.swift
//  Facebook
//
//  Created by Andrew Lyons on 16 Oct 14.
//  Copyright (c) 2014 Andrew Lyons. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITextFieldDelegate, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning
{
    @IBOutlet weak var homeScrollView: UIScrollView!
    @IBOutlet weak var homeImageView: UIImageView!
    @IBOutlet weak var composeImageView: UIImageView!
    @IBOutlet weak var commentButton: UIButton!

    var tappedImageView: UIImageView!
    var isPresenting: Bool = true
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        homeScrollView.contentSize.height = homeImageView.image!.size.height
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
/*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        var destinationViewController = segue.destinationViewController as ThrillistDetailViewController
        destinationViewController.showKeyboard = (sender as NSObject == commentButton)
    }
*/
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning!
    {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning!
    {
        isPresenting = false
        return self
    }

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval
    {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        var window = UIApplication.sharedApplication().keyWindow as UIWindow!
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        if (isPresenting)
        {
            var photoViewControler = toViewController as PhotoViewController
            var animateImageView = UIImageView(image: tappedImageView.image)

            animateImageView.frame = window.convertRect(tappedImageView.frame, fromView: self.homeScrollView)
            animateImageView.contentMode = tappedImageView.contentMode
            animateImageView.clipsToBounds = tappedImageView.clipsToBounds
            window.addSubview(animateImageView)

            photoViewControler.imageView.hidden = true
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            
            UIView.animateWithDuration(0.4, animations:
            { () -> Void in
                // Animate here
                animateImageView.frame = window.convertRect(photoViewControler.imageView.frame, fromView: photoViewControler.scrollView)
                toViewController.view.alpha = 1
            })
            { (finished: Bool) -> Void in
                photoViewControler.imageView.hidden = false
                animateImageView.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        } else
        {
            var photoViewControler = fromViewController as PhotoViewController
            var animateImageView = UIImageView(image: photoViewControler.image)
            
            animateImageView.frame = window.convertRect(photoViewControler.imageView.frame, fromView: photoViewControler.scrollView)
            animateImageView.contentMode = photoViewControler.imageView.contentMode
            animateImageView.clipsToBounds = photoViewControler.imageView.clipsToBounds

            window.addSubview(animateImageView)
            fromViewController.view.alpha = 1
            photoViewControler.imageView.hidden = true
            
            UIView.animateWithDuration(0.4, animations:
            { () -> Void in
                // Animate here
                animateImageView.frame = window.convertRect(self.tappedImageView.frame, fromView: self.homeScrollView)
                animateImageView.contentMode = self.tappedImageView.contentMode
                animateImageView.clipsToBounds = self.tappedImageView.clipsToBounds
                fromViewController.view.alpha = 0
            })
            { (finished: Bool) -> Void in
                animateImageView.removeFromSuperview()
                fromViewController.view.removeFromSuperview()
                fromViewController.view.alpha = 1
                photoViewControler.imageView.hidden = false
                transitionContext.completeTransition(true)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var destinationViewControler = segue.destinationViewController as PhotoViewController
        destinationViewControler.image = tappedImageView.image
        
        destinationViewControler.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationViewControler.transitioningDelegate = self

    }

    @IBAction func onTapPhoto(sender: UITapGestureRecognizer)
    {
        var imageView = sender.view as UIImageView
        tappedImageView = imageView
        
        performSegueWithIdentifier("photoSegue", sender: self)
    }

}
