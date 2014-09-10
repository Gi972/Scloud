library AudioPlayer;

import 'dart:html';
import 'dart:web_audio';

class AudioPlayer {
AudioContext audiocontext;
AudioElement mediaElement;
MediaElementAudioSourceNode _source;
List<AudioElement> mediaElements;


var  _startOffset = 0;
var  _startTime = 0;


  AudioPlayer(){
    audiocontext = new AudioContext();
    mediaElement = new AudioElement();   
  }
  
  void load(AnchorElement track){
   window.console.log('load');
   window.console.log(mediaElement);
   
      createMedia(track);
      
      if(_source == null){
         _source = audiocontext.createMediaElementSource(mediaElement);
         _source.connectNode(audiocontext.destination);
       }     
      
  }
  
  void play(){ 
    if (mediaElement.paused == true){     
        mediaElement.play();    
        window.console.log('song start'); 
    }    
  }
  
  void pause(){
    if (mediaElement.paused == false){
    mediaElement.pause();
    window.console.log('song stop');
    }
  }
    
  void nextFile(Event e, AnchorElement track ){
    print("en attente");
    createMedia(track);
    play();
  }
    
  void createMedia(AnchorElement track){
       
     //var url = 'https://api.soundcloud.com/tracks/72196515/stream?client_id=b1bc52c55d66bd7de66ba86a34d434fe';
    var titre = track.title;  
    var href = track.href;
    String urlRequest = "${track.href}?client_id=b1bc52c55d66bd7de66ba86a34d434fe";
    mediaElement.src= urlRequest;
    mediaElement.title = track.title;  
    mediaElement.dataset = {"artist":"${track.dataset["artist"]}"};
    mediaElement.id = "Song${track.id}";
    
  }
    
  void previous(){}
  void next(){} 
  void seek(){}
  
}