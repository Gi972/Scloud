part of BuilderViewLib;

class SearchListView{

 BuilderView _builder;

 SearchListView(BuilderView builder){
   _builder = builder;
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
      properties.children.add(_builder.miniControlPlayer.buildMiniControlPlayer(track.id));  
      properties.onClick.listen(_buildSearchListItem_onClick);
      return properties;
    }

  

  //Events
   
 void _buildSearchListItem_onClick(Event e){
    e.preventDefault(); 
    SpanElement element = (e.currentTarget as SpanElement);
    AnchorElement currentTrack = (e.currentTarget as SpanElement).childNodes[1].childNodes[1];    
   
    if(_builder.controller.player.mediaElement.paused){
    _builder.controller.loadFile(currentTrack);
        print("load");
    }
  }
  
  void _BuildSearchListItemMiniControlplayer_onClick(Event e, SpanElement properties){
    
    print(_builder.controller.miniControlPlay);
    
    if(_builder.controller.miniControlPlay != null){
      _builder.controller.miniControlPlay.remove();
    }
    
    properties.parent.className="active";    
  }
    
 
  
}