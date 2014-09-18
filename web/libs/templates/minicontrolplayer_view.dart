part of BuilderViewLib;
 
class MiniControlPlayer{

BuilderView _builder;
  
MiniControlPlayer(BuilderView builder){
 _builder = builder;
  
}
  
  
SpanElement buildMiniControlPlayer(String id){
    SpanElement miniplayer = new SpanElement();
 
    _builder.controller.miniControlPlay = new ButtonElement();
  
    miniplayer.id = "miniControlPlayer";         
    miniplayer.children.add(
                 new ButtonElement()
               //..text = "Add"
               ..className = "icon-plus"
               ..id = id.toString()
               ..onClick.listen(_builder.playlistView.addPlaylist_onClick)
               );
    miniplayer.children.add(
        _builder.controller.miniControlPlay
                 //..text = "pause"
                 ..id = "Play_$id"
                 ..className = "icon-play2"
                 ..onClick.listen(_miniplayer_onClick)
                 );
    
    return miniplayer;
  }

void _miniplayer_onClick(Event e){
   
   String currentIdButton = (e.currentTarget as ButtonElement).id;
   String currentIdAnchor = _builder.controller.player.mediaElement.id;  
   String test1 = currentIdButton.substring(5);
   String test2 = currentIdAnchor.isEmpty ? "" : currentIdAnchor.substring(12);
   
   if( test1 == test2){
     _builder.controller.miniControlPlay = (e.currentTarget as ButtonElement);
     ((e.currentTarget as ButtonElement).parentNode.parentNode as SpanElement).classes.add("js-trackPlaying");
     _builder.controller.play();    
   }
   else{
     AnchorElement currentElement = (e.currentTarget  as ButtonElement).parentNode.parentNode.childNodes[1].childNodes[1];
    
  SpanElement previousElement =  querySelector(".js-trackPlaying");
  if(previousElement != null) {previousElement.classes.remove("js-trackPlaying");   
  (previousElement.childNodes[2].childNodes[1] as ButtonElement).classes.remove("icon-pause2"); 
  (previousElement.childNodes[2].childNodes[1] as ButtonElement).classes.add("icon-play2");
  }
 
     _builder.controller.loadFile(currentElement);
     ((e.currentTarget as ButtonElement).parentNode.parentNode as SpanElement).classes.add("js-trackPlaying");
     _builder.controller.play();    
   }   
   e.stopPropagation();
 }

}