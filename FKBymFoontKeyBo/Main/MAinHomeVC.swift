//
//  MAinHomeVC.swift
//  FKBymFoontKeyBo
//
//  Created by JOJO on 2021/6/29.
//

import UIKit
import NoticeObserveKit
class MAinHomeVC: UIViewController {

    let topCoinLabel = UILabel()
    private var pool = Notice.ObserverPool()
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotificationObserver()
        setupBackActiveNotification()
        setupView()
    }
    
    func addNotificationObserver() {
        
        NotificationCenter.default.nok.observe(name: .pi_noti_coinChange) {[weak self] _ in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.topCoinLabel.text = "\(FKbCoinMana.default.coinCount)"
            }
        }
        .invalidated(by: pool)
        
         
    }
    
    func setupBackActiveNotification() {
        NotificationCenter.default.addObserver(self, selector:#selector(becomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        //注册进入后台的通知
        NotificationCenter.default.addObserver(self, selector:#selector(becomeDeath), name: UIApplication.willResignActiveNotification, object: nil)
    }
    @objc
    func becomeActive(noti:Notification){
        DispatchQueue.main.async {
            [weak self] in
            guard let `self` = self else {return}
            self.refreshTopCoin()
            
        }
        debugPrint("进入前台")
    }
    @objc
    func becomeDeath(noti:Notification){
        
        debugPrint("进入后台")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshTopCoin()
    }
    
    func refreshTopCoin() {
        FKbCoinMana.default.loadCoinCountFromGroup()
        
        topCoinLabel.text = "\(FKbCoinMana.default.coinCount)"
    }
    
    func setupView() {
        view.backgroundColor = .white
        
        //
        let settingBtn = UIButton(type: .custom)
        view.addSubview(settingBtn)
        settingBtn.setImage(UIImage(named: "home_ic_setting"), for: .normal)
        settingBtn.snp.makeConstraints {
            $0.left.equalTo(10)
            $0.width.height.equalTo(44)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        settingBtn.addTarget(self, action: #selector(settingBtnClick(sender:)), for: .touchUpInside)
        
        //
        topCoinLabel.textAlignment = .right
        topCoinLabel.text = "\(FKbCoinMana.default.coinCount)"
        topCoinLabel.textColor = UIColor(hexString: "#000000")
        topCoinLabel.font = UIFont(name: "Verdana-Bold", size: 18)
        view.addSubview(topCoinLabel)
        topCoinLabel.snp.makeConstraints {
            $0.centerY.equalTo(settingBtn)
            $0.right.equalTo(-18)
            $0.height.greaterThanOrEqualTo(35)
            $0.width.greaterThanOrEqualTo(25)
        }
        //
        let coinImageV = UIImageView()
        coinImageV.image = UIImage(named: "home_ic_coin")
        coinImageV.contentMode = .scaleAspectFit
        view.addSubview(coinImageV)
        coinImageV.snp.makeConstraints {
            $0.centerY.equalTo(settingBtn)
            $0.right.equalTo(topCoinLabel.snp.left).offset(-8)
            $0.width.equalTo(24)
            $0.height.equalTo(17)
        }
        //
        let coinBtn = UIButton(type: .custom)
        view.addSubview(coinBtn)
        coinBtn.setImage(UIImage(named: ""), for: .normal)
        coinBtn.snp.makeConstraints {
            $0.left.equalTo(coinImageV)
            $0.right.equalTo(topCoinLabel)
            $0.centerY.equalTo(topCoinLabel)
            $0.height.equalTo(40)
        }
        coinBtn.addTarget(self, action: #selector(coinBtnClick(sender:)), for: .touchUpInside)
        //
        let bgImgV = UIImageView(image: UIImage(named: "home_background"))
        view.addSubview(bgImgV)
        bgImgV.contentMode = .scaleAspectFill
        bgImgV.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-70)
            $0.height.greaterThanOrEqualTo(UIScreen.main.bounds.width / (828 / 1112))
        }
        
        
        
        //
        let howToBtn = UIButton(type: .custom)
        view.addSubview(howToBtn)
        howToBtn.addTarget(self, action: #selector(howtoBtnClick(sender:)), for: .touchUpInside)
        howToBtn.setTitle("How To Use", for: .normal)
        howToBtn.setTitleColor(.white, for: .normal)
        howToBtn.backgroundColor = UIColor(hexString: "#5715FF")
        howToBtn.layer.cornerRadius = 14
        howToBtn.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 20)
        howToBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(354)
            $0.height.equalTo(64)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-80)
        }
        //
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.text = "Fonts Keyboared"
        nameLabel.textColor = UIColor(hexString: "#000000")
        nameLabel.font = UIFont(name: "Verdana-Bold", size: 20)
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.bottom.equalTo(howToBtn.snp.top).offset(-60)
            $0.centerX.equalToSuperview()
            $0.height.greaterThanOrEqualTo(25)
            $0.width.greaterThanOrEqualTo(25)
        }
        
        let textFeild = UITextField()
        textFeild.backgroundColor = UIColor.white
//        view.addSubview(textFeild)
//        textFeild.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
//            $0.centerX.equalToSuperview()
//            $0.left.equalTo(20)
//            $0.right.equalTo(-20)
//            $0.height.equalTo(150)
//        }
        
        
    }
    
    @objc func settingBtnClick(sender: UIButton) {
        self.navigationController?.pushViewController(KFSEttingVC())
    }
    @objc func coinBtnClick(sender: UIButton) {
        self.navigationController?.pushViewController(KFSToreVC())
    }
    @objc func howtoBtnClick(sender: UIButton) {
        
        self.navigationController?.pushViewController(KFHowUseVC())
        
    }
    
}
