library Controller;

import '../libs/AudioPlayer.dart';
import '../libs/SoundCloud.dart';
import '../libs/BuilderView.dart';
import 'dart:html';

class Controller{
    
ButtonElement playerPrevious;
ButtonElement playerPlay;
ButtonElement playerNext;
ButtonElement playerLoad;
ButtonElement searchSongSubmit;
ButtonElement ClearPlayList;
ButtonElement playerReload;
DivElement playerPlaylist;
DivElement playerSearchList;
DivElement searchList;
DivElement nextTrackList;
HeadingElement playerTitle;
HeadingElement playerArtist;
InputElement playerFiles;
InputElement searchSong;
LIElement activeClass;
ProgressElement  PlayerProgress;
ProgressElement  PlayerLoaded;
SpanElement playerDuration;
SpanElement PlayerCurrentime;
SpanElement nextTrack;

UListElement playlistULement;
UListElement nextTrackListULement;
SpanElement barLoad;
SpanElement barProgress;
SpanElement barSeek;
 
ButtonElement miniControlPlay;

  
AudioPlayer player; 
SoundCloud soundcloudAPI;
BuilderView builderView;
  
  init(){
   player = new AudioPlayer();
   soundcloudAPI =  new SoundCloud();
   builderView =  new BuilderView(this);
   nextTrack.text = "no Next Track";  
   
   var d = window.console ;
   
  }
  
  void loadFile(AnchorElement element){
         
    AnchorElement trackLink = element;
    var subId = element.id.substring(8);
   miniControlPlay = querySelector("#miniControlPlayer  #Play_$subId"); 
        
   if(player.mediaElement.title== ''){
      player.load(trackLink);
   }
    else{    
      if(!player.mediaElement.paused){     
        player.load(trackLink);
      } 
    }           
   }
  
   
  void play(){       
   
                          if(player.mediaElement != null){
                           
                            String trackId= player.mediaElement.id;
                                                                                                                       
                                         if(player.mediaElement.paused){          
                                           player.play();
                                           playerTitle.text = player.mediaElement.title;
                                           playerArtist.text = player.mediaElement.dataset["artist"];
                                           
                                           playerPlay.classes.add("icon-pause");
                                           playerPlay.classes.remove("icon-play");
                                           miniControlPlay.classes.add("icon-pause2");
                                           miniControlPlay.classes.remove("icon-play2");
                                          
                                           
                                         }
                                         else{
                                           player.pause();
                                           window.console.log(miniControlPlay.classes);
                                           
                                           playerPlay.classes.add("icon-play");
                                           playerPlay.classes.remove("icon-pause");                                
                                           miniControlPlay.classes.add("icon-play2");
                                           miniControlPlay.classes.remove("icon-pause2");
                                         
                                          

                                         }
                                 
                              player.mediaElement.onProgress.listen(_mediaElement_onProgress);
                              player.mediaElement.onTimeUpdate.listen(_mediaElement_timeUpdate);                                                 
    }
  }
  
  void searchSubmit(Event e){
    String searchTxt = searchSong.value;
        Map searchValues = new Map();
        searchValues = {
          "q": "$searchTxt"
        };
         
     var ta =  soundcloudAPI.getTrack(searchValues).then((e){
     //var tt = soundcloudAPI.Tracks.toString(); 
     builderView.searchListView.buildSearchList(searchList, soundcloudAPI.Tracks, this,playlistULement);    
     }, onError: (e){});
    
  }
    
  void removePlayList(Event e){
  // voir ligne 82  
   //( e.currentTarget.parentNode.parentNode as LIElement).remove();
    
  }
  
  //ClearPlayList(e,UListElement element){
  //  element.nodes.clear();
//  }
  
  void _mediaElement_timeUpdate(Event e){
    
    var ProgressValue = (player.mediaElement.currentTime / player.mediaElement.duration)*100;
       PlayerProgress.value = ProgressValue;
       barProgress.style.width=  "$ProgressValue%";
       var currentSeconds = (player.mediaElement.currentTime % 60);
       var currentMinutes = ((player.mediaElement.currentTime ~/ 60)).toString();
      
     
       currentSeconds = currentSeconds ~/1;
       if(currentSeconds < 10){
         currentSeconds = "0$currentSeconds";
       }
       PlayerCurrentime.text = "$currentMinutes : $currentSeconds";
           
           String totalSeconds = (player.mediaElement.duration % 60).toStringAsFixed(0);
           String totalMinutes = ((player.mediaElement.duration / 60) % 60).toStringAsFixed(0);
           playerDuration.text = "$totalMinutes : $totalSeconds";
    
  }
  
  void _mediaElement_onProgress(Event e){
                                var bufferLenght = 0;                               
                                for(var i= 0 ; i < player.mediaElement.buffered.length; i++ ){                        
                                  var currentBuffer = (((player.mediaElement.buffered.end(i) - player.mediaElement.buffered.start(i))*100)/ player.mediaElement.duration) ;
                                  bufferLenght = bufferLenght + currentBuffer;
                                  PlayerLoaded.value = bufferLenght;                               
                                  barLoad.style.width = "$bufferLenght%";                                 
                                }                                
                              
                                                            
  }
  
  void seekBar(MouseEvent e){ 
    print("in");
    int WidthPlayerProgress = barSeek.offsetWidth;
    
    window.console.log(WidthPlayerProgress);
    int MousePoint = e.offset.x;
    double CurrentTime = ((MousePoint*player.mediaElement.duration)/WidthPlayerProgress);
    player.mediaElement.currentTime = CurrentTime;
  }
  
  void playerMediaElement_onEnded(Event e){
    //print( a implementer);   
  }
  
  
}