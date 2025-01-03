//
//  Color+HS.swift
//  MilkoJumps
//
//  Created by Rob Jonson on 10/02/2020.
//  Copyright © 2020 HobbyistSoftware. All rights reserved.
//
#if canImport(UIKit)

import Foundation
import SwiftUI
import UIKit

public extension UIColor {

    var color: Color {
        return Color(self)
    }
}

// Adds semantic colour support, e.g. Color.label (iOS0, color.secondaryLabelColor (macOS)
public extension Color {

    static var systemGray: Color { Color(UIColor.systemGray) }

    /* The numbered variations, systemGray2 through systemGray6, are grays which increasingly
     * trend away from systemGray and in the direction of systemBackgroundColor.
     *
     * In UIUserInterfaceStyleLight: systemGray1 is slightly lighter than systemGray.
     *                               systemGray2 is lighter than that, and so on.
     * In UIUserInterfaceStyleDark:  systemGray1 is slightly darker than systemGray.
     *                               systemGray2 is darker than that, and so on.
     */
    @available(iOS 13.0, *)
    @available(tvOS, unavailable)
    static var systemGray2: Color { Color(UIColor.systemGray2) }

    @available(iOS 13.0, *)
    @available(tvOS, unavailable)
    static var systemGray3: Color { Color(UIColor.systemGray3) }

    @available(iOS 13.0, *)
    @available(tvOS, unavailable)
    static var systemGray4: Color { Color(UIColor.systemGray4) }

    @available(iOS 13.0, *)
    @available(tvOS, unavailable)
    static var systemGray5: Color { Color(UIColor.systemGray5) }

    @available(iOS 13.0, *)
    @available(tvOS, unavailable)
    static var systemGray6: Color { Color(UIColor.systemGray6) }

    /* Foreground colors for static text and related elements.
     */
    @available(iOS 13.0, *)
    static var label: Color { Color(UIColor.label) }

    @available(iOS 13.0, *)
    static var secondaryLabel: Color { Color(UIColor.secondaryLabel) }

    @available(iOS 13.0, *)
    static var tertiaryLabel: Color { Color(UIColor.tertiaryLabel) }

    @available(iOS 13.0, *)
    static var quaternaryLabel: Color { Color(UIColor.quaternaryLabel) }

    /* Foreground color for standard system links.
     */
    @available(iOS 13.0, *)
    static var link: Color { Color(UIColor.link) }

    /* Foreground color for placeholder text in controls or text fields or text views.
     */
    @available(iOS 13.0, *)
    static var placeholderText: Color { Color(UIColor.placeholderText) }

    /* Foreground colors for separators (thin border or divider lines).
     * `separatorColor` may be partially transparent, so it can go on top of any content.
     * `opaqueSeparatorColor` is intended to look similar, but is guaranteed to be opaque, so it will
     * completely cover anything behind it. Depending on the situation, you may need one or the other.
     */
    @available(iOS 13.0, *)
    static var separator: Color { Color(UIColor.separator) }

    @available(iOS 13.0, *)
    static var opaqueSeparator: Color { Color(UIColor.opaqueSeparator) }

    /* We provide two design systems (also known as "stacks") for structuring an iOS app's backgrounds.
     *
     * Each stack has three "levels" of background colors. The first color is intended to be the
     * main background, farthest back. Secondary and tertiary colors are layered on top
     * of the main background, when appropriate.
     *
     * Inside of a discrete piece of UI, choose a stack, then use colors from that stack.
     * We do not recommend mixing and matching background colors between stacks.
     * The foreground colors above are designed to work in both stacks.
     *
     * 1. systemBackground
     *    Use this stack for views with standard table views, and designs which have a white
     *    primary background in light mode.
     */
    @available(iOS 13.0, *)
    @available(tvOS, unavailable)
    static var systemBackground: Color { Color(UIColor.systemBackground) }

    @available(iOS 13.0, *)
    @available(tvOS, unavailable)
    static var secondarySystemBackground: Color { Color(UIColor.secondarySystemBackground) }

    @available(iOS 13.0, *)
    @available(tvOS, unavailable)
    static var tertiarySystemBackground: Color { Color(UIColor.tertiarySystemBackground) }

    /* 2. systemGroupedBackground
     *    Use this stack for views with grouped content, such as grouped tables and
     *    platter-based designs. These are like grouped table views, but you may use these
     *    colors in places where a table view wouldn't make sense.
     */
    @available(iOS 13.0, *)
    @available(tvOS, unavailable)
    static var systemGroupedBackground: Color { Color(UIColor.systemGroupedBackground) }

    @available(iOS 13.0, *)
    @available(tvOS, unavailable)
    static var secondarySystemGroupedBackground: Color { Color(UIColor.secondarySystemGroupedBackground) }

    @available(iOS 13.0, *)
    @available(tvOS, unavailable)
    static var tertiarySystemGroupedBackground: Color { Color(UIColor.tertiarySystemGroupedBackground) }

    /* Fill colors for UI elements.
     * These are meant to be used over the background colors, since their alpha component is less than 1.
     *
     * systemFillColor is appropriate for filling thin and small shapes.
     * Example: The track of a slider.
     */
    @available(iOS 13.0, *)
    @available(tvOS, unavailable)
    static var systemFill: Color { Color(UIColor.systemFill) }

    /* secondarySystemFillColor is appropriate for filling medium-size shapes.
     * Example: The background of a switch.
     */
    @available(iOS 13.0, *)
    @available(tvOS, unavailable)
    static var secondarySystemFill: Color { Color(UIColor.secondarySystemFill) }

    /* tertiarySystemFillColor is appropriate for filling large shapes.
     * Examples: Input fields, search bars, buttons.
     */
    @available(iOS 13.0, *)
    @available(tvOS, unavailable)
    static var tertiarySystemFill: Color { Color(UIColor.tertiarySystemFill) }

    /* quaternarySystemFillColor is appropriate for filling large areas containing complex content.
     * Example: Expanded table cells.
     */
    @available(iOS 13.0, *)
    @available(tvOS, unavailable)
    static var quaternarySystemFill: Color { Color(UIColor.quaternarySystemFill) }
}

#endif
