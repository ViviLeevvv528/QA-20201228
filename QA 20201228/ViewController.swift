//
//  ViewController.swift
//  QA 20201228
//
//  Created by Vivi Lee on 2020/12/28.
//
//    載入ui畫面
import UIKit
//    載入聲音
import AVFoundation
//    載入csv解析
import CodableCSV
//    設定csv匯入與定義欄位
struct music: Codable {
    let name: String
    let singer: String
    let musicURL: URL
    let image: [URL]
}
//    宣告讀取csv 產生的 data
extension music {
    static var data: [Self] {
        var array = [Self]()
        if let data = NSDataAsset(name: "musics")?.data {
            let decoder = CSVDecoder {
                $0.headerStrategy = .firstLine
            }
            do {
                array = try decoder.decode([Self].self, from: data)
            } catch {
                print(error)
            }
        }
        return array
    }
}


class ViewController: UIViewController {
//   定義問題
    @IBOutlet weak var questionLabel: UILabel!
//    定義答案
    @IBOutlet weak var answerLabel: UILabel!
//    定義答案歌手顯示照片
    @IBOutlet weak var singerImage: UIImageView!
    
//設定取用data
    let musics = music.data
// 設定question定義
    var questions = ""
    var index = 0

//    播放音樂的動作定義
    var player:AVAudioPlayer = AVAudioPlayer()
    @IBAction func play(_ sender: Any) {
        let player = AVPlayer()
        let fileUrl = musics[0].musicURL
        let playerItem = AVPlayerItem(url: url)
        player.play()
    }
    @IBAction func pause(_ sender: Any) {
        player.pause()
    }
    @IBAction func restart(_ sender: Any) {
        player.stop()
        player.play()
    }


    override func viewDidLoad() {
        super.viewDidLoad()


        let question = Question(description: "Listen the Music!", answer: musics(name: "")
        questions.append(question1)

        questions.shuffle()

        questionLabel.text = questions[index].description
        answerLabel.text = ""

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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

