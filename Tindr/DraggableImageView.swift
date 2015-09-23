//
//  DraggableImageView.swift
//  Tindr
//
//  Created by Andrew Montgomery on 9/23/15.
//  Copyright (c) 2015 Sobococa. All rights reserved.
//

import UIKit

class DraggableImageView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    private var imageViewInitialCenter: CGPoint!
    private var imageViewInitialTapPoint: CGPoint!
    
    var image: UIImage? {
        get { return imageView.image }
        set { imageView.image = newValue }
    }
    
    @IBAction func onPan(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(contentView)
        let velocity = sender.velocityInView(contentView)
        
        if sender.state == UIGestureRecognizerState.Began {
            imageViewInitialCenter = imageView.center
            imageViewInitialTapPoint = sender.locationInView(contentView)
        } else if sender.state == UIGestureRecognizerState.Changed {
            //leftMarginConstraint.constant = originalLeftMargin + translation.x
            imageView.center = CGPoint(x: imageViewInitialCenter.x + translation.x, y: imageViewInitialCenter.y + translation.y)
            if imageViewInitialTapPoint.y <= (contentView.bounds.height / 2) {
                let fullRotationInRads = CGFloat(0.5) // about 45 degrees
                let perCentTranslated = -translation.x / (contentView.frame.size.width / 2)
                let currentRads = fullRotationInRads * perCentTranslated
                imageView.transform = CGAffineTransformMakeRotation(currentRads)
            } else {
                let fullRotationInRads = CGFloat(0.5) // about 45 degrees
                let perCentTranslated = translation.x / (contentView.frame.size.width / 2)
                let currentRads = fullRotationInRads * perCentTranslated
                imageView.transform = CGAffineTransformMakeRotation(currentRads)
            }
        } else if sender.state == UIGestureRecognizerState.Ended {
//            UIView.animateWithDuration(0.3, animations: { () -> Void in
//                self.imageView.center = self.imageViewInitialCenter
//            })
            UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 20, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.imageView.center = self.imageViewInitialCenter
                self.imageView.transform = CGAffineTransformIdentity
            }, completion: { (Bool) -> Void in
                
            })
        }

    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        // standard initialization logic
        let nib = UINib(nibName: "DraggableImageView", bundle: nil)
        nib.instantiateWithOwner(self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)

    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
