//
//  ViewController.swift
//  TechtaGram
//
//  Created by 原 あゆみ on 2016/04/02.
//  Copyright © 2016年 原 あゆみ. All rights reserved.
//

import UIKit

import AssetsLibrary

import Accounts

class ViewController: UIViewController,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    @IBOutlet var cameraImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var originalImage : UIImage!
    var filteredImages: Array<(String, UIImage)> = []
    var filter : CIFilter!
    var filerUtil : FilterUtil = FilterUtil()
    
    var curveImageView : UIImage! = nil
    var grayImageView : UIImage! = nil
    var sepiaImageView : UIImage! = nil
    var filter1ImageView : UIImage! = nil
    var filter2ImageView : UIImage! = nil
    var filterfadeImageView : UIImage! = nil
    var filterniseImageView : UIImage! = nil
    var filterhanImageView : UIImage! = nil
    var filterinstantImageView : UIImage! = nil
    var filterprocessImageView : UIImage! = nil
    var filterchromeImageView : UIImage! =  nil
    var filterblurImageView : UIImage! = nil
    
    //var assetCollection: PHAssetCollection!
    
    @IBAction func test(_ sender: AnyObject) {
        for i in 0...11 {
            filteredImages.append(setImage(indexPath: i))
        }
        show()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        /*  let originalImage =
         let blurImage = FilterUtil().blur(originalImage, radius: 3)
         print("\(originalImage.size) -> \(filterblurImageView.size)")
         view.addSubview(UIImageView(image: blurImage)) */
        
        
    }
    
    
    func imageTapped(sender: UITapGestureRecognizer) {
        print("@@@@@@@")
    }
    
    @IBAction func selected(sender: AnyObject) {
        curveImageView  = nil
        grayImageView  = nil
        sepiaImageView = nil
        filter1ImageView = nil
        filter2ImageView = nil
        filterfadeImageView = nil
        filterniseImageView = nil
        filterhanImageView = nil
        filterinstantImageView = nil
        filterprocessImageView = nil
        filterchromeImageView = nil
        filterblurImageView = nil
        
        let imagePikerContoroller: UIImagePickerController = UIImagePickerController()
        imagePikerContoroller.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePikerContoroller.allowsEditing = true
        self.present(imagePikerContoroller, animated: true, completion: nil)
        imagePikerContoroller.delegate = self
    }
    
    func show() {
        let nib:UINib = UINib(nibName: "CustomCollectionViewCell",bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func  setImage(indexPath : Int) -> (String, UIImage) {
        
        switch indexPath {
        case 0:
            if curveImageView == nil {
                curveImageView = filerUtil.colorFiltercurve(originalImage: originalImage)
            }
            //セピアの結果を返す
            return("カーブ",curveImageView)
        case 1:
            if grayImageView == nil{
                grayImageView = filerUtil.colorFiltergrey(originalImage: originalImage)
            }
            //グレイの結果を返す
            return("グレイ",grayImageView)
        case 2:
            
            if sepiaImageView  == nil{
                sepiaImageView = filerUtil.colorFiltersepia(originalImage: CIImage(image: originalImage))
            }
            return ("セピア",sepiaImageView)
        case 3:
            
            if filter1ImageView == nil{
                filter1ImageView = filerUtil.colorFilter(originalImage: originalImage)
            }
            return("ライト",filter1ImageView)
            
        case 4:
            if filterfadeImageView == nil{
                filterfadeImageView = filerUtil.CIPhotoEffectFade(originalImage: originalImage)
            }
            return("フェード",filterfadeImageView)
            
        case 5:
            if filterniseImageView == nil{
                filterniseImageView = filerUtil.colorFilternise(originalImage: CIImage(image: originalImage))
            }
            return("偽色",filterniseImageView)
            
        case 6:
            if filterhanImageView == nil{
                filterhanImageView = filerUtil.colorFilterhan(originalImage: CIImage(image: originalImage))
            }
            return("反転",filterhanImageView)
            
        case 7:
            if filterinstantImageView == nil{
                filterinstantImageView = filerUtil.CIPhotoEffectInstant(originalImage: originalImage)
                
                
            }
            return("インスタント",filterinstantImageView)
            
        case 8:
            if filterprocessImageView == nil{
                filterprocessImageView = filerUtil.CIPhotoEffectProcess(originalImage: originalImage)
                
                
            }
            return("プロセス",filterprocessImageView)
            
            
        case 9:
            if filterchromeImageView == nil{
                filterchromeImageView = filerUtil.CIPhotoEffectChrome(originalImage: originalImage)
                
                
            }
            return("クローム",filterchromeImageView)
            
        case 10:
            if filterblurImageView == nil{
                filterblurImageView = filerUtil.CIGaussianBlur(originalImage: originalImage)
                
                
            }
            return("ブラー",filterblurImageView)
            
            
            
            
        default:
            
            if filter2ImageView == nil{
                filter2ImageView = filerUtil.colorFilter2(originalImage: originalImage)
            }
            return("シャドウ",filter2ImageView)
            
            
            //        case 5:
            //            return("プロセス",filerUtil.CIPhotoEffectProcess(originalImage))
            //        default:
            //            return("クローム",filerUtil.CIPhotoEffectChrome(originalImage))
            
        }
    }
    
    override func viewWillLayoutSubviews() {
        self.view.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    @IBAction func takePhoto() {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            
            curveImageView  = nil
            grayImageView  = nil
            sepiaImageView = nil
            filter1ImageView = nil
            filter2ImageView = nil
            filterfadeImageView = nil
            filterniseImageView = nil
            filterhanImageView = nil
            filterinstantImageView = nil
            filterprocessImageView = nil
            filterchromeImageView = nil
            filterblurImageView = nil
            
            
            let picker = UIImagePickerController()
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.allowsEditing = true
            picker.delegate = self
            
            present(picker,animated: true, completion: nil)
        }
        else{
            
            print("error")
        }
    }
    
    @IBAction func savePhoto(){
        
        if cameraImageView.image != nil{
            
            print(cameraImageView.image?.size)
            //  UIImageWriteToSavedPhotosAlbum(cgimg, self, "image:didFinishSavingWithError:contextInfo:", nil)
            UIImageWriteToSavedPhotosAlbum(cameraImageView.image!, self, #selector(ViewController.image(image:didFinishSavingWithError:contextInfo:)),nil)
            
            let alertController = UIAlertController(title: "保存完了！", message: "カメラロールに画像を保存しました",preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
            
            
            //PHPhotoLibrary.sharedPhotoLibrary().performChanges({
            //let assetChangeRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(UIImage(CGImage: cgimg))
            //let assetPlaceHolder = assetChangeRequest.placeholderForCreatedAsset
            //let albumChangeRequest = PHAssetCollectionChangeRequest(forAssetCollection: self.assetCollection)
            //albumChangeRequest!.addAssets([assetPlaceHolder!])
            //}, completionHandler: nil)
            
            
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer) {
        if error != nil {
            /* 失敗 */
            print(error.code)
        }
    }
    
    
    
    
    @IBAction func colorFilter(){
        cameraImageView.image = filerUtil.colorFilter(originalImage: originalImage)
        
    }
    @IBAction func colorFilter2(){
        cameraImageView.image = filerUtil.colorFilter2(originalImage: originalImage)
        
    }
    
    @IBAction func colorFiltergray(){
        cameraImageView.image = filerUtil.colorFiltergrey(originalImage:originalImage)
        
    }
    
    
    @IBAction func colorFiltercurve(){
        cameraImageView.image = filerUtil.colorFiltercurve(originalImage: originalImage)
        
    }
    
    @IBAction func colorfiltersepia(){
        cameraImageView.image = filerUtil.colorFiltersepia(originalImage: originalImage.ciImage)
        
        
    }
    
    
    
    @IBAction func CIPhotoEffectProcess(){
        
        filter = CIFilter(name: "CIPhotoEffectProcess")
        outputImage()
        
    }
    
    @IBAction func CIPhotoEffectChrome() {
        filter = CIFilter(name: "CIPhotoEffectChrome")
        outputImage()
    }
    
    @IBAction func photoEffectFade() {
        filter = CIFilter(name: "CIPhotoEffectFade")
        outputImage()
    }
    
    @IBAction func colorFilternise(){
        cameraImageView.image = filerUtil.colorFilternise (originalImage: originalImage.ciImage)
        
        
        
    }
    
    @IBAction func colorFilterhan(){
        filter = CIFilter(name: "CIColorMonochrome")
        outputImage()
    }
    
    @IBAction func CIPhotoEffectInstant() {
        filter = CIFilter(name: "CIPhotoEffectInstant")
        outputImage()
        
    }
    @IBAction func CIGaussianBlur(){
        filter = CIFilter(name: "CIGaussianBlur")
        outputImage()
        
        
        
    }
    
    
    
    
    
    
    
    func outputImage() {
        print(filter)
        let inputImage = CIImage(image: originalImage)
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        cameraImageView.image = UIImage(cgImage: cgImage!)
    }
    
    @IBAction func openAlbum(){
        
        curveImageView  = nil
        grayImageView  = nil
        sepiaImageView = nil
        filter1ImageView = nil
        filter2ImageView = nil
        filterfadeImageView = nil
        filterniseImageView = nil
        filterhanImageView = nil
        filterinstantImageView = nil
        filterprocessImageView = nil
        filterchromeImageView = nil
        filterblurImageView = nil
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        }
        
        
        
    }
    
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]) {
        cameraImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        originalImage = cameraImageView.image!
        filteredImages = []
        
        dismiss(animated: true, completion: nil)
        //
        filerUtil = FilterUtil()
        //                 処理に時間かかるからプログレスのダイアログを表示した方がいいよ😄
        for i in 0...11 {
            filteredImages.append(setImage(indexPath: i))
            print(i)
        }
        show()
        
        NSLog("before apply")
        
        //        DispatchQueue.concurrentPerform(iterations: 2) {_ in
        ////            NSLog("proc start \()")
        ////
        ////            filteredImages.append(setImage(indexPath: i))
        ////
        ////            NSLog("proc end \(i)")
        //            print("\($0)concurrentPerform")
        //        }
        //
        //        DispatchQueue.concurrentPerform(iterations: 1) {
        //            print("\($0). concurrentPerform start")
        //            filteredImages.append(setImage(indexPath: $0))
        //            print("\($0). concurrentPerform end ")
        //
        //        }
        
       // filteredImages.append(setImage(indexPath: 1))
        
        
        //        NSLog("after apply")
       // show()
    }
    
    @IBAction func snsPost(){
        if cameraImageView.image != nil{
            let shareText = "写真を加工したよ！！"
            let shareImage = cameraImageView.image!
            let activityItems = [shareText,shareImage] as [Any]
            
            let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            
            let excludedActivityTypes = [
                UIActivityType.postToWeibo,
                UIActivityType.saveToCameraRoll,
                UIActivityType.print,
                ]
            activityVC.excludedActivityTypes = excludedActivityTypes
            
            self.present(activityVC, animated: true, completion: nil)
            
        }
    }
    
    
    //    func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutablePointer<Void>) {
    
    //       var title = "保存完了"
    //      var message = "アルバムへの保存完了"
    
    //        if error != nil {
    //            title = "エラー"
    //            message = "アルバムへの保存に失敗しました"
    //        }
    
    //       let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "OK")
    //        alert.show()
    //    }
}

// CollectionViewのデータと押された時の処理を管理する
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    @available(iOS 6.0, *)
    
    
    
    // セル数を返す(UITableViewでいうところの"tableView:numberOfRowsInSection:"
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredImages.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! CustomCollectionViewCell
        let content = filteredImages[indexPath.row]
        cell.label.text = content.0
        cell.ImageView.image = content.1
        cell.ImageView.layer.cornerRadius = 5
        cell.ImageView.layer.masksToBounds = true
        print(cell.ImageView.tag)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let cell = collectionView.cellForItem(at: indexPath as IndexPath) as! CustomCollectionViewCell
        cameraImageView.image = cell.ImageView.image
    }
    
}

