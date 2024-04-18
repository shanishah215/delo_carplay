import CarPlay

@available(iOS 14.0, *)
class FCPNowPlayingTemplate {
private(set) var _super: CPNowPlayingTemplate?
private(set) var elementId: String
private var title: String
//  private var buttons: [CPGridButton]
//  private var objcButtons: [FCPGridButton]
  
  init(obj: [String : Any]) {
    self.elementId = obj["_elementId"] as! String
    self.title = obj["title"] as! String
//    self.objcButtons = (obj["buttons"] as! Array<[String : Any]>).map {
//      FCPGridButton(obj: $0)
//    }
//    self.buttons = self.objcButtons.map {
//      $0.get
//    }
  }
  
//  var get: CPNowPlayingTemplate {
//    // let gridTemplate = CPGridTemplate.init(title: self.title, gridButtons: self.buttons)
//    let nowPlayingTemplate = CPNowPlayingTemplate.shared()
//    self._super = nowPlayingTemplate
//    return nowPlayingTemplate
//  }
}

@available(iOS 14.0, *)
extension FCPNowPlayingTemplate: FCPRootTemplate { }
