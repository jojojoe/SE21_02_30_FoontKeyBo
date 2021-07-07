//
//  KFHowUseVC.swift
//  FKBymFoontKeyBo
//
//  Created by JOJO on 2021/7/2.
//

import UIKit

class KFHowUseVC: UIViewController {
    
    var collection: UICollectionView!
    let pagecontrol = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        
    }
    
    func setupView() {
        //
        let topBanner = UIView()
        topBanner.backgroundColor = UIColor(hexString: "#5715FF")
        view.addSubview(topBanner)
        topBanner.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        //
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = UIColor(hexString: "#5715FF")
        collection.isPagingEnabled = true
        collection.delegate = self
        collection.dataSource = self
        view.addSubview(collection)
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = width * (1404 / 1242)
        collection.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.right.left.equalToSuperview()
            $0.height.equalTo(height)
        }
        collection.register(cellWithClass: KFHowUseCell.self)
        
        //
        let backBtn = UIButton(type: .custom)
        view.addSubview(backBtn)
        backBtn.addTarget(self, action: #selector(backBtnClick(sender:)), for: .touchUpInside)
        backBtn.setImage(UIImage(named: "store_ic_back"), for: .normal)
        backBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            $0.left.equalTo(10)
            $0.width.height.equalTo(44)
        }
        //
        
        pagecontrol.numberOfPages = 2
        pagecontrol.currentPage = 0
        pagecontrol.pageIndicatorTintColor = UIColor(hexString: "#D6D6D6")
        
        pagecontrol.currentPageIndicatorTintColor = UIColor(hexString: "#5715FF")
        view.addSubview(pagecontrol)
        pagecontrol.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(collection.snp.bottom).offset(24)
            $0.width.greaterThanOrEqualTo(30)
            $0.height.greaterThanOrEqualTo(10)
        }
        
        //
        let touserBtn = UIButton(type: .custom)
        view.addSubview(touserBtn)
        touserBtn.setTitle("Set Up Now", for: .normal)
        touserBtn.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 20)
        touserBtn.layer.cornerRadius = 14
        touserBtn.setTitleColor(UIColor.white, for: .normal)
        touserBtn.backgroundColor = UIColor(hexString: "#5715FF")
        touserBtn.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(354)
            $0.height.equalTo(64)
        }
        touserBtn.addTarget(self, action: #selector(touserBtnClick(sender:)), for: .touchUpInside)
        
        
    }
     
    
    @objc func touserBtnClick(sender: UIButton) {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:])
        }
    }

    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension KFHowUseVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: KFHowUseCell.self, for: indexPath)
        var iconImgName = "step1"
        if indexPath.item == 1 {
            iconImgName = "step2"
        }
        
        cell.contentImgV.image = UIImage(named: iconImgName)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension KFHowUseVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = width * (1404 / 1242)
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension KFHowUseVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let indexPATH = collection.indexPathForItem(at: CGPoint(x: collection.contentOffset.x + UIScreen.main.bounds.width / 2, y: 200)) {
            pagecontrol.currentPage = indexPATH.item
        }
        
    }
}


class KFHowUseCell: UICollectionViewCell {
    let contentImgV = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentImgV.contentMode = .scaleAspectFit
        contentImgV.clipsToBounds = true
        contentView.addSubview(contentImgV)
        contentImgV.snp.makeConstraints {
            $0.top.right.bottom.left.equalToSuperview()
        }
        
        
    }
}

