import UIKit
import SnapKit
import SofaAcademic

class LeagueView: BaseView {

    private let league: League

    public init(league: League) {
        self.league = league
        super.init()
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

    internal override func addViews() {
        configureWithLeague()
        self.addSubview(leagueLogoImageView)
        self.addSubview(countryLeagueLabel)
        self.addSubview(countryLabel)
        self.addSubview(arrowImageView)
        self.addSubview(arrowContainerLabel)
        self.addSubview(leagueNameLabel)
        
    }
    
    internal override func setupConstraints() {
        
        countryLabel.setContentHuggingPriority(.required, for: .horizontal)
        countryLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        countryLeagueLabel.setContentHuggingPriority(.required, for: .horizontal)
        countryLeagueLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        leagueNameLabel.setContentHuggingPriority(.required, for: .horizontal)
        leagueNameLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        leagueLogoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(32)
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
        }
        
        countryLeagueLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.leading.equalTo(leagueLogoImageView.snp.trailing).offset(32)
            make.top.equalToSuperview().offset(16)
        }
        
        countryLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.leading.equalTo(countryLeagueLabel)
            make.top.equalTo(countryLeagueLabel).offset(4)
        }
        
        arrowContainerLabel.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.top.equalTo(countryLeagueLabel)
            make.leading.equalTo(countryLabel.snp.trailing)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.width.equalTo(10)
            make.height.equalTo(20)
            make.centerY.equalTo(arrowContainerLabel)
            make.leading.equalTo(arrowContainerLabel).offset(6)
        }
        
        leagueNameLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.leading.equalTo(arrowContainerLabel.snp.trailing)
            make.top.equalTo(countryLeagueLabel).offset(4)
        }
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
