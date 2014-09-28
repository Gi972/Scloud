part of BuilderViewLib;

class OnAirView {

  BuilderView _builder;

  OnAirView(this._builder) {
  }

  void getImage(String id) {
    _builder.controller.OnAirTabAvatarTrack.src = _builder.controller.tracks.singleWhere((i) => i.id == id).artwork_url;
  }

  void getInfoTrack(String id) {
    Track currentTrack = _builder.controller.tracks.singleWhere((i) => i.id == id);

    _builder.controller.OnAirTabAvatarTrack.src = currentTrack.artwork_url;
    _builder.controller.infoTitle.text = currentTrack.title;
    _builder.controller.infoArtist.text = currentTrack.user__username;
    _builder.controller.infoDescription.text = currentTrack.description;
  }

  void getOption() {
  }

  void getComments() {
  }

}