class Architects{

  String? imageUrl;
  String? name;
  String? designs;
  double? rating;

  Architects({this.imageUrl, this.name, this.designs, this.rating});

  toMap() => {
    "imageUrl": imageUrl,
    "name": name,
    "designs": designs,
    "rating": rating
  };

  @override
  String toString() {
    return 'Restaurant{imageUrl: $imageUrl, name: $name, designs: $designs, rating: $rating}';
  }
}