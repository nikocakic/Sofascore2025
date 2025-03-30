import UIKit
import SnapKit
import SofaAcademic

final class EventView: BaseView {
    

    
    private var homeTeamImageView = UIImageView()
    private var awayTeamImageView = UIImageView()
    private let leftContainerView = UIView()
    private let rigthContainerView = UIView()
    private let timeLabel = UILabel()
    private let minuteLabel = UILabel()
    private let homeTeamLabel = UILabel()
    private let awayTeamLabel = UILabel()
    private var numHomeTeamGoalsLabel = UILabel()
    private var numAwayTeamGoalsLabel = UILabel()
    
    override func addViews() {
        addSubview(leftContainerView)
        leftContainerView.addSubview(minuteLabel)
        leftContainerView.addSubview(timeLabel)
        addSubview(rigthContainerView)
        rigthContainerView.addSubview(homeTeamImageView)
        rigthContainerView.addSubview(awayTeamImageView)
        rigthContainerView.addSubview(homeTeamLabel)
        rigthContainerView.addSubview(awayTeamLabel)
        rigthContainerView.addSubview(numHomeTeamGoalsLabel)
        rigthContainerView.addSubview(numAwayTeamGoalsLabel)
    }

    override func styleViews() {
        timeLabel.textAlignment = .center
        timeLabel.font = .robotoRegularSize12
        timeLabel.textColor = .semiTransparentDark

        minuteLabel.textAlignment = .center
        minuteLabel.font = .robotoRegularSize12
        minuteLabel.textColor = .semiTransparentDark

        homeTeamLabel.font = .robotoRegularSize14
        homeTeamLabel.textAlignment = .left
       
        awayTeamLabel.font = .robotoRegularSize14
        awayTeamLabel.textAlignment = .left

        numHomeTeamGoalsLabel.font = .robotoRegularSize14
        numHomeTeamGoalsLabel.textAlignment = .right

        numAwayTeamGoalsLabel.font = .robotoRegularSize14
        numAwayTeamGoalsLabel.textAlignment = .right
        
        setupConstraints()
    }

    override func setupConstraints() {
        leftContainerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(rigthContainerView.snp.leading)
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(64)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerX.equalTo(leftContainerView)
            $0.width.equalToSuperview().inset(4)
            $0.top.equalTo(leftContainerView).offset(10)
        }

        minuteLabel.snp.makeConstraints {
            $0.centerX.equalTo(leftContainerView)
            $0.top.equalTo(timeLabel.snp.bottom).offset(4)
            $0.width.equalToSuperview().inset(4)
        }

        homeTeamLabel.snp.makeConstraints {
            $0.trailing.equalTo(numHomeTeamGoalsLabel.snp.leading).offset(16)
            $0.leading.equalToSuperview().inset(40)
            $0.top.equalToSuperview().inset(10)
        }

        awayTeamLabel.snp.makeConstraints {
            $0.trailing.equalTo(numAwayTeamGoalsLabel.snp.leading).offset(16)
            $0.leading.equalToSuperview().inset(40)
            $0.top.equalTo(homeTeamLabel.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(10)
        }

        homeTeamImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(16)
        }
        
        awayTeamImageView.snp.makeConstraints {
            $0.top.equalTo(homeTeamImageView.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(16)
        }
        
        numHomeTeamGoalsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(16)
        }

        numAwayTeamGoalsLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        rigthContainerView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(leftContainerView.snp.trailing)
        }
        
    }

    func configure(with event: EventViewModel) {
        homeTeamImageView.image=event.homeTeam.image
        awayTeamImageView.image=event.awayTeam.image
        homeTeamLabel.text = event.homeTeam.name
        awayTeamLabel.text = event.awayTeam.name
        timeLabel.text = event.time
        minuteLabel.text = event.minute
        
        numHomeTeamGoalsLabel.text = event.homeTeam.score != nil ? String(event.homeTeam.score!) : ""

        numAwayTeamGoalsLabel.text = event.awayTeam.score != nil ? String(event.awayTeam.score!) : ""


        
        homeTeamLabel.textColor = event.homeTeam.teamColor
        awayTeamLabel.textColor = event.awayTeam.teamColor
        
        numHomeTeamGoalsLabel.textColor = event.homeTeam.goalsColor
        numAwayTeamGoalsLabel.textColor = event.awayTeam.goalsColor
        
        minuteLabel.textColor = event.minuteColor
    }
    
}
