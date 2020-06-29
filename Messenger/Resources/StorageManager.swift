//
//  StorageManager.swift
//  Messenger
//
//  Created by saw Tarmalar on 29/06/2020.
//  Copyright © 2020 saw Tarmalar. All rights reserved.
//

import Foundation
import FirebaseStorage


///Allows you to get, fetch and upload files to firebase storage

final class StorageManager{
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    public typealias UploadPictureCompletion = (Result<String, Error>) -> Void
    
    /// Uploads picture to firebase storage and return completion with url string to download
    public func uploadProfilePicture(with data: Data, fileName: String, completion: @escaping UploadPictureCompletion) {
        storage.child("images/\(fileName)").putData(data, metadata: nil, completion: { [weak self] metadata, error in
            guard let strongSelf = self else{
                       return
                   }
                   
                   guard error == nil else{
                       // failed
                    print("failed to upload data to firebase for picture")
                    completion(.failure(StorageErrors.failedToUpload))
                    return
                   }
            
            strongSelf.storage.child("images/\(fileName)").downloadURL { (url, error) in
                guard let url = url else {
                    print("Failed to get download url")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                
                let urlString = url.absoluteString
                print("download url returned: \(urlString)")
                completion(.success(urlString))
            }
        })
       
    }
    
    public enum StorageErrors: Error{
        case failedToUpload
        case failedToGetDownloadUrl
    }
}
