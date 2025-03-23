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

    private let leagueLogoImageView = UIImageView()
    private let countryLeagueLabel = UILabel()
    private let leagueNameLabel = UILabel()
    private let arrowContainerLabel = UILabel()
    private let icPointerRight = UIImageView()
    private let countryLabel = UILabel()

    internal override func addViews() {
        configureWithLeague()
        addSubview(leagueLogoImageView)
        addSubview(countryLeagueLabel)
        addSubview(countryLabel)
        addSubview(icPointerRight)
        addSubview(arrowContainerLabel)
        addSubview(leagueNameLabel)
        
        styleViews()
    }

    internal override func styleViews() {
        leagueLogoImageView.contentMode = .scaleAspectFit
        leagueLogoImageView.clipsToBounds = true

        countryLeagueLabel.textAlignment = .center
        countryLeagueLabel.numberOfLines = 1
        countryLeagueLabel.lineBreakMode = .byTruncatingTail
        countryLeagueLabel.font = .robotoRegularSize14

        leagueNameLabel.font = .robotoBoldSize14
        leagueNameLabel.textAlignment = .center
        leagueNameLabel.numberOfLines = 1
        leagueNameLabel.lineBreakMode = .byTruncatingTail
        leagueNameLabel.textColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.4)


        arrowContainerLabel.textAlignment = .center

        icPointerRight.contentMode = .scaleAspectFit
        icPointerRight.image = UIImage(named: "firstScreen")
        icPointerRight.tintColor = .black

        countryLabel.font = .robotoBoldSize14
        countryLabel.textAlignment = .center
        countryLabel.numberOfLines = 1
        countryLabel.lineBreakMode = .byTruncatingTail
    }


    internal override func setupConstraints() {
        countryLabel.setContentHuggingPriority(.required, for: .horizontal)
        countryLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        countryLeagueLabel.setContentHuggingPriority(.required, for: .horizontal)
        countryLeagueLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        leagueNameLabel.setContentHuggingPriority(.required, for: .horizontal)
        leagueNameLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        leagueLogoImageView.snp.makeConstraints { 
            $0.width.height.equalTo(32)
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(16)
        }

        countryLeagueLabel.snp.makeConstraints {
            //make.height.equalTo(24)
            $0.leading.equalTo(leagueLogoImageView.snp.trailing).offset(32)
            $0.top.equalToSuperview().offset(16)
        }

        countryLabel.snp.makeConstraints {
            //make.height.equalTo(16)
            $0.leading.equalTo(countryLeagueLabel)
            $0.top.equalTo(countryLeagueLabel).offset(4)
        }

        arrowContainerLabel.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.top.equalTo(countryLeagueLabel)
            $0.leading.equalTo(countryLabel.snp.trailing)
        }

        icPointerRight.snp.makeConstraints {
            $0.width.equalTo(10)
            //make.height.equalTo(20)
            $0.centerY.equalTo(arrowContainerLabel)
            $0.leading.equalTo(arrowContainerLabel).offset(6)
        }

        leagueNameLabel.snp.makeConstraints {
            $0.leading.equalTo(arrowContainerLabel.snp.trailing)
            $0.top.equalTo(countryLeagueLabel).offset(4)
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
