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

class ViewController: UIViewController ,UICollectionViewDelegate,UIImagePickerControllerDelegate,  UINavigationControllerDelegate,UICollectionViewDataSource {
    
    @IBOutlet var cameraImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var originalImage : UIImage!
    var filter : CIFilter!
    var filerUtil : FilterUtil!
    
    var curveImageView : UIImage! = nil
    var grayImageView : UIImage! = nil
    var sepiaImageView : UIImage! = nil
    var filter1ImageView : UIImage! = nil
    var filter2ImageView : UIImage! = nil
    var filterfadeImageView : UIImage! = nil
    var filterniseImageView : UIImage! = nil
    var filterhanImageView : UIImage! = nil
  
    
    
    //var assetCollection: PHAssetCollection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        
        
        
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
       
        
        let imagePikerContoroller: UIImagePickerController = UIImagePickerController()
        imagePikerContoroller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePikerContoroller.allowsEditing = true
        self.presentViewController(imagePikerContoroller, animated: true, completion: nil)
        imagePikerContoroller.delegate = self
    }
    
    func show(){
        
        filerUtil = FilterUtil()
        let nib:UINib = UINib(nibName: "CustomCollectionViewCell",bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        collectionView.reloadData()
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomCollectionViewCell
        cell.ImageView.layer.cornerRadius = 20
        cell.ImageView.layer.masksToBounds = true
        cell.ImageView.image = setImage(indexPath.row).1
        print(cell.ImageView.tag)
        
        
        
        
        cell.label.text = setImage(indexPath.row).0
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CustomCollectionViewCell
        cameraImageView.image = cell.ImageView.image
        
        
    }
    
    func  setImage(indexPath : Int) -> (String,UIImage){
        
        
        
        switch indexPath {
        case 0:
            
            if curveImageView == nil{
                curveImageView = filerUtil.colorFiltercurve(originalImage)
            }
            //セピアの結果を返す
            return("カーブ",curveImageView)
        case 1:
            
            if grayImageView == nil{
                grayImageView = filerUtil.colorFiltergrey(originalImage)
            }
            //グレイの結果を返す
            return("グレイ",grayImageView)
        case 2:
            
            if sepiaImageView  == nil{
                sepiaImageView = filerUtil.colorFiltersepia(CIImage(image:originalImage))
            }
            return ("セピア",sepiaImageView)
        case 3:
            
            if filter1ImageView == nil{
                filter1ImageView = filerUtil.colorFilter(originalImage)
            }
            return("フィルター１",filter1ImageView)
            
        case 4:
            if filterfadeImageView == nil{
                filterfadeImageView = filerUtil.CIPhotoEffectFade(originalImage)
            }
            return("フェード",filterfadeImageView)
            
        case 5:
            if filterniseImageView == nil{
                filterniseImageView = filerUtil.colorFilternise(CIImage(image:originalImage))
            }
            return("偽色",filterfadeImageView)
            
        case 6:
            if filterniseImageView == nil{
                filterniseImageView = filerUtil.colorFilternise(CIImage(image:originalImage))
            }
            return("反転",filterfadeImageView)
            
        case 6:
            if filterniseImageView == nil{
                filterniseImageView = filerUtil.colorFilternise(CIImage(image:originalImage))
            }
            return("インスタント",filterfadeImageView)
    
            
            
            
            
            
            
        default:
            
            if filter2ImageView == nil{
                filter2ImageView = filerUtil.colorFilter2(originalImage)
            }
            return("フィルター２",filter2ImageView)
            
            
            //        case 5:
            //            return("プロセス",filerUtil.CIPhotoEffectProcess(originalImage))
            //        default:
            //            return("クローム",filerUtil.CIPhotoEffectChrome(originalImage))
            
        }
    }
    
    // セル数を返す(UITableViewでいうところの"tableView:numberOfRowsInSection:"
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func viewWillLayoutSubviews() {
        self.view.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    @IBAction func takePhoto() {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            
            curveImageView  = nil
            grayImageView  = nil
            sepiaImageView = nil
            filter1ImageView = nil
            filter2ImageView = nil
            filterfadeImageView = nil
            filterniseImageView = nil
            filterhanImageView = nil
            
            
            let picker = UIImagePickerController()
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.allowsEditing = true
            picker.delegate = self
            
            presentViewController(picker,animated: true, completion: nil)
        }
        else{
            
            print("error")
        }
    }
    
    @IBAction func savePhoto(){
        
        if cameraImageView.image != nil{
            
            print(cameraImageView.image?.size)
            //  UIImageWriteToSavedPhotosAlbum(cgimg, self, "image:didFinishSavingWithError:contextInfo:", nil)
            UIImageWriteToSavedPhotosAlbum(cameraImageView.image!, self, #selector(ViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
            
            let alertController = UIAlertController(title: "保存完了！", message: "カメラロールに画像を保存しました",preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
            
            
            
            //PHPhotoLibrary.sharedPhotoLibrary().performChanges({
            //let assetChangeRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(UIImage(CGImage: cgimg))
            //let assetPlaceHolder = assetChangeRequest.placeholderForCreatedAsset
            //let albumChangeRequest = PHAssetCollectionChangeRequest(forAssetCollection: self.assetCollection)
            //albumChangeRequest!.addAssets([assetPlaceHolder!])
            //}, completionHandler: nil)
            
            
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutablePointer<Void>) {
        if error != nil {
            /* 失敗 */
            print(error.code)
        }
    }
    
    
    
    
    @IBAction func colorFilter(){
        cameraImageView.image = filerUtil.colorFilter(originalImage)
        
    }
    @IBAction func colorFilter2(){
        cameraImageView.image = filerUtil.colorFilter2(originalImage)
        
    }
    
    @IBAction func colorFiltergray(){
        cameraImageView.image = filerUtil.colorFiltergrey(originalImage)
        
    }
    
    
    @IBAction func colorFiltercurve(){
        cameraImageView.image = filerUtil.colorFiltercurve(originalImage)
        
    }
    
    @IBAction func colorfiltersepia(){
        cameraImageView.image = filerUtil.colorFiltersepia(originalImage.CIImage)
        
        
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
        cameraImageView.image = filerUtil.colorFilternise(originalImage.CIImage)
        
              
        
    }
    
    @IBAction func colorFilterhan(){
      filter = CIFilter(name: "CIColorMonochrome")
        outputImage()
    }
    
    
    
    
    func outputImage() {
        print(filter)
        let inputImage = CIImage(image: originalImage)
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, fromRect: filter.outputImage!.extent)
        cameraImageView.image = UIImage(CGImage: cgImage)
    }
    
    
    
    
    
    
    
    @IBAction func openAlbum(){
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            picker.allowsEditing = true
            self.presentViewController(picker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info:  [String : AnyObject]) {
        cameraImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        originalImage = cameraImageView.image
        show()
        dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    @IBAction func snsPost(){
        if cameraImageView.image != nil{
            
            
            let shareText = "写真を加工したよ！！"
            let shareImage = cameraImageView.image!
            let activityItems = [shareText,shareImage]
            
            let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            
            let excludedActivityTypes = [
                UIActivityTypePostToWeibo,
                UIActivityTypeSaveToCameraRoll,
                UIActivityTypePrint,
                ]
            activityVC.excludedActivityTypes = excludedActivityTypes
            
            self.presentViewController(activityVC, animated: true, completion: nil)
            
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

