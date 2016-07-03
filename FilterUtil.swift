//
//  File.swift
//  TechtaGram
//
//  Created by 原 あゆみ on 2016/05/08.
//  Copyright © 2016年 原 あゆみ. All rights reserved.
//

import Foundation
import UIKit

class FilterUtil {
    
    var originalImage : UIImage!
    var filter : CIFilter!
    var filerUtil : FilterUtil!
    
    var filtergray : CIFilter!
    
    func colorFilter(originalImage : UIImage!) -> UIImage! {
        
        let filterImage : CIImage = CIImage(image: originalImage)!
        
        filter = CIFilter(name: "CIColorControls")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        filter.setValue(1.5, forKey: "inputSaturation")
        filter.setValue(0.4, forKey: "inputBrightness")
        filter.setValue(2.0, forKey: "inputContrast")
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, fromRect: filter.outputImage!.extent)
        
        return UIImage(CGImage: cgImage)
        
    }
    var filter2 : CIFilter!
    
    func colorFilter2(originalImage : UIImage!) -> UIImage! {
        
        let filterImage : CIImage = CIImage(image: originalImage)!
        
        filter = CIFilter(name: "CIColorControls")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        filter.setValue(1.0, forKey: "inputSaturation")
        filter.setValue(0.5, forKey: "inputBrightness")
        filter.setValue(3.0, forKey: "inputContrast")
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, fromRect: filter.outputImage!.extent)
        
        return UIImage(CGImage: cgImage)
        
    }
    
    
    var colorFiltercurve : CIFilter!
    func colorFiltercurve(originalImage : UIImage!) -> UIImage! {
        
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
        return UIImage(CGImage: cgImage)
        
    }
    
    var colorFiltergray : CIFilter!
    
    func colorFiltergray(originalImage : UIImage!) -> UIImage! {
        
        let filterImage : CIImage = CIImage(image: originalImage)!
        
        filter = CIFilter(name: "CIColorMonochrome")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        filter.setValue(CIColor(red: 0.75, green: 0.75, blue: 0.75), forKey: "inputColor")
        filter.setValue(1.0, forKey: "inputIntensity")
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, fromRect: filter.outputImage!.extent)
        
        return UIImage(CGImage: cgImage)
        
        
    }
    
    
    var colorFiltersepia : CIFilter!
    func colorFiltersepia(originalImage : CIImage!) -> UIImage! {
        
        let ciImage:CIImage = originalImage
        let ciFilter:CIFilter = CIFilter(name: "CISepiaTone")!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(0.8, forKey: "inputIntensity")
        let ciContext:CIContext = CIContext(options: nil)
        let cgimg:CGImageRef = ciContext.createCGImage(ciFilter.outputImage!, fromRect:ciFilter.outputImage!.extent)
        return UIImage(CGImage: cgimg, scale: 1.0, orientation:UIImageOrientation.Up)
    }
    
    
    var colorFilterchilt : CIFilter!
    
    func colorFilterchilt(originalImage : UIImage!) -> UIImage! {
        
        let filterImage : CIImage = CIImage(image: originalImage)!
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
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, fromRect: filter.outputImage!.extent)
        return UIImage(CGImage: cgImage)
        
    }
    
    
    
    
    //
    //    func blurred(originalImage : CIImage!) -> CIImage {
    //        let ciImage = originalImage
    //        let gaussianBlurFilter = CIFilter(name: "CIGaussianBlur")
    //        gaussianBlurFilter!.setValue(ciImage, forKey: kCIInputImageKey)
    //        gaussianBlurFilter!.setValue(10, forKey: kCIInputRadiusKey)
    //
    //        let cropFilter = CIFilter(name: "CICrop")
    //        cropFilter!.setValue(gaussianBlurFilter!.outputImage, forKey: kCIInputImageKey)
    //        cropFilter!.setValue(CIVector(CGRect: ciImage.extent), forKey: "inputRectangle")
    //
    //        return cropFilter!.outputImage!
    //    }
    //
    //    func topLinearGradient(originalImage : CIImage!) -> CIImage {
    //        let ciImage = originalImage
    //        let filter = CIFilter(name: "CILinearGradient")
    //        filter!.setValue(CIVector(x: 0, y: 0.75 * ciImage.extent.height), forKey: "inputPoint0")
    //        filter!.setValue(CIColor(red: 0, green: 1, blue: 0, alpha: 0.9), forKey: "inputColor0")
    //        filter!.setValue(CIVector(x: 0, y: 0.5 * ciImage.extent.height), forKey: "inputPoint1")
    //        filter!.setValue(CIColor(red: 0, green: 1, blue: 0, alpha: 0), forKey: "inputColor1")
    //
    //        let cropFilter = CIFilter(name: "CICrop")
    //        cropFilter!.setValue(filter!.outputImage, forKey: kCIInputImageKey)
    //        cropFilter!.setValue(CIVector(CGRect: ciImage.extent), forKey: "inputRectangle")
    //
    //        return cropFilter!.outputImage!
    //    }
    //
    //    func bottomLinearGradient(originalImage : CIImage!) -> CIImage {
    //        let ciImage = originalImage
    //        let filter = CIFilter(name: "CILinearGradient")
    //        filter!.setValue(CIVector(x: 0, y: 0.25 * ciImage.extent.height), forKey: "inputPoint0")
    //        filter!.setValue(CIColor(red: 0, green: 1, blue: 0, alpha: 0.9), forKey: "inputColor0")
    //        filter!.setValue(CIVector(x: 0, y: 0.5 * ciImage.extent.height), forKey: "inputPoint1")
    //        filter!.setValue(CIColor(red: 0, green: 1, blue: 0, alpha: 0), forKey: "inputColor1")
    //
    //        let cropFilter = CIFilter(name: "CICrop")
    //        cropFilter!.setValue(filter!.outputImage, forKey: kCIInputImageKey)
    //        cropFilter!.setValue(CIVector(CGRect: ciImage.extent), forKey: "inputRectangle")
    //
    //        return cropFilter!.outputImage!
    //    }
    //
    //    func additionCompositing(originalImage : CIImage!) -> CIImage {
    //        let context = CIContext(options: nil)
    //        let filter = CIFilter(name: "CIAdditionCompositing")
    //        filter!.setValue(topLinearGradient(originalImage), forKey: kCIInputImageKey)
    //        filter!.setValue(bottomLinearGradient(originalImage), forKey: kCIInputBackgroundImageKey)
    //        return filter!.outputImage!
    //    }
    //
    //    func blendWithMask(originalImage : CIImage!) -> UIImage {
    //        let context = CIContext(options: nil)
    //        let ciImage = originalImage
    //        let filter = CIFilter(name: "CIBlendWithMask")
    //        filter!.setValue(blurred(originalImage), forKey: kCIInputImageKey)
    //        filter!.setValue(ciImage, forKey: kCIInputBackgroundImageKey)
    //        filter!.setValue(additionCompositing(originalImage), forKey: kCIInputMaskImageKey)
    //
    //        let extent = filter!.outputImage!.extent
    //        let cgImage: CGImage = context.createCGImage(filter!.outputImage!, fromRect: extent)
    //
    //        return UIImage(CGImage: cgImage)
    //    }
    
    
    
    var CIPhotoEffectProcess : CIFilter!
    func CIPhotoEffectProcess(originalImage : UIImage!) -> UIImage! {
        
        filter = CIFilter(name: "CIPhotoEffectProcess")
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, fromRect: filter.outputImage!.extent)
        
        return UIImage(CGImage: cgImage)
        
        
    }
    
    var CIPhotoEffectChrome : CIFilter!
    func CIPhotoEffectChrome(originalImage : UIImage!) -> UIImage! {
        
        filter = CIFilter(name: "CIPhotoEffectChrome")
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, fromRect: filter.outputImage!.extent)
        
        return UIImage(CGImage: cgImage)
        
        
    }
    
    var outputImage : CIFilter!
    func outputImage(originalImage : UIImage!) -> UIImage! {
        print(filter)
        let inputImage = CIImage(image: originalImage)
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, fromRect: filter.outputImage!.extent)
        return UIImage(CGImage: cgImage)
    }
    
    
}
