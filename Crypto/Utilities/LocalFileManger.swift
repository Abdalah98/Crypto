//
//  LocalFileManger.swift
//  Crypto
//
//  Created by Abdallah on 21/05/2023.
//

import Foundation
 import SwiftUI
class LocalFileManger {
  static let instance = LocalFileManger()
  private init(){}
  
  
  func saveImage(image:UIImage,imageName:String,folderName:String){
    // creat folderName
    creatFolderIfNeeded(folderName: folderName)
    
    // get image path
    guard let data = image.pngData(),
    let url = URL(string: "")
    else {return}
    
    // save image to path
    do
    {
      try data.write(to: url)
    }catch let error{
      print("Error saving Image. imageName\(imageName) \(error)")
    }
  }
  
  private func creatFolderIfNeeded(folderName:String)  {
    guard let url = getURLForFolder(folderName: folderName) else { return}
    if !FileManager.default.fileExists(atPath: url.path){
      do{
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true,attributes: nil)
      }catch let error {
        print("Error creat Directory. FolderName.\(folderName). \(error)")
        
      }
    }
  }
  
   func getImage(imageName:String,folderName:String) -> UIImage? {
    guard let url = getURLForImage(imageName: imageName, folderName: folderName),
          FileManager.default.fileExists(atPath: url.path) else{
      return nil
    }
    return UIImage(contentsOfFile: url.path)
  }
  
  private func getURLForFolder(folderName:String) -> URL? {
    guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
      return nil
    }
    return url.appendingPathComponent(folderName)
    
  }
  
  private func getURLForImage(imageName:String,folderName:String) -> URL? {
    guard let folderUrl = getURLForFolder(folderName: folderName) else {
      return nil
    }
    return folderUrl.appendingPathComponent(imageName + ".png")
    
  }
  
}
