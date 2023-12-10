//
//  StripeCheckoutViewController.swift
//  GroceryAppDemo
//
//  Created by Bhagyesh Desai on 10/12/23.
//

import UIKit
import StripePaymentsUI

class StripeCheckoutViewController: BaseScreen {

    var paymentIntentClientSecret: String?

    lazy var cardTextField: STPPaymentCardTextField = {
        let cardTextField = STPPaymentCardTextField()
        return cardTextField
    }()
    lazy var payButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.setTitle("Pay", for: .normal)
        button.addTarget(self, action: #selector(pay), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController!.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [cardTextField, payButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: 2),
            view.rightAnchor.constraint(equalToSystemSpacingAfter: stackView.rightAnchor, multiplier: 2),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 20),
        ])
        startCheckout()
    }

    func displayAlert(title: String, message: String) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        let confirmationVC = ConfirmationViewController()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(confirmationVC, animated: true)
        }
    }
    
    func startCheckout() {
            
    }
    
    @objc
    func pay() {
        guard let paymentIntentClientSecret = paymentIntentClientSecret else {
                    return
                }
                let paymentIntentParams = STPPaymentIntentParams(clientSecret: paymentIntentClientSecret)
                paymentIntentParams.paymentMethodParams = cardTextField.paymentMethodParams

                let paymentHandler = STPPaymentHandler.shared()
                paymentHandler.confirmPayment(paymentIntentParams, with: self) { (status, paymentIntent, error) in
                    switch (status) {
                    case .failed:
                        self.displayAlert(title: "Payment failed", message: error?.localizedDescription ?? "")
                        break
                    case .canceled:
                        self.displayAlert(title: "Payment canceled", message: error?.localizedDescription ?? "")
                        break
                    case .succeeded:
                        self.displayAlert(title: "Payment succeeded", message: paymentIntent?.description ?? "")
                        break
                    @unknown default:
                        fatalError()
                        break
                    }
                }
        }
}

extension StripeCheckoutViewController: STPAuthenticationContext {
    func authenticationPresentingViewController() -> UIViewController {
        return self
    }
}
