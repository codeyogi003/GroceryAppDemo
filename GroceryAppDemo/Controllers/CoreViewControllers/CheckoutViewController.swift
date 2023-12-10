//
//  CheckoutViewController.swift
//  GroceryAppDemo
//
//  Created by Bhagyesh Desai on 09/12/23.
//

import UIKit

class CheckoutViewController: BaseScreen {

    private let checkoutInfoStackView: UIStackView = {
        let vStackView = UIStackView()
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        vStackView.spacing = 30
        vStackView.alignment = .leading
        vStackView.distribution = .fill
        vStackView.backgroundColor = .clear
        return vStackView
    }()
    
    private let spaceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let paymentStackView: UIStackView = {
        let vStackView = UIStackView()
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        vStackView.spacing = 20
        vStackView.alignment = .leading
        vStackView.distribution = .fillProportionally
        vStackView.backgroundColor = .clear
        return vStackView
    }()
    
    private let paymentStackHeaderView: UIStackView = {
        let hStackView = UIStackView()
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        hStackView.spacing = 20
        hStackView.alignment = .fill
        hStackView.distribution = .fillProportionally
        hStackView.backgroundColor = .clear
        return hStackView
    }()
    
    private let paymentHeaderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ResourcesEnum.CheckoutPagePaymentMethodLabel.fetchLocalizedString()
        label.font = .systemFont(ofSize: 26, weight: .medium)
        label.textColor = UIColor(named: ColorsEnum.TextColorPrimary.rawValue)
        label.textAlignment = .center
        return label
    }()
    
    private let paymentChangeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitle(ResourcesEnum.CheckoutPageChangeButtonLabel.fetchLocalizedString(), for: .normal)
        button.setTitleColor(UIColor(named: ColorsEnum.DarkPurple.rawValue), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        return button
    }()
    
    private let cardDetailsStackView: UIStackView = {
        let hStackView = UIStackView()
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        hStackView.spacing = 20
        hStackView.alignment = .leading
        hStackView.distribution = .fillProportionally
        hStackView.backgroundColor = .clear
        return hStackView
    }()
    
    private let cardLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: ResourcesEnum.CreditCardIcon.rawValue)
        return imageView
    }()
    
    private let cardNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = ResourcesEnum.DummyCardLabel.rawValue
        return label
    }()
    
    private let addressStackView: UIStackView = {
        let vStackView = UIStackView()
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        vStackView.spacing = 10
        vStackView.alignment = .leading
        vStackView.distribution = .fill
        vStackView.backgroundColor = .clear
        return vStackView
    }()
    
    private let addressStackHeaderView: UIStackView = {
        let hStackView = UIStackView()
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        hStackView.alignment = .center
        hStackView.distribution = .fill
        hStackView.backgroundColor = .clear
        return hStackView
    }()
    
    private let addresstHeaderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ResourcesEnum.CheckoutPageDeliveryAddressLabel.fetchLocalizedString()
        label.font = .systemFont(ofSize: 26, weight: .medium)
        label.textColor = UIColor(named: ColorsEnum.TextColorPrimary.rawValue)
        label.textAlignment = .center
        return label
    }()
    
    private let addressChangeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitle(ResourcesEnum.CheckoutPageChangeButtonLabel.fetchLocalizedString(), for: .normal)
        button.setTitleColor(UIColor(named: ColorsEnum.DarkPurple.rawValue), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        return button
    }()
    
    private let addressDetailsStackView: UIStackView = {
        let hStackView = UIStackView()
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        hStackView.spacing = 20
        hStackView.alignment = .leading
        hStackView.distribution = .fillProportionally
        hStackView.backgroundColor = .clear
        return hStackView
    }()
    
    private let homeIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: ResourcesEnum.HomeIcon.rawValue)
        return imageView
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = ResourcesEnum.DummyAddress.rawValue
        label.numberOfLines = 0
        return label
    }()
    
    private let deliveryOptionStackView: UIStackView = {
        let vStackView = UIStackView()
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        vStackView.spacing = 20
        vStackView.alignment = .center
        vStackView.distribution = .equalCentering
        vStackView.backgroundColor = .clear
        return vStackView
    }()
    
    private let deliveryOptionHeaderView: UIStackView = {
        let hStackView = UIStackView()
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        hStackView.alignment = .center
        hStackView.distribution = .fill
        hStackView.backgroundColor = .clear
        return hStackView
    }()
    
    private let deliveryOptionsHeaderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ResourcesEnum.CheckoutPageDeliveryOptionsLabel.fetchLocalizedString()
        label.font = .systemFont(ofSize: 26, weight: .medium)
        label.textColor = UIColor(named: ColorsEnum.TextColorPrimary.rawValue)
        label.textAlignment = .center
        return label
    }()
    
    private let noContactDeliveryView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let noContactLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ResourcesEnum.CheckoutPageNoContactLabel.fetchLocalizedString()
        label.font = .systemFont(ofSize: 26, weight: .medium)
        label.textColor = UIColor(named: ColorsEnum.TextColorPrimary.rawValue)
        label.textAlignment = .center
        return label
    }()
    
    private let noContactToggleSwitch: UISwitch = {
        let toggleSwitch = UISwitch()
        toggleSwitch.isOn = false
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
        toggleSwitch.tintColor = UIColor(named: ColorsEnum.BackgroundGrey.rawValue)
        toggleSwitch.onTintColor = UIColor(named: ColorsEnum.LightPurple.rawValue)
        toggleSwitch.thumbTintColor = .white
        return toggleSwitch
    }()
    
    private let yesToggleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ResourcesEnum.CheckoutPageYesLabel.fetchLocalizedString()
        label.textColor = UIColor(named: ColorsEnum.DarkPurple.rawValue)
        label.font = .systemFont(ofSize: 5, weight: .regular)
        label.contentMode = .center
        return label
    }()
    
    private let noToggleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ResourcesEnum.CheckoutPageNoLabel.fetchLocalizedString()
        label.textColor = UIColor(named: ColorsEnum.DarkPurple.rawValue)
        label.font = .systemFont(ofSize: 5, weight: .regular)
        label.contentMode = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController!.tabBar.isHidden = false
        self.tabBarController!.tabBar.items![1].image = UIImage(named: ResourcesEnum.ShoppingCartHighlighted.rawValue)
        self.navigationController?.topViewController!.navigationItem.title = ResourcesEnum.CheckoutPageTitleLabel.fetchLocalizedString()
        noContactToggleSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        paymentChangeButton.addTarget(self, action: #selector(paymentChangeButtonAction(_:)), for: .touchUpInside)
        addressChangeButton.addTarget(self, action: #selector(addressChangeButtonAction(_:)), for: .touchUpInside)
        
        view.addSubview(checkoutInfoStackView)
        
        noContactDeliveryView.addSubview(noContactLabel)
        noContactDeliveryView.addSubview(noContactToggleSwitch)
        
        checkoutInfoStackView.addArrangedSubview(paymentStackView)
        checkoutInfoStackView.addArrangedSubview(addressStackView)
        checkoutInfoStackView.addArrangedSubview(deliveryOptionStackView)
        checkoutInfoStackView.addArrangedSubview(noContactDeliveryView)
        
        paymentStackView.addArrangedSubview(paymentStackHeaderView)
        cardDetailsStackView.addArrangedSubview(cardLogoImageView)
        cardDetailsStackView.addArrangedSubview(cardNumberLabel)
        paymentStackView.addArrangedSubview(cardDetailsStackView)
        
        addressStackView.addArrangedSubview(addressStackHeaderView)
        addressDetailsStackView.addArrangedSubview(homeIconImageView)
        addressDetailsStackView.addArrangedSubview(addressLabel)
        addressStackView.addArrangedSubview(addressDetailsStackView)
        
        deliveryOptionStackView.addArrangedSubview(deliveryOptionHeaderView)
        
        paymentStackHeaderView.addArrangedSubview(paymentHeaderLabel)
        view.addSubview(paymentChangeButton)
        
        addressStackHeaderView.addArrangedSubview(addresstHeaderLabel)
        view.addSubview(addressChangeButton)
        
        deliveryOptionHeaderView.addArrangedSubview(deliveryOptionsHeaderLabel)
        
        
        applyConstraints()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.tabBarController!.tabBar.items![1].image = UIImage(named: ResourcesEnum.ShoppingCartIcon.rawValue)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            checkoutInfoStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            checkoutInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            checkoutInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            checkoutInfoStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            
            noContactLabel.centerYAnchor.constraint(equalTo: noContactDeliveryView.centerYAnchor),
            noContactLabel.leadingAnchor.constraint(equalTo: noContactDeliveryView.leadingAnchor),
            
            noContactToggleSwitch.centerYAnchor.constraint(equalTo: noContactDeliveryView.centerYAnchor),
            noContactToggleSwitch.trailingAnchor.constraint(equalTo: checkoutInfoStackView.trailingAnchor),
            
            paymentChangeButton.centerYAnchor.constraint(equalTo: paymentStackHeaderView.centerYAnchor),
            paymentChangeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addressChangeButton.centerYAnchor.constraint(equalTo: addressStackHeaderView.centerYAnchor),
            addressChangeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        
    }
    
    @objc func paymentChangeButtonAction(_ sender: UIButton) {
        let cardDetailsVC = StripeCheckoutViewController()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(cardDetailsVC, animated: true)
        }
    }
    
    @objc func addressChangeButtonAction(_ sender: UIButton) {
        
    }
    
}
