part of BuilderViewLib;

class PlaylistView{
  
  BuilderView _builder;
  
  PlaylistView(BuilderView builder){
    _builder = builder;
  }
  

  void BuildPlayList(String title, String id, String href){
    var item = new Element.tag('li');
    item.nodes.add(_buildPlayListItem(title, id, href));
   _builder.controller.playlistULement.append(item);
}

   SpanElement _buildPlayListItem(String title, String id, String srcUrl) {
   SpanElement properties = new SpanElement();
    properties.onClick.listen((e){ properties.parent.className="active";});
    properties.children.add(new AnchorElement()
        ..text = title
        ..id = id.toString()
        ..href = srcUrl
        ..onClick.listen((e) => _builder.controller.loadFile(e))
        );
        
        properties.children.add(_builder.miniControlPlayer.buildMiniControlPlayer(id));
    return properties;
  }
  
   
   void addPlaylist_onClick(Event e){  
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
    
   void playListRemoveItem_onClick(Event e){ 
       ButtonElement currentButton = e.currentTarget as ButtonElement;
       (e.currentTarget as ButtonElement).parentNode.parentNode.remove();
       var playlistId= querySelector('#searchList a#${currentButton.id}');    
       (playlistId.parentNode.childNodes[2] as ButtonElement).disabled = false;
      }
 }