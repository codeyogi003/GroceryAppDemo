//
//  ResourcesEnum.swift
//  GroceryAppDemo
//
//  Created by Bhagyesh Desai on 08/12/23.
//

import Foundation

enum ResourcesEnum: String {
    
    // MARK: IconNames
    case UserIcon = "user"
    case HomeIcon = "home"
    case CheckIcon = "check"
    case ScanIcon = "camera"
    case BikeIcon = "bike"
    case CreditCardIcon = "credit-card"
    case DroneIcon = "drone"
    case CVCHintIcon = "cvc-hint"
    case GridIcon = "grid"
    case GridHighlightedIcon = "grid-highlighted"
    case PackageIcon = "package"
    case HeartIcon = "heart"
    case HeartHighlighted = "heart-highlighted"
    case ShoppingCartIcon = "shopping-cart"
    case ShoppingCartHighlighted = "shopping-cart-highlighted"
    case WalkingIcon = "walking"
    case ArrowBackward = "arrow-backward"
    
    // MARK: GraphicNames
    case CardGraphic = "card-graphic"
    case BackgroundGraphic = "background-graphic"
    case NoImageGraphic = "no-image-graphic"
    
    // MARK: FileNames
    
    // MARK: Strings
    case HomePageTitleLabel
    case HomePageDesciptionLabel
    case OrderNowButtonLabel
    case DismissButtonLabel
    
    case CategoryPageTitleLabel
    case SearchBarPlaceholderLabel
    
    case AddToCartButtonLabel
    
    case CheckoutPageTitleLabel
    case CheckoutPagePaymentMethodLabel
    case CheckoutPageChangeButtonLabel
    case CheckoutPageDeliveryAddressLabel
    case CheckoutPageDeliveryOptionsLabel
    case CheckoutPagePickMyselfLabel
    case CheckoutPageByCourierLabel
    case CheckoutPageByDroneLabel
    case CheckoutPageNoContactLabel
    case CheckoutPageYesLabel
    
    case CardPageTitleLabel
    case CardPageNameLabel
    case CardPageCardNumberLabel
    case CardPageExpiryLabel
    case CardPageCVCLabel
    case CardPageUseCardButtonLabel
    case CheckoutPageNoLabel
    
    case ConfirmationPageThankYouLabel
    case ConfirmationPageOrderMoreLabel
    case ConfirmationPageCloseLabel
    
    case DummyCardLabel = "**** **** **** 4747"
    
    case DummyAddress = "Alexandra Smith, Cesu 31 k-2 5.st, SIA Chili, Riga, LV–1012, Latvia"
    
    case TestingLabel
    
    internal func fetchLocalizedString() -> String {
        let localizedString = NSLocalizedString(self.rawValue, tableName: "Localizable", bundle: .main, value: "", comment: "")
        return localizedString
    }
}
