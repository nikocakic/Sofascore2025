import UIKit
import SnapKit
import SofaAcademic

class EventView: BaseView {
    
    private var stackView : UIStackView
    private let event: Event

     public init(event: Event) {
            self.event = event
            self.stackView = UIStackView()
            self.stackView.axis = .vertical
            self.stackView.spacing = 0
            self.stackView.alignment = .fill
            super.init()
            configure(with: event)
            
    }
    
    private let homeTeamImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private let awayTeamImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

       
    private let leftLabel: UILabel = {
        let label = UILabel()
        //label.text = "test"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "Roboto-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12) // Fallback in case Roboto is not found
        return label
    }()

    
    private let minuteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12) // Fallback in case Roboto is not found
        label.textColor = .black
        return label
    }()
    
    private let homeTeamLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private let awayTeamLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private let numHomeTeamGoalsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    private let numAwayTeamGoalsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    private let mainView : UIView = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        return stackView
    }()

    



    internal override func addViews() {
        addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainView.addSubview(homeTeamImageView)
        mainView.addSubview(leftLabel)
        mainView.addSubview(awayTeamImageView)
        //treban li dodati apsolutnom superview-u ili prvom iducem superview-u u hijerarhiji
        mainView.addSubview(timeLabel)
        mainView.addSubview(minuteLabel)
        mainView.addSubview(homeTeamLabel)
        mainView.addSubview(awayTeamLabel)
        mainView.addSubview(numHomeTeamGoalsLabel)
        mainView.addSubview(numAwayTeamGoalsLabel)
        
        mainStackView.addArrangedSubview(mainView)
    }

    
    internal override func styleViews() {
        
        timeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(leftLabel)
            make.width.equalTo(56)
            make.height.equalTo(16)
            make.top.equalTo(leftLabel).offset(10)
        }
        
        minuteLabel.snp.makeConstraints { make in
            make.centerX.equalTo(leftLabel)
            make.top.equalTo(timeLabel.snp.bottom).offset(4)
            make.width.equalTo(56)
            make.height.equalTo(16)
        }
        
        leftLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainView)
            make.width.equalTo(64)
            make.height.lessThanOrEqualTo(mainView)
        }
        
        homeTeamLabel.snp.makeConstraints { make in
            make.width.equalTo(192)
            make.height.equalTo(16)
            make.leading.equalTo(leftLabel.snp.trailing).offset(40)
            make.top.equalTo(mainView).offset(10)
        }
        
        awayTeamLabel.snp.makeConstraints { make in
            make.width.equalTo(192)
            make.height.equalTo(16)
            make.leading.equalTo(leftLabel.snp.trailing).offset(40)
            make.top.equalTo(homeTeamLabel.snp.bottom).offset(4)
        }
        
        homeTeamImageView.snp.makeConstraints { make in
            make.top.equalTo(mainView).offset(10)
            make.leading.equalTo(leftLabel.snp.trailing).offset(16)
            make.width.height.equalTo(16)
        }
        
        awayTeamImageView.snp.makeConstraints { make in
            make.top.equalTo(homeTeamImageView.snp.bottom).offset(4)
            make.leading.equalTo(leftLabel.snp.trailing).offset(16)
            make.width.height.equalTo(16)
        }
        
        numHomeTeamGoalsLabel.snp.makeConstraints { make in
            make.width.equalTo(32)
            make.height.equalTo(16)
            make.top.equalTo(mainView).offset(10)
            make.trailing.equalTo(mainView).offset(-10)
        }
        
        numAwayTeamGoalsLabel.snp.makeConstraints { make in
            make.width.equalTo(32)
            make.height.equalTo(16)
            make.bottom.equalTo(mainView).offset(-10)
            make.trailing.equalTo(mainView).offset(-10)
        }
        
        mainView.snp.makeConstraints { make in
            make.width.equalTo(360)
            make.height.equalTo(56)
        }
    }



    func configure(with event: Event) {
        loadImage(from: event.homeTeam.logoUrl, into: homeTeamImageView)
        loadImage(from: event.awayTeam.logoUrl, into: awayTeamImageView)
        loadHomeTeamName(from: event.homeTeam)
        loadAwayTeamName(from: event.awayTeam)
        updateMinuteLabel(from: event.status, timestamp: event.startTimestamp)
        loadScores(from: event)
    }

    private func loadImage(from urlString: String?, into imageView: UIImageView) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            imageView.image = UIImage(systemName: "photo")
            return
        }

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
    }

    private func loadHomeTeamName(from team: Team) {
        homeTeamLabel.text = team.name
    }

    private func loadAwayTeamName(from team: Team) {
        awayTeamLabel.text = team.name
    }

    private func loadScores(from event: Event) {
        if event.status == .finished || event.status == .inProgress {
            numHomeTeamGoalsLabel.text = "\(event.homeScore ?? 0)"
            numAwayTeamGoalsLabel.text = "\(event.awayScore ?? 0)"
            if event.status == .inProgress {
                numHomeTeamGoalsLabel.textColor = UIColor.red
                numAwayTeamGoalsLabel.textColor = UIColor.red
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
            minuteLabel.textColor = UIColor.red
        case .finished:
            minuteLabel.text = "FT"
        case .halftime: //kompajler mi neda da maknem ovaj .halftime iako taj enum ne postoji
            minuteLabel.text = "w/e"
        }
    }
}
