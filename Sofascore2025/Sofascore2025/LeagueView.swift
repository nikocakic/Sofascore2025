import UIKit
import SnapKit
import SofaAcademic

final class LeagueView: BaseView {

    private let leagueLogoImageView = UIImageView()
    private let countryLeagueLabel = UILabel()
    private let leagueNameLabel = UILabel()
    private let arrowContainerLabel = UILabel()
    private let icPointerRight = UIImageView()
    private let countryLabel = UILabel()


    public init(league: League) {
        super.init()
        configure(with: league)
    }

    override func addViews() {
        addSubview(leagueLogoImageView)
        addSubview(countryLeagueLabel)
        countryLeagueLabel.addSubview(countryLabel)
        countryLeagueLabel.addSubview(arrowContainerLabel)
        countryLeagueLabel.addSubview(leagueNameLabel)
        arrowContainerLabel.addSubview(icPointerRight)
    }

    override func styleViews() {
        countryLeagueLabel.font = .robotoRegularSize14

        leagueNameLabel.font = .robotoBoldSize14
        leagueNameLabel.textAlignment = .left
        leagueNameLabel.numberOfLines = 1
        leagueNameLabel.textColor = .semiTransparentDark


        arrowContainerLabel.textAlignment = .center

        icPointerRight.contentMode = .scaleAspectFit
        icPointerRight.image = UIImage(named: "firstScreen")
        icPointerRight.tintColor = .black

        countryLabel.font = .robotoBoldSize14
        countryLabel.textAlignment = .left
        countryLabel.numberOfLines = 1
    }


    override func setupConstraints() {
        leagueLogoImageView.snp.makeConstraints {
            $0.size.equalTo(32)
            $0.leading.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(12)
        }

        countryLeagueLabel.snp.makeConstraints {
            $0.leading.equalTo(leagueLogoImageView.snp.trailing).offset(32)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(16)
        }

        countryLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(4)
        }

        arrowContainerLabel.snp.makeConstraints {
            $0.leading.equalTo(countryLabel.snp.trailing)
            $0.centerY.equalToSuperview()
        }

        icPointerRight.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(4)
        }

        leagueNameLabel.snp.makeConstraints {
            $0.leading.equalTo(arrowContainerLabel.snp.trailing)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }


    func configure(with league: League) {
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
