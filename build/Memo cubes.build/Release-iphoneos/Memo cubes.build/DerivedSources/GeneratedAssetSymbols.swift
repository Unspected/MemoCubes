import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ColorResource {

    /// The "blueGray" asset catalog color resource.
    static let blueGray = DeveloperToolsSupport.ColorResource(name: "blueGray", bundle: resourceBundle)

    /// The "naturalWood" asset catalog color resource.
    static let naturalWood = DeveloperToolsSupport.ColorResource(name: "naturalWood", bundle: resourceBundle)

}

// MARK: - Image Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ImageResource {

    /// The "ankh" asset catalog image resource.
    static let ankh = DeveloperToolsSupport.ImageResource(name: "ankh", bundle: resourceBundle)

    /// The "anubis" asset catalog image resource.
    static let anubis = DeveloperToolsSupport.ImageResource(name: "anubis", bundle: resourceBundle)

    /// The "cactus" asset catalog image resource.
    static let cactus = DeveloperToolsSupport.ImageResource(name: "cactus", bundle: resourceBundle)

    /// The "camel" asset catalog image resource.
    static let camel = DeveloperToolsSupport.ImageResource(name: "camel", bundle: resourceBundle)

    /// The "camel-shape" asset catalog image resource.
    static let camelShape = DeveloperToolsSupport.ImageResource(name: "camel-shape", bundle: resourceBundle)

    /// The "castle" asset catalog image resource.
    static let castle = DeveloperToolsSupport.ImageResource(name: "castle", bundle: resourceBundle)

    /// The "cleopatra" asset catalog image resource.
    static let cleopatra = DeveloperToolsSupport.ImageResource(name: "cleopatra", bundle: resourceBundle)

    /// The "desert" asset catalog image resource.
    static let desert = DeveloperToolsSupport.ImageResource(name: "desert", bundle: resourceBundle)

    /// The "eagle" asset catalog image resource.
    static let eagle = DeveloperToolsSupport.ImageResource(name: "eagle", bundle: resourceBundle)

    /// The "eye-of-ra" asset catalog image resource.
    static let eyeOfRa = DeveloperToolsSupport.ImageResource(name: "eye-of-ra", bundle: resourceBundle)

    /// The "game_background" asset catalog image resource.
    static let gameBackground = DeveloperToolsSupport.ImageResource(name: "game_background", bundle: resourceBundle)

    /// The "genie_lamp" asset catalog image resource.
    static let genieLamp = DeveloperToolsSupport.ImageResource(name: "genie_lamp", bundle: resourceBundle)

    /// The "great-sphinx-of-giza" asset catalog image resource.
    static let greatSphinxOfGiza = DeveloperToolsSupport.ImageResource(name: "great-sphinx-of-giza", bundle: resourceBundle)

    /// The "magic-carpet" asset catalog image resource.
    static let magicCarpet = DeveloperToolsSupport.ImageResource(name: "magic-carpet", bundle: resourceBundle)

    /// The "magic_lamp" asset catalog image resource.
    static let magicLamp = DeveloperToolsSupport.ImageResource(name: "magic_lamp", bundle: resourceBundle)

    /// The "oil_fabric" asset catalog image resource.
    static let oilFabric = DeveloperToolsSupport.ImageResource(name: "oil_fabric", bundle: resourceBundle)

    /// The "papyrus" asset catalog image resource.
    static let papyrus = DeveloperToolsSupport.ImageResource(name: "papyrus", bundle: resourceBundle)

    /// The "pharaoh" asset catalog image resource.
    static let pharaoh = DeveloperToolsSupport.ImageResource(name: "pharaoh", bundle: resourceBundle)

    /// The "sarcophagus" asset catalog image resource.
    static let sarcophagus = DeveloperToolsSupport.ImageResource(name: "sarcophagus", bundle: resourceBundle)

    /// The "scarab_bug" asset catalog image resource.
    static let scarabBug = DeveloperToolsSupport.ImageResource(name: "scarab_bug", bundle: resourceBundle)

    /// The "scorpion" asset catalog image resource.
    static let scorpion = DeveloperToolsSupport.ImageResource(name: "scorpion", bundle: resourceBundle)

    /// The "snake" asset catalog image resource.
    static let snake = DeveloperToolsSupport.ImageResource(name: "snake", bundle: resourceBundle)

    /// The "sphinx" asset catalog image resource.
    static let sphinx = DeveloperToolsSupport.ImageResource(name: "sphinx", bundle: resourceBundle)

    /// The "swords" asset catalog image resource.
    static let swords = DeveloperToolsSupport.ImageResource(name: "swords", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// The "blueGray" asset catalog color.
    static var blueGray: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .blueGray)
#else
        .init()
#endif
    }

    /// The "naturalWood" asset catalog color.
    static var naturalWood: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .naturalWood)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// The "blueGray" asset catalog color.
    static var blueGray: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .blueGray)
#else
        .init()
#endif
    }

    /// The "naturalWood" asset catalog color.
    static var naturalWood: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .naturalWood)
#else
        .init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

    /// The "blueGray" asset catalog color.
    static var blueGray: SwiftUI.Color { .init(.blueGray) }

    /// The "naturalWood" asset catalog color.
    static var naturalWood: SwiftUI.Color { .init(.naturalWood) }

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    /// The "blueGray" asset catalog color.
    static var blueGray: SwiftUI.Color { .init(.blueGray) }

    /// The "naturalWood" asset catalog color.
    static var naturalWood: SwiftUI.Color { .init(.naturalWood) }

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "ankh" asset catalog image.
    static var ankh: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ankh)
#else
        .init()
#endif
    }

    /// The "anubis" asset catalog image.
    static var anubis: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .anubis)
#else
        .init()
#endif
    }

    /// The "cactus" asset catalog image.
    static var cactus: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cactus)
#else
        .init()
#endif
    }

    /// The "camel" asset catalog image.
    static var camel: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .camel)
#else
        .init()
#endif
    }

    /// The "camel-shape" asset catalog image.
    static var camelShape: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .camelShape)
#else
        .init()
#endif
    }

    /// The "castle" asset catalog image.
    static var castle: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .castle)
#else
        .init()
#endif
    }

    /// The "cleopatra" asset catalog image.
    static var cleopatra: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cleopatra)
#else
        .init()
#endif
    }

    /// The "desert" asset catalog image.
    static var desert: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .desert)
#else
        .init()
#endif
    }

    /// The "eagle" asset catalog image.
    static var eagle: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .eagle)
#else
        .init()
#endif
    }

    /// The "eye-of-ra" asset catalog image.
    static var eyeOfRa: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .eyeOfRa)
#else
        .init()
#endif
    }

    /// The "game_background" asset catalog image.
    static var gameBackground: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .gameBackground)
#else
        .init()
#endif
    }

    /// The "genie_lamp" asset catalog image.
    static var genieLamp: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .genieLamp)
#else
        .init()
#endif
    }

    /// The "great-sphinx-of-giza" asset catalog image.
    static var greatSphinxOfGiza: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .greatSphinxOfGiza)
#else
        .init()
#endif
    }

    /// The "magic-carpet" asset catalog image.
    static var magicCarpet: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .magicCarpet)
#else
        .init()
#endif
    }

    /// The "magic_lamp" asset catalog image.
    static var magicLamp: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .magicLamp)
#else
        .init()
#endif
    }

    /// The "oil_fabric" asset catalog image.
    static var oilFabric: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .oilFabric)
#else
        .init()
#endif
    }

    /// The "papyrus" asset catalog image.
    static var papyrus: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .papyrus)
#else
        .init()
#endif
    }

    /// The "pharaoh" asset catalog image.
    static var pharaoh: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .pharaoh)
#else
        .init()
#endif
    }

    /// The "sarcophagus" asset catalog image.
    static var sarcophagus: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .sarcophagus)
#else
        .init()
#endif
    }

    /// The "scarab_bug" asset catalog image.
    static var scarabBug: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .scarabBug)
#else
        .init()
#endif
    }

    /// The "scorpion" asset catalog image.
    static var scorpion: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .scorpion)
#else
        .init()
#endif
    }

    /// The "snake" asset catalog image.
    static var snake: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .snake)
#else
        .init()
#endif
    }

    /// The "sphinx" asset catalog image.
    static var sphinx: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .sphinx)
#else
        .init()
#endif
    }

    /// The "swords" asset catalog image.
    static var swords: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .swords)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "ankh" asset catalog image.
    static var ankh: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .ankh)
#else
        .init()
#endif
    }

    /// The "anubis" asset catalog image.
    static var anubis: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .anubis)
#else
        .init()
#endif
    }

    /// The "cactus" asset catalog image.
    static var cactus: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cactus)
#else
        .init()
#endif
    }

    /// The "camel" asset catalog image.
    static var camel: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .camel)
#else
        .init()
#endif
    }

    /// The "camel-shape" asset catalog image.
    static var camelShape: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .camelShape)
#else
        .init()
#endif
    }

    /// The "castle" asset catalog image.
    static var castle: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .castle)
#else
        .init()
#endif
    }

    /// The "cleopatra" asset catalog image.
    static var cleopatra: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cleopatra)
#else
        .init()
#endif
    }

    /// The "desert" asset catalog image.
    static var desert: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .desert)
#else
        .init()
#endif
    }

    /// The "eagle" asset catalog image.
    static var eagle: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .eagle)
#else
        .init()
#endif
    }

    /// The "eye-of-ra" asset catalog image.
    static var eyeOfRa: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .eyeOfRa)
#else
        .init()
#endif
    }

    /// The "game_background" asset catalog image.
    static var gameBackground: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .gameBackground)
#else
        .init()
#endif
    }

    /// The "genie_lamp" asset catalog image.
    static var genieLamp: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .genieLamp)
#else
        .init()
#endif
    }

    /// The "great-sphinx-of-giza" asset catalog image.
    static var greatSphinxOfGiza: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .greatSphinxOfGiza)
#else
        .init()
#endif
    }

    /// The "magic-carpet" asset catalog image.
    static var magicCarpet: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .magicCarpet)
#else
        .init()
#endif
    }

    /// The "magic_lamp" asset catalog image.
    static var magicLamp: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .magicLamp)
#else
        .init()
#endif
    }

    /// The "oil_fabric" asset catalog image.
    static var oilFabric: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .oilFabric)
#else
        .init()
#endif
    }

    /// The "papyrus" asset catalog image.
    static var papyrus: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .papyrus)
#else
        .init()
#endif
    }

    /// The "pharaoh" asset catalog image.
    static var pharaoh: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .pharaoh)
#else
        .init()
#endif
    }

    /// The "sarcophagus" asset catalog image.
    static var sarcophagus: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .sarcophagus)
#else
        .init()
#endif
    }

    /// The "scarab_bug" asset catalog image.
    static var scarabBug: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .scarabBug)
#else
        .init()
#endif
    }

    /// The "scorpion" asset catalog image.
    static var scorpion: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .scorpion)
#else
        .init()
#endif
    }

    /// The "snake" asset catalog image.
    static var snake: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .snake)
#else
        .init()
#endif
    }

    /// The "sphinx" asset catalog image.
    static var sphinx: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .sphinx)
#else
        .init()
#endif
    }

    /// The "swords" asset catalog image.
    static var swords: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .swords)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ColorResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ImageResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

