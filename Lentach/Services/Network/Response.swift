//
//  Response.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

typealias DataLoadedCompletion = (Response<Data, NSError>) -> Void
typealias ImageLoadedCompletion = (Response<UIImage, NSError>) -> Void

enum Response<Value, Error: Swift.Error> {

    case success(Value)
    case failure(Error)

    func resolve() throws -> Value {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }

}

extension Response where Value == Data {

    func decoded<T: Decodable>() throws -> T {
        let decoder = JSONDecoder()
        let data = try resolve()
        return try decoder.decode(T.self, from: data)
    }

}
