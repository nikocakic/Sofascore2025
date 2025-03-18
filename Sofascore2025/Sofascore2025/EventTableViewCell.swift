import UIKit
import SnapKit
import SofaAcademic


class EventTableViewCell: UITableViewCell {
    static let identifier = "EventTableViewCell"

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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(homeTeamImageView)
        contentView.addSubview(leftLabel)
        contentView.addSubview(awayTeamImageView)
        //treban li dodati apsolutnom superview-u ili prvom iducem superview-u u hijerarhiji
        contentView.addSubview(timeLabel)
        contentView.addSubview(minuteLabel)
        contentView.addSubview(homeTeamLabel)
        contentView.addSubview(awayTeamLabel)
        contentView.addSubview(numHomeTeamGoalsLabel)
        contentView.addSubview(numAwayTeamGoalsLabel)

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupConstraints() {
        homeTeamImageView.translatesAutoresizingMaskIntoConstraints = false
        awayTeamImageView.translatesAutoresizingMaskIntoConstraints = false
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        minuteLabel.translatesAutoresizingMaskIntoConstraints = false
        homeTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        awayTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        numHomeTeamGoalsLabel.translatesAutoresizingMaskIntoConstraints = false
        numAwayTeamGoalsLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: leftLabel.centerXAnchor),
            timeLabel.widthAnchor.constraint(equalToConstant: 56),
            timeLabel.heightAnchor.constraint(equalToConstant: 16),
            timeLabel.topAnchor.constraint(equalTo: leftLabel.topAnchor, constant:10),
            
            minuteLabel.centerXAnchor.constraint(equalTo: leftLabel.centerXAnchor),
            minuteLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 4),
            minuteLabel.widthAnchor.constraint(equalToConstant: 56),
            minuteLabel.heightAnchor.constraint(equalToConstant: 16),
            
            leftLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            leftLabel.widthAnchor.constraint(equalToConstant: 64),
            leftLabel.heightAnchor.constraint(lessThanOrEqualTo: contentView.heightAnchor),
            
            homeTeamLabel.widthAnchor.constraint(equalToConstant: 192),
            homeTeamLabel.heightAnchor.constraint(equalToConstant: 16),
            homeTeamLabel.leadingAnchor.constraint(equalTo: leftLabel.trailingAnchor, constant: 40),
            homeTeamLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10), // FIXED

            awayTeamLabel.widthAnchor.constraint(equalToConstant: 192),
            awayTeamLabel.heightAnchor.constraint(equalToConstant: 16),
            awayTeamLabel.leadingAnchor.constraint(equalTo: leftLabel.trailingAnchor, constant: 40),
            awayTeamLabel.topAnchor.constraint(equalTo: homeTeamLabel.bottomAnchor, constant: 4), // FIXED
            
            homeTeamImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            homeTeamImageView.leadingAnchor.constraint(equalTo: leftLabel.trailingAnchor, constant: 16),
            homeTeamImageView.widthAnchor.constraint(equalToConstant: 16),
            homeTeamImageView.heightAnchor.constraint(equalToConstant: 16),
            
            awayTeamImageView.topAnchor.constraint(equalTo: homeTeamImageView.bottomAnchor, constant: 4),
            awayTeamImageView.leadingAnchor.constraint(equalTo: leftLabel.trailingAnchor, constant: 16),
            awayTeamImageView.widthAnchor.constraint(equalToConstant: 16),
            awayTeamImageView.heightAnchor.constraint(equalToConstant: 16),
            
            numHomeTeamGoalsLabel.widthAnchor.constraint(equalToConstant: 32),
            numHomeTeamGoalsLabel.heightAnchor.constraint(equalToConstant: 16),
            numHomeTeamGoalsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            numHomeTeamGoalsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            numAwayTeamGoalsLabel.widthAnchor.constraint(equalToConstant: 32),
            numAwayTeamGoalsLabel.heightAnchor.constraint(equalToConstant: 16),
            numAwayTeamGoalsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            numAwayTeamGoalsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
            
        ])
    }


    func configure(with event: Event) {
        loadImage(from: event.homeTeam.logoUrl, into: homeTeamImageView)
        loadImage(from: event.awayTeam.logoUrl, into: awayTeamImageView)
        updateMinuteLabel(from: event.status, timestamp: event.startTimestamp)
        loadHomeTeamName(from: event.homeTeam)
        loadAwayTeamName(from: event.awayTeam)
        loadScores(from: event)
    }
    
    private func loadScores(from event: Event) {
        if (event.status == .finished || event.status == .inProgress){
            numHomeTeamGoalsLabel.text = "\(event.homeScore ?? 0)"
            numAwayTeamGoalsLabel.text = "\(event.awayScore ?? 0)"
            if event.status == .inProgress{
                numAwayTeamGoalsLabel.textColor = UIColor(red: 233/255.0, green: 48/255.0, blue: 48/255.0, alpha: 1.0)
                numHomeTeamGoalsLabel.textColor = UIColor(red: 233/255.0, green: 48/255.0, blue: 48/255.0, alpha: 1.0)
            }
            
        }
    }
        
    private func loadHomeTeamName(from team: Team) {
        let name=team.name;
        homeTeamLabel.text=name
    }
    private func loadAwayTeamName(from team: Team) {
        let name=team.name;
        awayTeamLabel.text=name
    }
    
    private func updateMinuteLabel(from status: EventStatus, timestamp: Int) {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "HH:mm"
        let formattedTime = dateFormatter.string(from: date)
        
        let calendar = Calendar.current
        let minute = calendar.component(.minute, from: date)
        
        timeLabel.text = formattedTime
        minuteLabel.textColor = .black
        
        switch status {
            case .notStarted:
                minuteLabel.text = "-"
            case .inProgress:
                minuteLabel.text = "\(minute)'"
                minuteLabel.textColor = UIColor(red: 233/255.0, green: 48/255.0, blue: 48/255.0, alpha: 1.0) 
            case .finished:
                minuteLabel.text = "FT"
            case .halftime:
                minuteLabel.text = "w/e"
            }
    }

    
    

    private func loadImage(from urlString: String?, into imageView: UIImageView) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            imageView.image = UIImage(systemName: "photo") // Placeholder
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
}
