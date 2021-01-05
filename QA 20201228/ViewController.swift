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
var name = ""
var random = Int.random(in: 0...44)
//    載入csv解析
import CodableCSV
//    設定csv匯入與定義欄位
struct music: Codable {
    let name: String
    let singer: String
    let musicURL: URL
//    let image: [URL]
//    init(from decoder: Decoder) throws {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//            name = try container.decode(String.self, forKey: .name)
//            singer = try container.decode(String.self, forKey: .singer)
//            musicURL = try container.decode(URL.self, forKey: .musicURL)
//        let imagesString = try container.decode(String.self, forKey: .image)
//        image = imagesString.components {
//                  URL(string: $0.components[0])!
//            }
//
        }

//    宣告讀取csv 產生的 data
extension music {
    static var data: [Self] {
        var array = [Self]()
        if let data = NSDataAsset(name: "music")?.data {
            let decoder = CSVDecoder {
                $0.headerStrategy = .firstLine
            }
            do {
                array = try decoder.decode([Self].self, from: data)
            } catch {
                print(error)
                print("loooooook here")
            }
        }
        return array
    }
}


class ViewController: UIViewController {
    //設定取用data
        var musics = music.data
    // 設定question定義
        var questions = ""
        var index = 0
    
//   定義問題
    @IBOutlet weak var questionLabel: UILabel!
//    定義答案
    @IBOutlet weak var answerLabel: UILabel!
//    let answerSong = "musics[0].name"
//    定義答案歌手顯示照片
    @IBOutlet weak var singerImage: UIImageView!
    


//    播放音樂的動作定義
//    var player:AVAudioPlayer = AVAudioPlayer()
    let player = AVPlayer()
    @IBAction func play(_ sender: Any) {
        let fileUrl = musics[random].musicURL
        let playerItem = AVPlayerItem(url: fileUrl)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        print(random)
    }
    @IBAction func pause(_ sender: Any) {
        player.pause()
    }
    @IBAction func restart(_ sender: Any) {
//        player.stop()
        player.seek(to: .zero) //因為stop音樂功能好像不支援了 改成寫指定到時間0
        player.play()
    }


    override func viewDidLoad() {
        super.viewDidLoad()

//        let question = Question(description: "Play the Music!", answer: "musics[0].name"
//        questions.append(question1)
//
//        questions.shuffle()
//
//        questionLabel.text = questions[index].description
//        answerLabel.text = ""

    }

    @IBAction func showAnswerBtn(_ sender: UIButton) {
        answerLabel.text = musics[random].name
//        singerImage.image = UIImage(named: musics[random].image)
        
    }
    @IBAction func nextBtn(_ sender: UIButton) {
        
////        if index < questions.count - 1 {
//        index = index + 1
//            if index == questions.count{
//                index = 0
//            }
//        questionLabel.text = questions[index].description
//        answerLabel.text = ""
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

