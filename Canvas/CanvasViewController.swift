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
                UIView.animate(withDuration: 0.3, animations: {
                    self.trayView.center = self.trayDown
                })
            }
            else{
                UIView.animate(withDuration: 0.3, animations: {
                    self.trayView.center = self.trayUp
                })
            }
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
