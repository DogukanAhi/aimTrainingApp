//
//  ViewController.swift
//  aimTraining
//
//  Created by Doğukan Ahi on 10.07.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timelabel: UILabel!
    
    @IBOutlet weak var scorelabel: UILabel!
    
    @IBOutlet weak var hitormiss: UILabel!
    
    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var highscorelabel: UILabel!
    
    @IBOutlet weak var missArea: UIImageView!
    
    var timer = Timer()
    var counter = 10
    var highscore = 0
    var randomX = Int.random(in: 0...273)
    var randomY = Int.random(in: 202...630)
    var randomHeight = Int.random(in: 50...100)
    var randomWidth = Int.random(in: 30...100)
    var score = 0
    var isHit = true
    var  imagevelocity : Double = 1
    let alert = UIAlertController(title: "Training Finished", message: "Would You Like to Try Again?", preferredStyle: UIAlertController.Style.alert)
   override func viewDidLoad() {
        super.viewDidLoad()
        let storedScore = UserDefaults.standard.object(forKey: "score")
        hitormiss.text = ""
        timelabel.text = "Time Left: 10"
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageClicked))
        imageview.addGestureRecognizer(gestureRecognizer)
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(missedClicked))
        
        missArea.addGestureRecognizer(gestureRecognizer2)
        imageview.isUserInteractionEnabled = true
        missArea.isUserInteractionEnabled = true
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countlabel), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(imagevelocity), target: self, selector: #selector(imagerotation), userInfo: nil, repeats: true)
     
        if let wscore = storedScore as? Int {
            UserDefaults.standard.set(scorelabel.text!, forKey: "score")
            if wscore>highscore{
                highscore = wscore
                highscorelabel.text = "High Score: \(highscore)"
            }
        }
    }
 
    @objc func missedClicked(){
        hitormiss.textColor = UIColor.red
        hitormiss.text = "Miss"
        counter-=1
        score-=1
        scorelabel.text = "Score: \(score)"
        timelabel.text = "Time Left: \(counter)"
        if score > 3 {
            imagevelocity = 0.2
            score-=2
            counter-=2
        }
        else if score > 5 {
            imagevelocity = 0.050
            counter-=3
            score-=2
        }
        else if score == 0 || score < 0{
            timelabel.text = "Time Left: \(counter)"
            self.present(alert,animated: true)
            let okButton = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default)
            alert.addAction(okButton)
            timer.invalidate()
        }
    }
    @objc func imageClicked(){
        score+=1
        scorelabel.text = "Score: \(score)"
        counter+=2
        hitormiss.textColor = UIColor.green
        hitormiss.text = "Hit"
        if score > 3 {
            imagevelocity = 0.2
            score+=1
            counter+=2
        }
        else if score > 5 {
            imagevelocity = 0.050
            counter+=2
            score+=1
        }
        if counter == 0 {
            timelabel.text = "Time Left: \(counter)"
            self.present(alert,animated: true)
            let okButton = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default)
            alert.addAction(okButton)
            timer.invalidate()
        }
        else if score == 0 || score < 0{
            score = 0
            timelabel.text = "Time Left: \(counter)"
            self.present(alert,animated: true)
            let okButton = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default)
            alert.addAction(okButton)
            timer.invalidate()
            performSegue(withIdentifier: "firstpage", sender: nil)
        }
    }
    
    
    @objc func countlabel (){
        if counter == 0 {
            timelabel.text = "Time Left: \(counter)"
            self.present(alert,animated: true)
            let okButton = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default)
            alert.addAction(okButton)
            
        }
        timelabel.text = "Time Left: \(counter)"
        counter -= 1

        
    }
    
    
    @objc func imagerotation(){
        randomX = Int.random(in: 0...273)
        randomY = Int.random(in: 202...630)
        randomHeight = Int.random(in: 50...100)
        randomWidth = Int.random(in: 30...100)
        imageview.frame = CGRect(x: randomX, y : randomY, width: randomWidth, height: randomHeight)
        hitormiss.text = ""
        
    }
    }
