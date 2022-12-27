//
//  Tooltip.swift
//  TextToSpeech
//
//  Created by Qiwei Li on 12/27/22.
//

import SwiftUI

struct Tooltip<Popper: View, Content: View>: View {
    @ViewBuilder let popper: Popper
    @ViewBuilder let content: Content
    
    @State var showPopper = false
    
    
    var body: some View {
        content
            .popover(isPresented: $showPopper, content: {
                popper
            })
            .onHover { result in
                showPopper = result
            }
            .onTapGesture {
                showPopper = true
            }
        
    }
}

struct Tooltip_Previews: PreviewProvider {
    static var previews: some View {
        Tooltip {
            Text("Hello world")
        } content: {
            Text("Hello world")
        }

    }
}
