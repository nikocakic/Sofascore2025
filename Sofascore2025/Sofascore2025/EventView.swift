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
    private let numHomeTeamGoalsLabel = UILabel()
    private let numAwayTeamGoalsLabel = UILabel()

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
        updateMinuteLabel(from: event.statusString, timestamp: event.startTimeString)
        loadScores(from: event)
    }


    private func loadScores(from event: EventViewModel) {
        if event.statusString == .finished || event.statusString == .inProgress {
            numHomeTeamGoalsLabel.text = "\(event.homeTeam.score ?? 0)"
            numAwayTeamGoalsLabel.text = "\(event.awayTeam.score ?? 0)"
            if event.statusString == .inProgress {
                numHomeTeamGoalsLabel.textColor = .red
                numAwayTeamGoalsLabel.textColor = .red
            }

            if event.awayTeam.score! > event.homeTeam.score! {
                homeTeamLabel.textColor = .semiTransparentDark
            }
            if event.awayTeam.score! < event.homeTeam.score! {
                awayTeamLabel.textColor = .semiTransparentDark
            }
        }
    }

    private func updateMinuteLabel(from status: EventStatus, timestamp: Int) {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        timeLabel.text = dateFormatter.string(from: date)

        let calendar = Calendar.current
        let minute = calendar.component(.minute, from: date)

        switch status {
        case .notStarted:
            minuteLabel.text = "-"
        case .inProgress:
            minuteLabel.text = "\(minute)'"
            minuteLabel.textColor = .red
        case .finished:
            minuteLabel.text = "FT"
        case .halftime:
            minuteLabel.text = "HT"
        }
    }
}
