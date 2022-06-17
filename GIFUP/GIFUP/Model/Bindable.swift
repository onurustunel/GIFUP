//
//  Bindable.swift
//  GIFUP
//
//  Created by onur on 17.06.2022.
//

import Foundation

class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    var observer: ((T?) -> ())?
    func assignValue(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}
