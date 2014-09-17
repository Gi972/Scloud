library BuilderView;
import 'dart:html';
import '../libs/Controller.dart';
import 'dart:convert';

class BuilderView
{
  Controller _controller;
  
  BuilderView(Controller controller){
    _controller= controller; 
  }

  void buildNexTrackList(AnchorElement trackLink, Controller controller){
    var item = new Element.tag('li');
    item.nodes.add(_buildNexTrackListItem(trackLink , controller));
    controller.nextTrackListULement.append(item);   
  }
  
  
   _buildNexTrackListItem(AnchorElement trackLink, Controller controller){
      SpanElement properties = new SpanElement();     
          properties.children.add(new AnchorElement()
              ..text = trackLink.title
              ..id = "Song${trackLink.id}"
              ..href = trackLink.href
              ..onClick.listen(_buildNexTrackListItem_onClick)
              );           
          return properties;        
    }
   
   void buildSearchList(DivElement fileOutput, List tracks, Controller controller,[UListElement element]){
      HtmlEscape sanitizer = new HtmlEscape();
      fileOutput.nodes.clear();
      var list = new Element.tag('ul');
      for (var tr in tracks) {
                               
            var t = new track();
            t.title = tr['title'].toString();
            t.username = tr['user']['username'];
            t.duration = tr['duration'];
            t.stream = tr['stream_url'].toString();
            t.id = tr['id'].toString();
            t.avatar_url = tr['user']['avatar_url'];                   
            var item = new Element.tag('li');  
            item.nodes.add(_BuildSearchListItem(t));
            list.nodes.add(item);
            
           }
      
      fileOutput.nodes.add(list);       
    }
    
    SpanElement _BuildSearchListItem(track track) {
      SpanElement properties = new SpanElement();
      properties.className ="searchListItem";  
      properties.children.add(new ImageElement()
          ..alt ="titre"
          ..src = track.avatar_url
      );      
      properties.children.add(
      new DivElement()
        ..className = "trackAttribute"
        ..children.add(new SpanElement()
        ..text = track.username
        ..className = "username")
        ..children.add(
      new AnchorElement()
      ..className = "title"
        ..text = track.title
        ..id = "IDTRACK_${track.id}"
        ..href = track.stream
        ..title = track.title
        ..dataset = {"artist":"${track.username}"}   
      ));          
      properties.children.add(_buildMiniControlPlayer(track.id));  
      properties.onClick.listen(_buildSearchListItem_onClick);
      return properties;
    }

  
	void BuildPlayList(String title, String id, String href){
    var item = new Element.tag('li');
    item.nodes.add(_BuildPlayListItem(title, id, href));
   _controller.playlistULement.append(item);
}

   SpanElement _BuildPlayListItem(String title, String id, String srcUrl) {
   SpanElement properties = new SpanElement();
    properties.onClick.listen((e){ properties.parent.className="active";});
    properties.children.add(new AnchorElement()
        ..text = title
        ..id = id.toString()
        ..href = srcUrl
        ..onClick.listen((e) => _controller.loadFile(e))
        );
        
        properties.children.add(_buildMiniControlPlayer(id));
    return properties;
  }
  
  //Events
  
  void _buildNexTrackListItem_onClick(Event e){  
  //_controller.loadFile(e);
  }  
  
 void _buildSearchListItem_onClick(Event e){
    e.preventDefault(); 
    SpanElement element = (e.currentTarget as SpanElement);
    AnchorElement currentTrack = (e.currentTarget as SpanElement).childNodes[1].childNodes[1];    
   
    if(_controller.player.mediaElement.paused){
    _controller.loadFile(currentTrack);
        print("load");
    }
    //todo activate the nextrack list 
    // _controller.buildNexTrackList(e);
  }
  
  void _BuildSearchListItemMiniControlplayer_onClick(Event e, SpanElement properties){
    
    print(_controller.miniControlPlay);
    
    if(_controller.miniControlPlay != null){
       _controller.miniControlPlay.remove();
    }
    
    properties.parent.className="active";    
  }
   
  void _addPlaylist_onClick(Event e){  
    ButtonElement currentButton = e.currentTarget as ButtonElement;    
    AnchorElement element = (currentButton.parentNode.parentNode as SpanElement).children[1].children[1];
   
    var playlistId= querySelector('#playlistULement a#Playlist_${element.id}');
    
    if(playlistId == null){
      currentButton.disabled = true;
      String formatId = element.id.toString();
      window.console.log(formatId);
      BuildPlayList(element.title, formatId, element.href);
      
    }else{
      window.alert('déja dans la liste');
    }
  }
  
  
  SpanElement _buildMiniControlPlayer(String id){
    SpanElement miniplayer = new SpanElement();
 
    _controller.miniControlPlay = new ButtonElement();
  
    miniplayer.id = "miniControlPlayer";         
    miniplayer.children.add(
                 new ButtonElement()
               //..text = "Add"
               ..className = "icon-plus"
               ..id = id.toString()
               ..onClick.listen(_addPlaylist_onClick)
               );
    miniplayer.children.add(
                _controller.miniControlPlay
                 //..text = "pause"
                 ..id = "Play_$id"
                 ..className = "icon-play2"
                 ..onClick.listen(_miniplayer_onClick)
                 );
    
    return miniplayer;
  }
  
  void _playListRemoveItem_onClick(Event e){ 
     ButtonElement currentButton = e.currentTarget as ButtonElement;
     (e.currentTarget as ButtonElement).parentNode.parentNode.remove();
     var playlistId= querySelector('#searchList a#${currentButton.id}');    
     (playlistId.parentNode.childNodes[2] as ButtonElement).disabled = false;
    }
  
  void _miniplayer_onClick(Event e){
    
    String currentIdButton = (e.currentTarget as ButtonElement).id;
    String currentIdAnchor = _controller.player.mediaElement.id;  
    String test1 = currentIdButton.substring(5);
    String test2 = currentIdAnchor.isEmpty ? "" : currentIdAnchor.substring(12);
    
    if( test1 == test2){
      _controller.miniControlPlay = (e.currentTarget as ButtonElement);
      ((e.currentTarget as ButtonElement).parentNode.parentNode as SpanElement).classes.add("js-trackPlaying");
      _controller.play();    
    }
    else{
      AnchorElement currentElement = (e.currentTarget  as ButtonElement).parentNode.parentNode.childNodes[1].childNodes[1];
     
   SpanElement previousElement =  querySelector(".js-trackPlaying");
   if(previousElement != null) {previousElement.classes.remove("js-trackPlaying");   
   (previousElement.childNodes[2].childNodes[1] as ButtonElement).classes.remove("icon-pause2"); 
   (previousElement.childNodes[2].childNodes[1] as ButtonElement).classes.add("icon-play2");
   }
  
      _controller.loadFile(currentElement);
      ((e.currentTarget as ButtonElement).parentNode.parentNode as SpanElement).classes.add("js-trackPlaying");
      _controller.play();    
    }   
    e.stopPropagation();
  }
 
}

class track{
  String id;
  String title;
  String username;
  String avatar_url;
  String totalTime;
  String stream;
  int duration;
}
