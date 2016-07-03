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

class ViewController: UIViewController , UIImagePickerControllerDelegate,  UINavigationControllerDelegate,UICollectionViewDataSource {
    
    @IBOutlet var cameraImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var originalImage : UIImage!
    var filter : CIFilter!
    var filerUtil : FilterUtil!
    
    
    //var assetCollection: PHAssetCollection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func selected(sender: AnyObject) {
        
        
        var imagePikerContoroller: UIImagePickerController = UIImagePickerController()
        imagePikerContoroller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePikerContoroller.allowsEditing = true
        self.presentViewController(imagePikerContoroller, animated: true, completion: nil)
        imagePikerContoroller.delegate = self
    }
    
    func show(){
        
    filerUtil = FilterUtil()
    let nib:UINib = UINib(nibName: "CustomCollectionViewCell",bundle: nil)
    
    let layout = UICollectionViewFlowLayout()
    
    //originalImage = UIImage(named: "96.png")
    
    
    // Cell一つ一つの大きさ.
    layout.itemSize = CGSizeMake(200, 200)
    collectionView.registerNib(nib, forCellWithReuseIdentifier: "Cell")
    collectionView.dataSource = self

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomCollectionViewCell
        
        
        
        
        cell.ImageView.image = setImage(indexPath.row).1
        
        cell.label.text = setImage(indexPath.row).0
        return cell
    }
    
    func  setImage(indexPath : Int) -> (String,UIImage){
        
       
        
        switch indexPath {
        case 0:
            //セピアの結果を返す
            return ("セピア",filerUtil.colorFiltersepia(CIImage(image:originalImage)))
        case 1:
            //グレイの結果を返す
            return("グレイ",filerUtil.colorFiltergray(originalImage))
        case 2:
            return("カーブ",filerUtil.colorFiltercurve(originalImage))
        case 3:
            return("フィルター１",filerUtil.colorFilter(originalImage))
        default:
            return("フィルター２",filerUtil.colorFilter2(originalImage))
//        case 5:
//            return("プロセス",filerUtil.CIPhotoEffectProcess(originalImage))
//        default:
//            return("クローム",filerUtil.CIPhotoEffectChrome(originalImage))
            
        }
           }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        // 条件に従ってサイズを変更する。
        
        var size = CGSize(width: 100, height: 300) // Square
            
        
        return size
    }
    
    // セル数を返す(UITableViewでいうところの"tableView:numberOfRowsInSection:"
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5;
    }
    
    override func viewWillLayoutSubviews() {
        self.view.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    @IBAction func takePhoto() {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            
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
        //        UIImageWriteToSavedPhotosAlbum(cgimg, self, "image:didFinishSavingWithError:contextInfo:", nil)
        
        
        let imageToSave = filter.outputImage!
        let softwareContext = CIContext(options: [kCIContextUseSoftwareRenderer: true])
        let cgimg = softwareContext.createCGImage(imageToSave, fromRect: imageToSave.extent)
        let library = ALAssetsLibrary()
        library.writeImageToSavedPhotosAlbum(cgimg, metadata: imageToSave.properties, completionBlock: nil)
        
        
        //PHPhotoLibrary.sharedPhotoLibrary().performChanges({
        //let assetChangeRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(UIImage(CGImage: cgimg))
        //let assetPlaceHolder = assetChangeRequest.placeholderForCreatedAsset
        //let albumChangeRequest = PHAssetCollectionChangeRequest(forAssetCollection: self.assetCollection)
        //albumChangeRequest!.addAssets([assetPlaceHolder!])
        //}, completionHandler: nil)
        
        
        
    }
    
    
    
    @IBAction func colorFilter(){
        cameraImageView.image = filerUtil.colorFilter(originalImage)
        
    }
    @IBAction func colorFilter2(){
        cameraImageView.image = filerUtil.colorFilter2(originalImage)
        
    }
    
    @IBAction func colorFiltergray(){
        cameraImageView.image = filerUtil.colorFiltergray(originalImage)
        
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
    
    @IBAction func alertBtn(sender: UIButton) {
        let alertController = UIAlertController(title: "保存完了！", message: "カメラロールに画像を保存しました",preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    
}

