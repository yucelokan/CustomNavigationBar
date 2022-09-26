
# CustomNavigationBar

A fully customizable navigation bar for iOS.

## Activation
```swift
    import CustomNavigationBar
```

```swift
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
    
        CustomNavigationBar.setupCustomNavigationBar()
        return true
    }
```

## Customize
```swift
    CustomNavigationBar.configuration.margin = .init(top: 16, left: 32, bottom: 16, right: 32)
    CustomNavigationBar.configuration.height = 32
    CustomNavigationBar.configuration.spacing = 0
    CustomNavigationBar.configuration.titleNumberOfLines = 1
    CustomNavigationBar.configuration.minimumScaleFactor = 0.5
    CustomNavigationBar.configuration.lineBreakMode = .byTruncatingMiddle
    CustomNavigationBar.configuration.titleTintColor = .darkText
    CustomNavigationBar.configuration.titleFont = .systemFont(ofSize: 17)
    CustomNavigationBar.configuration.buttonTintColor = .original
    CustomNavigationBar.configuration.popButtonImage = UIImage(named: "ic16BackIos")
    CustomNavigationBar.configuration.dismissButtonImage = UIImage(named: "ic16Close")
```

## Usage

```swift
    class ViewController: UIViewController, CustomNavigationBarConfigurable {
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // navigation bar has 'back/dismiss' button and 'title' defaultly.
            customTitle = "Dashboard"
        }
    }
    
    // if you need to customize it view controller spesific
    func customNavigationBarConfiguration() -> CustomNavigationBarConfiguration {
        var configuration = CustomNavigationBar.configuration
        configuration.titleTintColor = .white
        configuration.buttonTintColor = .withColor(.white)
        return configuration
    }
    
    // if you need to update
    updateCustomNavigationBar()
    
    // to customize items
    func customNavigationBarViews() -> [CustomNavigationBarViewType] {
        let languageButton = UIButton()
        languageButton.setTitle("change language", for: .normal)
        languageButton.addTarget(self, action: #selector(changeLanguage()), for: .touchUpInside)

        let logoImage = UIImageView(image: UIImage(named: "logo"))
        logoImage.contentMode = .scaleAspectFit
        return [.custom(logoImage), .spacer(), .custom(languageButton)]
    }
    
    // or
    
    func customNavigationBarViews() -> [CustomNavigationBarViewType] {
        let navigationView = CustomNavigationView()
        navigationView.delegate = self
        navigationView.configure(with: viewModel)
        return [.pop(), .custom(navigationView)]
    }
    
```
