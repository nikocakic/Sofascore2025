import UIKit
import SnapKit
import SofaAcademic

class LeagueViewController: UIViewController {

    private let league: League

    init(league: League) {
        self.league = league
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let leagueLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private let countryLeagueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let leagueNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let arrowContainerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "firstScreen")
        imageView.tintColor = .black
        return imageView
    }()


    private let countryLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            label.textAlignment = .center
            label.numberOfLines = 1
            label.lineBreakMode = .byTruncatingTail
            return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        configureWithLeague()
        setupConstraints()
    }

    private func setupViews() {
        view.addSubview(leagueLogoImageView)
        view.addSubview(countryLeagueLabel)
        view.addSubview(countryLabel)
        view.addSubview(arrowImageView)
        view.addSubview(arrowContainerLabel)
        view.addSubview(leagueNameLabel)
        
    }
    private func setupConstraints() {
        leagueLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        countryLeagueLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowContainerLabel.translatesAutoresizingMaskIntoConstraints = false
        leagueNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //this is used to automatically arrange width for country name label
        countryLabel.setContentHuggingPriority(.required, for: .horizontal)
        countryLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        countryLeagueLabel.setContentHuggingPriority(.required, for: .horizontal)
        countryLeagueLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        leagueNameLabel.setContentHuggingPriority(.required, for: .horizontal)
        leagueNameLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

                    
        NSLayoutConstraint.activate([
            leagueLogoImageView.widthAnchor.constraint(equalToConstant: 32),
            leagueLogoImageView.heightAnchor.constraint(equalToConstant: 32),
            leagueLogoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            leagueLogoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            countryLeagueLabel.heightAnchor.constraint(equalToConstant: 24),
            countryLeagueLabel.leadingAnchor.constraint(equalTo: leagueLogoImageView.trailingAnchor, constant: 32),
            countryLeagueLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            
            countryLabel.heightAnchor.constraint(equalToConstant: 16),
            countryLabel.leadingAnchor.constraint(equalTo: countryLeagueLabel.leadingAnchor),
            countryLabel.topAnchor.constraint(equalTo: countryLeagueLabel.topAnchor, constant: 4),
            
            arrowContainerLabel.widthAnchor.constraint(equalToConstant: 24),
            arrowContainerLabel.heightAnchor.constraint(equalToConstant: 24),
            arrowContainerLabel.topAnchor.constraint(equalTo: countryLeagueLabel.topAnchor),
            arrowContainerLabel.leadingAnchor.constraint(equalTo: countryLabel.trailingAnchor),
            
            arrowImageView.widthAnchor.constraint(equalToConstant: 10),
            arrowImageView.heightAnchor.constraint(equalToConstant: 20),
            arrowImageView.centerYAnchor.constraint(equalTo: arrowContainerLabel.centerYAnchor),
            arrowImageView.leadingAnchor.constraint(equalTo: arrowContainerLabel.leadingAnchor, constant: 6),
            
            leagueNameLabel.heightAnchor.constraint(equalToConstant: 16),
            leagueNameLabel.leadingAnchor.constraint(equalTo: arrowContainerLabel.trailingAnchor),
            leagueNameLabel.topAnchor.constraint(equalTo: countryLeagueLabel.topAnchor, constant: 4),
            
        ])
    }

    private func configureWithLeague() {
        leagueNameLabel.text = league.name
        countryLabel.text = league.country?.name ?? "Unknown"
        leagueLogoImageView.image = UIImage(systemName: "photo")

        if let logoUrl = league.logoUrl, let url = URL(string: logoUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.leagueLogoImageView.image = image
                    }
                }
            }
        }
    }

}
