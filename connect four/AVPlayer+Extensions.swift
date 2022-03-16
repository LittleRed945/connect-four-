import AVFoundation

extension AVPlayer{
    static let sharedChessPlayer:AVPlayer={
        guard let url = Bundle.main.url(forResource: "chess", withExtension: "mp3")else{
            fatalError("Failed to find sound file.")
        }
        return AVPlayer(url:url)
    }()
    static let sharedBGMPlayer:AVPlayer={
        guard let url = Bundle.main.url(forResource: "BGM", withExtension: "mp3")else{
            fatalError("Failed to find sound file.")
        }
        return AVPlayer(url:url)
    }()
    func playFromStart(){
        seek(to:.zero)
        play()
    }
}
