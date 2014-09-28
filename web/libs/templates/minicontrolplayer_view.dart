part of BuilderViewLib;

class MiniControlPlayer {

  BuilderView _builder;

  MiniControlPlayer(BuilderView builder) {
    _builder = builder;
  }


  SpanElement buildMiniControlPlayer(String id) {
    SpanElement miniplayer = new SpanElement();

    _builder.controller.miniControlPlay = new ButtonElement();

    miniplayer.id = "miniControlPlayer";
    miniplayer.children.add(new ButtonElement()
    //..text = "Add"
      ..className = "icon-plus"
      ..id = "ADDPLAYLIST_$id"
      ..onClick.listen(_builder.playlistView.addPlaylist_onClick));
    miniplayer.children.add(_builder.controller.miniControlPlay
    //..text = "pause"
      ..id = "Play_$id"
      ..className = "icon-play2"
      ..onClick.listen(_miniplayer_onClick));

    return miniplayer;
  }


  SpanElement buildMiniControlPlayerForPlaylist(String id) {
    SpanElement miniplayer = new SpanElement();

    _builder.controller.miniControlPlay = new ButtonElement();

    miniplayer.id = "miniControlPlayer";

    miniplayer.children.add(new ButtonElement()
    //..text = "Add"
      ..className = "icon-minus"
      ..id = id.toString()
      ..onClick.listen(_miniplayerPlaylistRemove_onClick));
    miniplayer.children.add(_builder.controller.miniControlPlay
    //..text = "pause"
      ..id = "Play_$id"
      ..className = "icon-play2"
      ..onClick.listen(_miniplayerPlaylistPlay_onClick));


    return miniplayer;
  }


  void _miniplayer_onClick(Event e) {

    String currentIdButton = (e.currentTarget as ButtonElement).id;
    String currentIdAnchor = _builder.controller.player.mediaElement.id;
    String test1 = currentIdButton.substring(5);
    String test2 = currentIdAnchor.isEmpty ? "" : currentIdAnchor.substring(12);

    window.console.log(test1);
    window.console.log(test2);

    if (test1 == test2) {
      _builder.controller.miniControlPlay = (e.currentTarget as ButtonElement);
      //window.console.log(_builder.controller.miniControlPlay);
      ((e.currentTarget as ButtonElement).parentNode.parentNode as SpanElement).classes.add("js-trackPlaying");
      _builder.controller.play();
    } else {
      //window.console.log(e.currentTarget);
      AnchorElement currentElement = (e.currentTarget as ButtonElement).parentNode.parentNode.childNodes[1].childNodes[1];

      SpanElement previousElement = querySelector(".js-trackPlaying");
      if (previousElement != null) {
        previousElement.classes.remove("js-trackPlaying");
        (previousElement.childNodes[2].childNodes[1] as ButtonElement).classes.remove("icon-pause2");
        (previousElement.childNodes[2].childNodes[1] as ButtonElement).classes.add("icon-play2");
      }

      _builder.controller.loadFile(currentElement);
      ((e.currentTarget as ButtonElement).parentNode.parentNode as SpanElement).classes.add("js-trackPlaying");
      _builder.controller.play();
    }
    e.stopPropagation();
  }

  void _miniplayerPlaylistPlay_onClick(Event e) {
   var currentId = (e.currentTarget as ButtonElement).parentNode.parentNode.childNodes[0].childNodes[1];
   // window.console.log(currentId);


   String currentIdAnchor = _builder.controller.player.mediaElement.id;
   String test1 = (e.currentTarget as ButtonElement).id.substring(13);
   String test2 = currentIdAnchor.isEmpty ? "" : currentIdAnchor.substring(12);

   if(test1 != test2){
     _builder.controller.loadFile(currentId);
   }

    _builder.controller.play();

  }

  void _miniplayerPlaylistRemove_onClick(Event e) {

    ButtonElement currentButton = e.currentTarget;
    LIElement currentTrack = (e.currentTarget as ButtonElement).parentNode.parentNode.parentNode;


    String findID = currentButton.id.isNotEmpty ? currentButton.id.substring(8) : 'no Id';
    ButtonElement findPlaylitCurrentTrack = querySelector("#searchList #ADDPLAYLIST_$findID");

    findPlaylitCurrentTrack.disabled = false;
    currentTrack.remove();

  }


}