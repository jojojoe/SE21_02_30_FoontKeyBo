//
//  KFSEttingVC.swift
//  FKBymFoontKeyBo
//
//  Created by JOJO on 2021/6/29.
//

import UIKit
import MessageUI
import StoreKit
import Defaults
import DeviceKit


let AppName: String = "AesFonts"
let purchaseUrl = ""
let TermsofuseURLStr = "http://glossy-skirt.surge.sh/Terms_of_use.html"
let PrivacyPolicyURLStr = "http://slippery-relation.surge.sh/Privacy_Agreement.html"
let feedbackEmail: String = "bushydaxcih@yandex.com"
let AppAppStoreID: String = ""



class KFSEttingVC: UIViewController {

    let backBtn = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .white
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
        namelabel.text = "Setting"
        view.addSubview(namelabel)
        namelabel.adjustsFontSizeToFitWidth = true
        namelabel.snp.makeConstraints {
            $0.centerY.equalTo(backBtn)
            $0.centerX.equalToSuperview()
            $0.width.greaterThanOrEqualTo(1)
            $0.height.greaterThanOrEqualTo(1)
        }
        //
        let bgImgV = UIImageView(image: UIImage(named: "seeting_background"))
        view.addSubview(bgImgV)
        bgImgV.contentMode = .scaleAspectFill
        bgImgV.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.greaterThanOrEqualTo(1)
        }
        //
        let privacyBtn = UIButton(type: .custom)
        privacyBtn.backgroundColor = UIColor.white
        privacyBtn.layer.cornerRadius = 14
        view.addSubview(privacyBtn)
        privacyBtn.setTitle("Privacy Policy", for: .normal)
        privacyBtn.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 18)
        privacyBtn.setTitleColor(.black, for: .normal)
        privacyBtn.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.equalTo(30)
            $0.height.equalTo(64)
        }
        privacyBtn.addTarget(self, action: #selector(privacyBtnClick(sender:)), for: .touchUpInside)
        //
        let feedBtn = UIButton(type: .custom)
        feedBtn.backgroundColor = UIColor.white
        feedBtn.layer.cornerRadius = 14
        view.addSubview(feedBtn)
        feedBtn.setTitle("Feedback", for: .normal)
        feedBtn.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 18)
        feedBtn.setTitleColor(.black, for: .normal)
        feedBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(privacyBtn.snp.top).offset(-32)
            $0.left.equalTo(30)
            $0.height.equalTo(64)
        }
        feedBtn.addTarget(self, action: #selector(feedBtnClick(sender:)), for: .touchUpInside)
        //
        let termBtn = UIButton(type: .custom)
        termBtn.backgroundColor = UIColor.white
        termBtn.layer.cornerRadius = 14
        view.addSubview(termBtn)
        termBtn.setTitle("Term of use", for: .normal)
        termBtn.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 18)
        termBtn.setTitleColor(.black, for: .normal)
        termBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(privacyBtn.snp.bottom).offset(32)
            $0.left.equalTo(30)
            $0.height.equalTo(64)
        }
        termBtn.addTarget(self, action: #selector(termBtnClick(sender:)), for: .touchUpInside)
        
    }
    
    
    @objc func privacyBtnClick(sender: UIButton) {
        UIApplication.shared.openURL(url: PrivacyPolicyURLStr)
    }
    @objc func feedBtnClick(sender: UIButton) {
        feedback()
    }
    @objc func termBtnClick(sender: UIButton) {
        UIApplication.shared.openURL(url: TermsofuseURLStr)
    }
    
    
    

}

extension KFSEttingVC {
    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension KFSEttingVC: MFMailComposeViewControllerDelegate {
    func feedback() {
        //首先要判断设备具不具备发送邮件功能
        if MFMailComposeViewController.canSendMail(){
            //获取系统版本号
            let systemVersion = UIDevice.current.systemVersion
            let modelName = UIDevice.current.modelName
            
            let infoDic = Bundle.main.infoDictionary
            // 获取App的版本号
            let appVersion = infoDic?["CFBundleShortVersionString"] ?? "8.8.8"
            // 获取App的名称
            let appName = "\(AppName)"

            
            let controller = MFMailComposeViewController()
            //设置代理
            controller.mailComposeDelegate = self
            //设置主题
            controller.setSubject("\(appName) Feedback")
            //设置收件人
            // FIXME: feed back email
            controller.setToRecipients([feedbackEmail])
            //设置邮件正文内容（支持html）
         controller.setMessageBody("\n\n\nSystem Version：\(systemVersion)\n Device Name：\(modelName)\n App Name：\(appName)\n App Version：\(appVersion )", isHTML: false)
            
            //打开界面
            self.present(controller, animated: true, completion: nil)
        }else{
            HUD.error("The device doesn't support email")
        }
    }
    
    //发送邮件代理方法
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
    }
 }
