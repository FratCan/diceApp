//
//  ViewController.swift
//  zarprojesi
//
//  Created by Trakya8 on 19.02.2025.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var diceImageView: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        leftDiceImage.image = UIImage(named: "1")
        rightDiceImage.image = UIImage(named: "1")
    }
    
    @IBOutlet weak var rollButton: UIButton!
    @IBOutlet weak var leftDiceImage: UIImageView!
    @IBOutlet weak var rightDiceImage: UIImageView!
    
    @IBAction func rollButtonTapped(_ sender: UIButton) {
        leftDiceImage.image = UIImage(named: String(arc4random_uniform(5)+1))
        rightDiceImage.image = UIImage(named: String(arc4random_uniform(5)+1))
    }
    func animateDiceRoll() {
        // Zarın dönmesi için 3D dönüş animasyonu
        let rotation = CATransform3DMakeRotation(CGFloat.random(in: 1...5) * .pi, 1.0, 1.0, 0.0) // X ve Y eksenlerinde dönme
        let animation = CABasicAnimation(keyPath: "transform")
        animation.toValue = NSValue(caTransform3D: rotation)
        animation.duration = 1.0 // Animasyon süresi
        animation.isCumulative = true
        animation.repeatCount = 2
        
        // Zarın döneceği animasyonu başlat
        diceImageView.layer.add(animation, forKey: "rotation")
    }
    
    func animateDiceSlowDown() {
        // Yavaşlama için zarın dönmesini yavaşça durdurma
        let slowDownAnimation = CABasicAnimation(keyPath: "transform.rotation")
        slowDownAnimation.toValue = 0 // Son durumda zar tamamen duracak
        slowDownAnimation.duration = 1.0
        slowDownAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        // Yavaşlama animasyonunu ekle
        diceImageView.layer.add(slowDownAnimation, forKey: "slowDown")
    }

    
    func stopDiceAnimation() {
        // Rastgele bir sayı seç (1-6 arası)
        let randomSide = Int.random(in: 1...6)
        let diceImageName = "dice\(randomSide).png"
        diceImageView.image = UIImage(named: "1") // Zarın son halini göster
    }
    
    @IBAction func rollDiceButtonTapped(_ sender: UIButton) {
        animateDiceRoll()
        
        // Zarı döndürdükten sonra 1 saniye sonra durması için bir gecikme ekleyelim
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.stopDiceAnimation() // Zar durduktan sonra rastgele bir sayıyı seç
        }
    }



    
}

