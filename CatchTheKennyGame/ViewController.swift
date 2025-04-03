import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var Tİme: UILabel!
    @IBOutlet weak var Kenny: UIImageView!
    @IBOutlet weak var HighScoreLabel: UILabel!
    
    var score = 0
    var counter = 10
    var timer = Timer()
    
    func restartGame() {
        score = 0
        counter = 10
        ScoreLabel.text = "Score: \(score)"
        Tİme.text = "\(counter)"
        
        // Eğer timer çalışıyorsa önce durdur
        timer.invalidate()
        
        // Yeni geri sayımı başlat
        startCountdown()
    }
    
    func MakeAlert() {
        let alert = UIAlertController(title: "Game Over", message: "Süre Bitti", preferredStyle: .alert)
        let restartButton = UIAlertAction(title: "Restart", style: .default) { _ in
            self.restartGame()
        }
        alert.addAction(restartButton)
        self.present(alert, animated: true)
        
        let highScore = UserDefaults.standard.integer(forKey: "highScore")
        if score > highScore {
            UserDefaults.standard.set(score, forKey: "highScore")
        }
        
        let storedScore = UserDefaults.standard.integer(forKey: "highScore")
        HighScoreLabel.text = "High Score: \(storedScore)"
    }
    
    func startCountdown() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }
    
    @objc func updateCountdown() {
        if counter > 0 {
            counter -= 1
            Tİme.text = "\(counter)"
        } else {
            timer.invalidate()
            Tİme.text = "Süre bitti!"
            MakeAlert()
        }
    }
    
    func StartMovement() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            let Randomx = CGFloat.random(in: 0...(self.view.bounds.width - self.Kenny.frame.width))
            let Randomy = CGFloat.random(in: 0...(self.view.bounds.height - self.Kenny.frame.height))
            UIView.animate(withDuration: 0.4) {
                self.Kenny.frame.origin = CGPoint(x: Randomx, y: Randomy)
            }
        }
    }
    
    @objc func UpScore() {
        score += 1
        ScoreLabel.text = "Score: \(score)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HighScoreLabel.text = "High Score: "
        StartMovement()
        startCountdown()
        
        Kenny.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UpScore))
        gestureRecognizer.delaysTouchesBegan = false
        gestureRecognizer.cancelsTouchesInView = false // Dokunma algılama gecikmesini önler
        Kenny.addGestureRecognizer(gestureRecognizer)
        
        let storedScore = UserDefaults.standard.integer(forKey: "highScore")
        HighScoreLabel.text = "High Score: \(storedScore)"
    }
}
