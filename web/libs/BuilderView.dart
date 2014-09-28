library BuilderViewLib;

import 'dart:html';
import 'dart:convert';
import '../libs/Controller.dart';
import '../libs/models/track.dart';
part '../libs/templates/playlist_view.dart';
part '../libs/templates/searchlist_view.dart';
part '../libs/templates/minicontrolplayer_view.dart';
part '../libs/templates/onair_view.dart';


class BuilderView
{
  Controller controller;
  SearchListView searchListView;
  PlaylistView  playlistView;
  OnAirView onAirView;
  MiniControlPlayer miniControlPlayer;
  
  BuilderView(Controller controller){
    this.controller = controller; 
    searchListView = new SearchListView(this);
    playlistView = new PlaylistView(this);
    miniControlPlayer = new MiniControlPlayer(this);
    onAirView = new OnAirView(this);
  }
  
  
}