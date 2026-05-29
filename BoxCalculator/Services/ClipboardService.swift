//
//  ClipboardService.swift
//  HelloWorld
//
//  Created by Michael Rowsey on 5/29/26.
//

import AppKit

struct ClipboardService {

    static func copy(_ text: String) {

        NSPasteboard.general.clearContents()

        NSPasteboard.general.setString(
            text,
            forType: .string
        )
    }
}
