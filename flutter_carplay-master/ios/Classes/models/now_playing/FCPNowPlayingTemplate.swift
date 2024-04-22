import CarPlay
import MediaPlayer

@available(iOS 14.0, *)
class FCPNowPlayingTemplate {
private(set) var _super: CPNowPlayingTemplate?
private(set) var elementId: String
private var title: String
private var systemIcon: String

  
  init(obj: [String : Any]) {
    self.elementId = obj["_elementId"] as! String
    self.title = obj["title"] as! String
    self.systemIcon = obj["systemIcon"] as? String ?? ""
  }
  
 var get: CPNowPlayingTemplate {
     let nowPlayingTemplate = CPNowPlayingTemplate.shared
     nowPlayingTemplate.tabImage = UIImage(systemName: systemIcon)
     nowPlayingTemplate.tabTitle = "Song Title"
     nowPlayingTemplate.userInfo = "Description of podcast"
//     nowPlayingTemplate.isUpNextButtonEnabled = true
//     nowPlayingTemplate.observationInfo = "Observation"
     nowPlayingTemplate.updateNowPlayingButtons(
      [CPNowPlayingButton(), 
      CPNowPlayingImageButton(), 
      CPNowPlayingMoreButton(), 
      CPNowPlayingShuffleButton(), 
      CPNowPlayingAddToLibraryButton()])
     
      
//     nowPlayingTemplate.accessibilityAttributedHint = NSAttributedString(string: "Here String ")
//     nowPlayingTemplate.accessibilityAttributedLabel = NSAttributedString(string: "Attribute Lable")
     self._super = nowPlayingTemplate
     return nowPlayingTemplate
 }
}

@available(iOS 14.0, *)
extension FCPNowPlayingTemplate: FCPRootTemplate { }
