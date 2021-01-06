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
    let image: [URL]
//    宣告圖片的進階寫法
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            name = try container.decode(String.self, forKey: .name)
            singer = try container.decode(String.self, forKey: .singer)
            musicURL = try container.decode(URL.self, forKey: .musicURL)
        let imagesString = try container.decode(String.self, forKey: .image)
        image = imagesString.components(separatedBy: ",").map {
                  URL(string: $0.components(separatedBy: "(")[1].replacingOccurrences(of: ")", with: ""))!
            }
        print(image[0])
        }
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
    
    @IBOutlet weak var answerSingerLabel: UILabel!
//    定義答案歌手顯示照片
    @IBOutlet weak var singerImage: UIImageView!
    
//    播放音樂的動作定義
    let player = AVPlayer()
    @IBAction func play(_ sender: Any) {
    autoplay()
    }
//    設定自動播放功能
    func autoplay() {
        let fileUrl = musics[random].musicURL
        let playerItem = AVPlayerItem(url: fileUrl)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    @IBAction func pause(_ sender: Any) {
        player.pause()
    }
    @IBAction func restart(_ sender: Any) {
//        player.stop()
        player.seek(to: .zero) //因為stop音樂功能不支援了 改成寫指定到時間0
        player.play()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
//設定點選顯示答案要出現的內容
    @IBAction func showAnswerBtn(_ sender: UIButton) {
        answerLabel.text = musics[random].name
        answerSingerLabel.text = musics[random].singer
        singerImage.image = try? UIImage(data: Data(contentsOf: musics[random].image[0]))
        
    }
//    設定點選下一首的功能跟動作
    @IBAction func nextBtn(_ sender: UIButton) {
        player.pause()
        random = Int.random(in: 0...44)
        autoplay()
        answerLabel.text = ""
        answerSingerLabel.text = ""
        singerImage.image = UIImage(named: "microphone")

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
}

