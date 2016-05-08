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

class ViewController: UIViewController , UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    @IBOutlet var cameraImageView: UIImageView!
    
    var originalImage : UIImage!
    var filter : CIFilter!
    
    //var assetCollection: PHAssetCollection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let filterImage : CIImage = CIImage(image: originalImage)!
        
        filter = CIFilter(name: "CIColorControls")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        filter.setValue(1.0, forKey: "inputSaturation")
        filter.setValue(0.5, forKey: "inputBrightness")
        filter.setValue(2.5, forKey: "inputContrast")
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, fromRect: filter.outputImage!.extent)
        cameraImageView.image = UIImage(CGImage: cgImage)
        
        
        
    }
    @IBAction func colorFilter2(){
        let filterImage : CIImage = CIImage(image: originalImage)!
        
        filter = CIFilter(name: "CIColorControls")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        filter.setValue(1.0, forKey: "inputSaturation")
        filter.setValue(0.5, forKey: "inputBrightness")
        filter.setValue(3.0, forKey: "inputContrast")
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, fromRect: filter.outputImage!.extent)
        cameraImageView.image = UIImage(CGImage: cgImage)
        
        
        
    }
    
    @IBAction func colorfiltergray(){
        let filterImage : CIImage = CIImage(image: originalImage)!
        
        filter = CIFilter(name: "CIColorMonochrome")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        filter.setValue(CIColor(red: 0.75, green: 0.75, blue: 0.75), forKey: "inputColor")
        filter.setValue(1.0, forKey: "inputIntensity")
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, fromRect: filter.outputImage!.extent)
        cameraImageView.image = UIImage(CGImage: cgImage)
        
    }
    
    
    @IBAction func colorfiltercurve(){
        
        let filterImage : CIImage = CIImage(image: originalImage)!
        
        filter = CIFilter(name: "CIToneCurve" )!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        filter.setValue(CIVector(x: 0.0, y: 0.0), forKey: "inputPoint0")
        filter.setValue(CIVector(x: 0.25, y: 0.1), forKey: "inputPoint1")
        filter.setValue(CIVector(x: 0.5, y: 0.5), forKey: "inputPoint2")
        filter.setValue(CIVector(x: 0.75, y: 0.9), forKey: "inputPoint3")
        filter.setValue(CIVector(x: 1.0, y: 1.0), forKey: "inputPoint4")
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, fromRect: filter.outputImage!.extent)
        cameraImageView.image = UIImage(CGImage: cgImage)
        
    }
    
    @IBAction func colorfiltersepia(){
        
        let filterImage : CIImage = CIImage(image: originalImage)!
        
        //let ciImage:CIImage = CIImage(image:image);
        filter = CIFilter(name: "CISepiaTone")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        filter.setValue(0.8, forKey: "inputIntensity")
        let ciContext:CIContext = CIContext(options: nil)
        // let cgimg:CGImageRef = ciContext.createCGImage(filter.outputImage!, fromRect:filter.outputImage.extent())
        
        //image2に加工後のUIImage
        //let image2:UIImage? = UIImage(CGImage: cgimg, scale: 1.0, orientation:UIImageOrientation.Up)
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, fromRect: filter.outputImage!.extent)
        cameraImageView.image = UIImage(CGImage: cgImage)
        
    }
    
    
    
    @IBAction func colorfilterchilt(){
       blendWithMask()
    }
    
    func blurred() -> CIImage {
        
        let filterImage  = CIImage(image: originalImage)!
        filter = CIFilter(name:"CIGaussianBlur")!
        print(0)
        filter.setValue(filterImage, forKey: kCIInputImageKey)
         print(1)
        filter.setValue(70, forKey: kCIInputRadiusKey)
         print(2)
        
        let cropFilter = CIFilter(name: "CICrop")
        cropFilter!.setValue(filter.outputImage, forKey: kCIInputImageKey)
         print(3)
        cropFilter!.setValue(CIVector(CGRect: filterImage.extent), forKey:"inputRectangle")
         print(4)
        
        
        
        return cropFilter!.outputImage!
    }
    
    
    func topLinearGradient() -> CIImage {
        let ciImage = CIImage(image: originalImage)
        let filter = CIFilter(name: "CILinearGradient")
        filter!.setValue(CIVector(x: 0, y: 0.75 * ciImage!.extent.height), forKey: "inputPoint0")
        filter!.setValue(CIColor(red: 0, green: 1, blue: 0, alpha: 0.9), forKey: "inputColor0")
        filter!.setValue(CIVector(x: 0, y: 0.5 * ciImage!.extent.height), forKey: "inputPoint1")
        filter!.setValue(CIColor(red: 0, green: 1, blue: 0, alpha: 0), forKey: "inputColor1")
        
        let cropFilter = CIFilter(name: "CICrop")
        cropFilter!.setValue(filter!.outputImage, forKey: kCIInputImageKey)
        cropFilter!.setValue(CIVector(CGRect: ciImage!.extent), forKey: "inputRectangle")
        
        return cropFilter!.outputImage!
    }
    
    func bottomLinearGradient() -> CIImage {
        let ciImage = CIImage(image: originalImage)
        let filter = CIFilter(name: "CILinearGradient")
        filter!.setValue(CIVector(x: 0, y: 0.25 * ciImage!.extent.height), forKey: "inputPoint0")
        filter!.setValue(CIColor(red: 0, green: 1, blue: 0, alpha: 0.9), forKey: "inputColor0")
        filter!.setValue(CIVector(x: 0, y: 0.5 * ciImage!.extent.height), forKey: "inputPoint1")
        filter!.setValue(CIColor(red: 0, green: 1, blue: 0, alpha: 0), forKey: "inputColor1")
        
        let cropFilter = CIFilter(name: "CICrop")
        cropFilter!.setValue(filter!.outputImage, forKey: kCIInputImageKey)
        cropFilter!.setValue(CIVector(CGRect: ciImage!.extent), forKey: "inputRectangle")
        
        return cropFilter!.outputImage!
    }
    
    func additionCompositing() -> CIImage {
        let context = CIContext(options: nil)
        let filter = CIFilter(name: "CIAdditionCompositing")
        filter!.setValue(topLinearGradient(), forKey: kCIInputImageKey)
        filter!.setValue(bottomLinearGradient(), forKey: kCIInputBackgroundImageKey)
        return filter!.outputImage!
    }
    
    func blendWithMask() {
        let context = CIContext(options: nil)
        let ciImage = CIImage(image: originalImage
        )
        let filter = CIFilter(name: "CIBlendWithMask")
        filter!.setValue(blurred(), forKey: kCIInputImageKey)
        filter!.setValue(ciImage, forKey: kCIInputBackgroundImageKey)
        filter!.setValue(additionCompositing(), forKey: kCIInputMaskImageKey)
        
        let extent = filter!.outputImage!.extent
        let cgImage: CGImage = context.createCGImage(filter!.outputImage!, fromRect: extent)
        
        cameraImageView.image = UIImage(CGImage: cgImage)
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

