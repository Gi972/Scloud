library SoundCloud;

import 'dart:html';
import 'dart:convert';
import 'dart:async' show Future;
import '../webConfig.dart' show KeyManager; 

class SoundCloud
{
  List Tracks;
  KeyManager keymanager;

  SoundCloud(){  
    keymanager = new KeyManager();
  }
  
 Future<List> getTrack(Map options) {

    String url = "https://api.soundcloud.com/tracks.json?consumer_key=" + keymanager.KEY_ClienId + '';

    options.forEach((key, value) {
      url += "&" + key + "=" + value;
    });
    return _CallAjax(url);
    
  }
  
  Future _CallAjax(String url) {

      return HttpRequest.getString(url).then((result) => decodeJson(result)).catchError((Error error) {
        window.console.log("erreur: " + error.toString());
      });
    }
  
  void decodeJson(String result){ 
    Tracks = JSON.decode(result);
    //print(Tracks);
  }
  
  
}