/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

package crypto4cj.symmetrycj

import crypto4cj.utils.*

public class CIPHER {
    var cipher: UInt64 = 0
    var name: String = ""

    public init(c: UInt64){
        this.cipher = c
        this.name = ""
    }

    init(c: UInt64, name: String){
        this.cipher = c
        this.name = name
    }
    
    public func getCipher(): UInt64 {
        this.cipher
    }
    func getName(): String {
        this.name
    }
}