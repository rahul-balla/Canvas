//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Rahul Balla on 3/9/18.
//  Copyright © 2018 Rahul Balla. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    
    var trayOriginalPoint: CGPoint!
    let trayDownOffset: CGFloat = 205
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x, y: trayView.center.y + trayDownOffset)

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        var velocity = sender.velocity(in: view)
        
        if (sender.state == .began){
            trayOriginalPoint = trayView.center
        }
        else if(sender.state == .changed){
            trayView.center = CGPoint(x: trayOriginalPoint.x, y: trayOriginalPoint.y + translation.y)
            
        }
        
        else if (sender.state == .ended){
            if (velocity.y > 0){
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {() -> Void in
                    self.trayView.center = self.trayDown
                }, completion: nil)
            }
            else{
                UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
                    self.trayView.center = self.trayUp
                }, completion: nil)
            }
        }
    }
    
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if(sender.state == .began){
            var imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            let panFaceGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
            let pinchFaceGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(sender:)))
            let rotateFaceGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(didRotate(sender:)))
            
            newlyCreatedFace.isUserInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panFaceGestureRecognizer)
            newlyCreatedFace.addGestureRecognizer(pinchFaceGestureRecognizer)
            newlyCreatedFace.addGestureRecognizer(rotateFaceGestureRecognizer)
            self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
        
        else if(sender.state == .changed){
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }
        
        else if (sender.state == .ended){
            self.newlyCreatedFace.transform = CGAffineTransform.identity
        }
    }
    
    @objc func didPan(sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: view)
        
        if(sender.state == .began){
            var imageView = sender.view as! UIImageView
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
            
        else if (sender.state == .changed){
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }
            
        else if (sender.state == .ended){
            self.newlyCreatedFace.transform = CGAffineTransform.identity

        }
    }
    
    @objc func didPinch(sender: UIPinchGestureRecognizer){
        
        if(sender.state == .began){
            let scale = sender.scale
            let imageView = sender.view as! UIImageView
            imageView.transform = newlyCreatedFace.transform.scaledBy(x: scale, y: scale)
            sender.scale = 1
        }
        else if(sender.state == .changed){
            let scale = sender.scale
            let imageView = sender.view as! UIImageView
            imageView.transform = newlyCreatedFace.transform.scaledBy(x: scale, y: scale)
            sender.scale = 1
        }
        
        else if(sender.state == .ended){
            
        }
    }
    
    @objc func didRotate(sender: UIRotationGestureRecognizer){
        let rotate = sender.rotation
        let imageView = sender.view as! UIImageView
        imageView.transform = newlyCreatedFace.transform.rotated(by: rotate)
        sender.rotation = 0
        
        if(sender.state == .began){
            let rotate = sender.rotation
            let imageView = sender.view as! UIImageView
            imageView.transform = newlyCreatedFace.transform.rotated(by: rotate)
            sender.rotation = 0
        }
        else if(sender.state == .changed){
            let rotate = sender.rotation
            let imageView = sender.view as! UIImageView
            imageView.transform = newlyCreatedFace.transform.rotated(by: rotate)
            sender.rotation = 0
        }
            
        else if(sender.state == .ended){
            
        }
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
