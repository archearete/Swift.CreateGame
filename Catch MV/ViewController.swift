//
//  ViewController.swift
//  Catch MV
//
//
//  Copyright © 2018. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mv1: UIImageView!
    @IBOutlet weak var mv2: UIImageView!
    @IBOutlet weak var mv3: UIImageView!
    @IBOutlet weak var mv4: UIImageView!
    @IBOutlet weak var mv5: UIImageView!
    @IBOutlet weak var mv6: UIImageView!
    @IBOutlet weak var mv7: UIImageView!
    @IBOutlet weak var mv8: UIImageView!
    @IBOutlet weak var mv9: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    
    var score = 0
    var counter = 0
    var timer = Timer()
    var hideTimer = Timer()
    var mvArray = [UIImageView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check the highscores
        
        let highScore = UserDefaults.standard.object(forKey: "highscore")
        if highScore == nil {
            highScoreLabel.text = "0"
        }
        
        if let newScore = highScore as? Int {
            highScoreLabel.text = String(newScore)
        }
        
        // creating user interaction with mv labels
        
        scoreLabel.text = "Score: \(score)"
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        
        mv1.addGestureRecognizer(recognizer1)
        mv2.addGestureRecognizer(recognizer2)
        mv3.addGestureRecognizer(recognizer3)
        mv4.addGestureRecognizer(recognizer4)
        mv5.addGestureRecognizer(recognizer5)
        mv6.addGestureRecognizer(recognizer6)
        mv7.addGestureRecognizer(recognizer7)
        mv8.addGestureRecognizer(recognizer8)
        mv9.addGestureRecognizer(recognizer9)
        
        mv1.isUserInteractionEnabled = true
        mv2.isUserInteractionEnabled = true
        mv3.isUserInteractionEnabled = true
        mv4.isUserInteractionEnabled = true
        mv5.isUserInteractionEnabled = true
        mv6.isUserInteractionEnabled = true
        mv7.isUserInteractionEnabled = true
        mv8.isUserInteractionEnabled = true
        mv9.isUserInteractionEnabled = true
        
        // creating timer
        
        counter = 30
        timeLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(ViewController.hideMv), userInfo: nil, repeats: true)
        
        // creating arrays
        
        mvArray.append(mv1)
        mvArray.append(mv2)
        mvArray.append(mv3)
        mvArray.append(mv4)
        mvArray.append(mv5)
        mvArray.append(mv6)
        mvArray.append(mv7)
        mvArray.append(mv8)
        mvArray.append(mv9)
        
        hideMv()
        
    }

    @objc func increaseScores (){
        
        // this is what happens when the recognizer gets called
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }
    
    @objc func countDown(){
        counter = counter - 1
        timeLabel.text = "\(counter)"
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            // checking highscores
            
            if self.score > Int(highScoreLabel.text!)!{
                
                UserDefaults.standard.set(self.score, forKey: "highscore")
                highScoreLabel.text = String(self.score)
            }
            
            // alert creation
            
            let alert = UIAlertController(title: "Time", message: "Your Time is Up", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(ok)
            
            let replay = UIAlertAction(title: "Replay", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                self.timeLabel.text = "\(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideMv), userInfo: nil, repeats: true)
            })
            
            alert.addAction(replay)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func hideMv(){
        
        for mv in mvArray {
            mv.isHidden = true
        }
        
        let randomNumber = Int(arc4random_uniform(UInt32(mvArray.count - 1)))
        mvArray[randomNumber].isHidden = false
    }
    
}

