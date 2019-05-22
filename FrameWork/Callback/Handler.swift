//
//  Handler.swift
//  FrameWork
//
//  Created by Jeremy on 4/11/17.
//  Copyright © 2017 fptshop. All rights reserved.
//

import Foundation
typealias LoginHandler = (_ user:User?,_ error:String) ->Void
typealias SearchProductHandler = (_ success:[Product],_ error:String) ->Void
typealias GetListBonusScopeHandler = (_ success:[Product],_ error:String) ->Void
