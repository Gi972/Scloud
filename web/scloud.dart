import 'dart:html';
import 'libs/Controller.dart';


Controller control;
void main() {
     
 // nextTrack = querySelector("#nextTrack");      
 control = new Controller();
 
    control.nextTrack = querySelector("#nextTrack");
    control.playerPrevious = querySelector("#playerPrevious");
    control.playerPlay = querySelector("#playerPlay");
    control.playerNext = querySelector("#playerNext");
    control.playerLoad = querySelector("#playerLoad");
    control.playerFiles = querySelector("#files");
    control.playerPlaylist = querySelector("#playlist");
    control.playerTitle = querySelector("#playerTitle");
    control.searchSongSubmit = querySelector("#searchSongSubmit");
    control.searchSong = querySelector("#searchSong");
    control.PlayerProgress = querySelector("#PlayerProgress");
    control.playerDuration = querySelector("#playerDuration");
    control.PlayerCurrentime = querySelector("#playerCurrentime");
    control.playlistULement = querySelector("#playlistULement");
    control.ClearPlayList = querySelector("#ClearPlayList");
    control.playerReload = querySelector("#playerReload");
    control.PlayerLoaded = querySelector("#PlayerLoaded");
    control.searchList = querySelector("#searchList");
    control.nextTrackList = querySelector("#nextTrackList");
    control.nextTrackListULement = querySelector("#nextTrackListULement");
    control.barLoad = querySelector(".barLoad");
    control.barProgress = querySelector(".barProgress");
    control.barSeek = querySelector(".barSeek");
 
  control.init();
 
  control.playerPlay.onClick.listen(controlPlayerPlay_onClick);
  control.searchSongSubmit.onClick.listen(controlSearchSongSubmit_onClick);
  control.barSeek.onMouseUp.listen(controlplayerProgress_OnMouseUp);
  
  querySelectorAll("h1").onClick.listen(onclickTab); 
}


void controlPlayerPlay_onClick(Event e){
  control.play();
}

void controlSearchSongSubmit_onClick(Event e){
  control.searchSubmit(e);
}

void controlplayerProgress_OnMouseUp(Event e){
  control.seekBar(e);
}

void onclickTab(Event e){
  
 HeadingElement h1elmt = (e.currentTarget as HeadingElement);
 window.console.log(h1elmt);
 if(h1elmt.className == "active"){
   print("yes");
   
   h1elmt.classes.toggle("active", false);
 }else{
   querySelectorAll("h1").classes.toggle("active", false);
   h1elmt.classes.toggle("active", true);
   print("no");
 }
 window.console.log(h1elmt);
 
}
