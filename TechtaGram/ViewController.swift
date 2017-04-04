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
    var basicImage : UIImage!
    
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
    
    var itu : String = ""
    var dokode : String = ""
    var dareto : String = ""
    var textArray = Array<String>()
    
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
            
            
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer) {
        if error != nil {
            /* 失敗 */
            print(error.code)
        }
    }
    
    
    
    
    @IBAction func colorFilter(){
        cameraImageView.image = filerUtil.colorFilter(originalImage: basicImage)
        
    }
    @IBAction func colorFilter2(){
        cameraImageView.image = filerUtil.colorFilter2(originalImage: basicImage)
        
    }
    
    @IBAction func colorFiltergray(){
        cameraImageView.image = filerUtil.colorFiltergrey(originalImage:basicImage)
        
    }
    
    
    @IBAction func colorFiltercurve(){
        cameraImageView.image = filerUtil.colorFiltercurve(originalImage: basicImage)
        
    }
    
    @IBAction func colorfiltersepia(){
        cameraImageView.image = filerUtil.colorFiltersepia(originalImage: basicImage.ciImage)
        
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
        
        basicImage  = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        cameraImageView.image = basicImage
        self.filteredImages = []
        

        
        dismiss(animated: true, completion: nil)
        
        
        let alert:UIAlertController = UIAlertController(title:"タイトル",
                                                        message: "メッセージ",
                                                        preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel",
                                                       style: UIAlertActionStyle.cancel,
                                                       handler:{
                                                        (action:UIAlertAction!) -> Void in
                                                        print("Cancel")
        })
        let defaultAction:UIAlertAction = UIAlertAction(title: "OK",
                                                        style: UIAlertActionStyle.default,
                                                        handler:{
                                                            (action:UIAlertAction!) -> Void in
                                                            
                                                            self.textArray.removeAll()
                                                            let textFields:Array<UITextField>? =  alert.textFields as Array<UITextField>?
                                                            if textFields != nil {
                                                                for textField:UITextField in textFields! {
                                                                    //各textにアクセス
                                                                    print(textField.text)
                                                                    self.textArray.append(textField.text!)
                                                                    
                                                                }
                                                            }
                                                            
                                                            
                                                            self.originalImage = self.resize(ratio: 0.5,image:self.cameraImageView.image!)
                                                            
                                                            
                                                            
                                                            
                                                            //
                                                            self.filerUtil = FilterUtil()
                                                            //                 処理に時間かかるからプログレスのダイアログを表示した方がいいよ😄
                                                            for i in 0...11 {
                                                                var imageResult = self.setImage(indexPath: i)
                                                                
                                                                var image :UIImage! = imageResult.1
                                                                
                                                                imageResult.1 = self.drawtext(image: image, text:"@" + self.textArray[0] )
                                                               
                                                                self.filteredImages.append(imageResult)
                                                                print(i)
                                                                imageResult.1 = UIImage()
                                                                image = nil
                                                                self.curveImageView  = nil
                                                                 self.grayImageView = nil
                                                                 self.sepiaImageView  = nil
                                                                 self.filter1ImageView  = nil
                                                                 self.filter2ImageView  = nil
                                                                 self.filterfadeImageView  = nil
                                                                 self.filterniseImageView  = nil
                                                                 self.filterhanImageView  = nil
                                                                 self.filterinstantImageView  = nil
                                                                 self.filterprocessImageView  = nil
                                                                 self.filterchromeImageView  =  nil
                                                                 self.filterblurImageView
                                                                    
                                                                    
                                                                    
                                                                    = nil
                                                                
                                                            }
                                                            

                                                            
                                                            self.cameraImageView.image =
                                                            self.drawtext(image: self.cameraImageView.image!, text:"@" + self.textArray[0])
                                                            
                                                            
                                                            NSLog("before apply")
                                                            self.show()
                                                        
                                                            
        })

        
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        //textfiledの追加
        present(alert, animated: true, completion: nil)
        
        alert.addTextField(configurationHandler: {(text:UITextField!) -> Void in
            text.placeholder = "どこで？"
            
        })
        
        
        
    }
    
    // 比率だけ指定する場合
    func resize(ratio: CGFloat,image : UIImage) -> UIImage {
        let resizedSize = CGSize(width: Int(image.size.width * ratio), height: Int(image.size.height * ratio))
        UIGraphicsBeginImageContext(resizedSize)
        image.draw(in : CGRect(x: 0, y: 0, width: resizedSize.width, height: resizedSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
    
    func drawtext(image : UIImage,text:String) -> UIImage!{
        UIGraphicsBeginImageContext(image.size)
        
        let textFontAttributes = [
            
            NSFontAttributeName : UIFont(name:"Arial",size : image.size.width/15)!,NSForegroundColorAttributeName : UIColor.red
        ]
        
        
        
        
        image.draw(in: CGRect(x:0, y:0,width: image.size.width, height:image.size.height))
        
       
        let tx1 = "@"
        let tx2 = text + "@@"
        let textWidth = tx2.size(attributes:textFontAttributes).width
        let textHeight = tx1.size(attributes:textFontAttributes).height
        let mergin = image.size.width/30
    
        let textRect = CGRect(x:image.size.width  - textWidth - mergin, y:image.size.height - textHeight-mergin  ,width:textWidth, height: textHeight)
//
        
        //let textRect = CGRect(x:10, y:10 ,width:300, height: 100)
        //


        
        text.draw(in: textRect, withAttributes: textFontAttributes)
        let newimage = UIGraphicsGetImageFromCurrentImageContext()
        
        
        
        UIGraphicsEndImageContext()
        
        return newimage
        
        
        
        
        
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

