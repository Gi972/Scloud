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
InputElement playerFiles;
InputElement searchSong;
LIElement activeClass;
ProgressElement  PlayerProgress;
ProgressElement  PlayerLoaded;
SpanElement playerDuration;
SpanElement PlayerCurrentime;
SpanElement nextTrack;
ButtonElement miniControlPlay;
UListElement playlistULement;
UListElement nextTrackListULement;
SpanElement barLoad;
SpanElement barProgress;
SpanElement barSeek;
  
  
AudioPlayer player; 
SoundCloud soundcloudAPI;
BuilderView builderView;
  
  init(){
   player = new AudioPlayer();
   soundcloudAPI =  new SoundCloud();
   builderView =  new BuilderView(this);
   nextTrack.text = "no Next Track";
  }
  
  void loadFile(AnchorElement element){
         
    AnchorElement trackLink = element;
    
   if(player.mediaElement.title== ''){
    print('first time');
     player.load(trackLink);
   }
    else{    
      if(!player.mediaElement.paused){
        player.load(trackLink);
      } 
    }
             
   }
  
  void buildNexTrackList(e){
    e.preventDefault();
    AnchorElement trackLink = (e.currentTarget as AnchorElement);   
    builderView.buildNexTrackList(trackLink, this); 
  }
   
  void play(){        
                          if(player != null){
                           
                            String trackId= player.mediaElement.id;
                            
                                                                  
                                         if(player.mediaElement.paused){
                                         player.play();
                                         playerTitle.text = player.mediaElement.title;
                                         playerPlay.text= "play";
                                           
                                         }
                                         else{
                                         player.pause();
                                         playerPlay.text= "pause";
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
     builderView.buildSearchList(searchList, soundcloudAPI.Tracks, this,playlistULement);    
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