class Design{
  String? aboutProject;
  String? imageUrl;

  Design({this.imageUrl, this.aboutProject});

  toMap(){
    return {
      "imageUrl": imageUrl,
      "about project": aboutProject
    };
  }
}