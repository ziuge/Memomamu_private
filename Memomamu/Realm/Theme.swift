//
//  Theme.swift
//  Memomamu
//
//  Created by CHOI on 2023/03/07.
//

import Foundation
import RealmSwift

class Theme: Object {
    @Persisted var autoDark: Bool
    @Persisted var type: Int
}
