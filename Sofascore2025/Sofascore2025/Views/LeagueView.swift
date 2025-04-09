import UIKit
import SnapKit
import SofaAcademic

final class LeagueView: BaseView {

    private let leagueLogoImageView = UIImageView()
    private let leagueNameLabel = UILabel()
    private let icPointerRight = UIImageView()
    private let countryLabel = UILabel()

    override func addViews() {
        addSubview(leagueLogoImageView)
        addSubview(countryLabel)
        addSubview(leagueNameLabel)
        addSubview(icPointerRight)
    }

    override func styleViews() {
        leagueNameLabel.font = .robotoBoldSize14
        leagueNameLabel.textAlignment = .left
        leagueNameLabel.numberOfLines = 1
        leagueNameLabel.textColor = .semiTransparentDark

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

        countryLabel.snp.makeConstraints {
            $0.leading.equalTo(leagueLogoImageView.snp.trailing).offset(32)
            $0.top.bottom.equalToSuperview().inset(20)
        }

        icPointerRight.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(23)
            $0.leading.equalTo(countryLabel.snp.trailing).offset(10)
            $0.trailing.equalTo(leagueNameLabel.snp.leading).offset(-9)
        }

        leagueNameLabel.snp.makeConstraints {
            $0.leading.equalTo(icPointerRight.snp.trailing).offset(9)
            $0.top.bottom.equalToSuperview().inset(20)
        }
    }


    func configure(with league: LeagueViewModel) {
        leagueNameLabel.text = league.leagueName
        countryLabel.text = league.countryName
        leagueLogoImageView.image = league.image
    }
}
