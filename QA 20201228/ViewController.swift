//
//  ViewController.swift
//  QA 20201228
//
//  Created by Vivi Lee on 2020/12/28.
//

import UIKit
import AVFoundation
import CodableCSV

class ViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var singerImage: UIImageView!
    
    var player:AVAudioPlayer = AVAudioPlayer()
    
    var questions = [Question]()
    var index = 0
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        struct musics: Codable {
            let name: String
            let singer: String
            let music: URL
            let image:UIImageView
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let question1 = Question(description: "Listen the Music!", answer: "vivi")
        questions.append(question1)
        let question2 = Question(description: "住哪", answer: "台中")
        questions.append(question2)
        let question3 = Question(description: "幾歲", answer: "26")
        questions.append(question3)
        
        questions.shuffle()
        
        questionLabel.text = questions[index].description
        answerLabel.text = ""

    }
    @IBAction func play(_ sender: Any) {
    }
    @IBAction func pause(_ sender: Any) {
    }
    @IBAction func restart(_ sender: Any) {
    }
    
    @IBAction func showAnswerBtn(_ sender: UIButton) {
        answerLabel.text = questions[index].answer
    }
    @IBAction func nextBtn(_ sender: UIButton) {
//        if index < questions.count - 1 {
        index = index + 1
            if index == questions.count{
                index = 0
            }
        questionLabel.text = questions[index].description
        answerLabel.text = ""
    }
        
    

    


    }


