//
//  KFSToreVC.swift
//  FKBymFoontKeyBo
//
//  Created by JOJO on 2021/6/29.
//

import UIKit
import NoticeObserveKit
import StoreKit
import Adjust
import SwiftyStoreKit

class KFSToreVC: UIViewController {
    let backBtn = UIButton(type: .custom)
    private var pool = Notice.ObserverPool()
    let topCoinLabel = UILabel()
    var collection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
        setupView()
        setupCollection()
        addNotificationObserver()
    }
    
    func addNotificationObserver() {
        
        NotificationCenter.default.nok.observe(name: .pi_noti_coinChange) {[weak self] _ in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.topCoinLabel.text = "Balance:\(FKbCoinMana.default.coinCount)"
            }
        }
        .invalidated(by: pool)
        
        NotificationCenter.default.nok.observe(name: .pi_noti_priseFetch) { [weak self] _ in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.collection.reloadData()
            }
        }
        .invalidated(by: pool)
    }
    
    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension KFSToreVC {
    func setupView() {
        //
        view.addSubview(backBtn)
        backBtn.addTarget(self, action: #selector(backBtnClick(sender:)), for: .touchUpInside)
        backBtn.setImage(UIImage(named: "store_ic_back"), for: .normal)
        backBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            $0.left.equalTo(10)
            $0.width.height.equalTo(44)
        }
        //
        let namelabel = UILabel()
        namelabel.font = UIFont(name: "Verdana-Bold", size: 20)
        namelabel.textColor = UIColor(hexString: "#000000")
        namelabel.textAlignment = .center
        namelabel.text = "Store"
        view.addSubview(namelabel)
        namelabel.adjustsFontSizeToFitWidth = true
        namelabel.snp.makeConstraints {
            $0.centerY.equalTo(backBtn)
            $0.centerX.equalToSuperview()
            $0.width.greaterThanOrEqualTo(1)
            $0.height.greaterThanOrEqualTo(1)
        }
        //
        let coinImageV = UIImageView()
        coinImageV.image = UIImage(named: "store_balance_coin")
        coinImageV.contentMode = .scaleAspectFit
        view.addSubview(coinImageV)
        coinImageV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(namelabel.snp.bottom).offset(25)
            $0.width.equalTo(240/2)
            $0.height.equalTo(174/2)
        }
        //
        topCoinLabel.textAlignment = .right
        topCoinLabel.text = "Balance:\(FKbCoinMana.default.coinCount)"
        topCoinLabel.textColor = UIColor(hexString: "#000000")
        topCoinLabel.font = UIFont(name: "Verdana-Bold", size: 20)
        view.addSubview(topCoinLabel)
        topCoinLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(coinImageV.snp.bottom).offset(18)
            $0.height.greaterThanOrEqualTo(25)
            $0.width.greaterThanOrEqualTo(25)
        }
    }
    
    func setupCollection() {
        
        // collection
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        //        collection.layer.cornerRadius = 35
        collection.layer.masksToBounds = true
        collection.delegate = self
        collection.dataSource = self
        view.addSubview(collection)
        collection.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalTo(topCoinLabel.snp.bottom).offset(20)
            $0.right.equalToSuperview()
            $0.bottom.equalTo(view.snp.bottom)
        }
        collection.register(cellWithClass: IHymStoreCell.self)
        
    }
    
    
    func selectCoinItem(item: StoreItem) {
        FKbCoinMana.default.purchaseIapId(item: item) { (success, errorString) in
            
            if success {
                self.showAlert(title: "Purchase successful.", message: "")
            } else {
                self.showAlert(title: "Purchase failed.", message: errorString)
            }
        }
    }
    
    
}



extension KFSToreVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: IHymStoreCell.self, for: indexPath)
        let item = FKbCoinMana.default.coinIpaItemList[indexPath.item]
        cell.coinCountLabel.text = "X\(item.coin)"
        cell.priceLabel.text = item.price
        if indexPath.item <= 2 {
            cell.iconImgV.image = UIImage(named: "store_coin_1")
        } else if indexPath.item <= 5 {
            cell.iconImgV.image = UIImage(named: "store_coin_2")
        } else {
            cell.iconImgV.image = UIImage(named: "store_coin_3")
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FKbCoinMana.default.coinIpaItemList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension KFSToreVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 108, height: 155)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let left = ((UIScreen.main.bounds.width - (108 * 3) - (12 * 2) - 0.5) / 2)
        return UIEdgeInsets(top: 10, left: left, bottom: 30, right: left)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
}

extension KFSToreVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = FKbCoinMana.default.coinIpaItemList[safe: indexPath.item] {
            selectCoinItem(item: item)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}





class IHymStoreCell: UICollectionViewCell {
    
    var bgView: UIView = UIView()
    
    var bgImageV: UIImageView = UIImageView()
    var coverImageV: UIImageView = UIImageView()
    var coinCountLabel: UILabel = UILabel()
    var priceLabel: UILabel = UILabel()
    let iconImgV = UIImageView(image: UIImage(named: "store_ic_heart"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        backgroundColor = UIColor.clear
        bgView.backgroundColor = .clear
        contentView.addSubview(bgView)
        bgView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        //
        bgImageV.backgroundColor = .clear
        bgImageV.contentMode = .scaleAspectFit
        bgImageV.image = UIImage(named: "")
        bgImageV.layer.masksToBounds = true
        bgImageV.layer.cornerRadius = 8
        
        bgImageV.layer.borderColor =     UIColor(hexString: "#5715FF")?.withAlphaComponent(0.11).cgColor
        bgImageV.layer.borderWidth = 2
        bgView.addSubview(bgImageV)
        bgImageV.snp.makeConstraints {
            $0.left.right.bottom.top.equalToSuperview()
        }
        
        //
        
        iconImgV.contentMode = .scaleAspectFit
        bgView.addSubview(iconImgV)
        iconImgV.snp.makeConstraints {
            $0.top.equalTo(18)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(132/2)
            $0.height.equalTo(80/2)
        }
        
        //
        coinCountLabel.adjustsFontSizeToFitWidth = true
        coinCountLabel.textColor = UIColor(hexString: "#000000")
        //        coinCountLabel.layer.shadowColor = UIColor(hexString: "#FFE7A8")?.cgColor
        //        coinCountLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        //        coinCountLabel.layer.shadowRadius = 3
        //        coinCountLabel.layer.shadowOpacity = 0.8
        
        coinCountLabel.numberOfLines = 1
        coinCountLabel.textAlignment = .center
        coinCountLabel.font = UIFont(name: "Verdana-Bold", size: 16)
        coinCountLabel.adjustsFontSizeToFitWidth = true
        bgView.addSubview(coinCountLabel)
        coinCountLabel.snp.makeConstraints {
            $0.top.equalTo(iconImgV.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.left.equalTo(6)
            $0.height.greaterThanOrEqualTo(1)
        }
        
        //
        //        coverImageV.image = UIImage(named: "home_button")
        //        coverImageV.contentMode = .center
        //        bgView.addSubview(coverImageV)
        //
        //
        priceLabel.backgroundColor = UIColor(hexString: "#5715FF")
        priceLabel.textColor = UIColor(hexString: "#FFFFFF")
        priceLabel.font = UIFont(name: "Verdana-Bold", size: 16)
        priceLabel.textAlignment = .center
        bgView.addSubview(priceLabel)
        priceLabel.layer.cornerRadius = 18
        //        priceLabel.layer.shadowColor = UIColor(hexString: "#FF12D2")?.cgColor
        //        priceLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        //        priceLabel.layer.shadowRadius = 3
        //        priceLabel.layer.shadowOpacity = 0.8
        
        
        //        priceLabel.backgroundColor = UIColor(hexString: "#4AD0EF")
        //        priceLabel.cornerRadius = 30
        priceLabel.adjustsFontSizeToFitWidth = true
        //        priceLabel.layer.borderWidth = 2
        //        priceLabel.layer.borderColor = UIColor.white.cgColor
        priceLabel.snp.makeConstraints {
            $0.width.equalTo(90)
            $0.height.equalTo(36)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(-17)
        }
        
        //        coverImageV.snp.makeConstraints {
        //            $0.center.equalTo(priceLabel.snp.center)
        //            $0.width.equalTo(135)
        //            $0.height.equalTo(54)
        //        }
    }
    
}




