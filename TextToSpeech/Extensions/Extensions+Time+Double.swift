//
//  Extensions+Time+Double.swift
//  TextToSpeech
//
//  Created by Qiwei Li on 12/27/22.
//

import Foundation


extension Double {
    func asTimeString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = style
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: self) ?? "0:00:00"
    }
}
