class MyAd {

    String? imageUrl;
    String? text;
    String? url;

    MyAd({
      this.imageUrl,
      this.text,
      this.url
    });

      MyAd fromMap(Map<dynamic, dynamic> json) {
    return MyAd(
      imageUrl: json['imageUrl'],
      text: json['text'],
      url: json['url'],
    );
  }

  factory MyAd.fromMap(Map<String, dynamic> json) => new MyAd(
      imageUrl: json['imageUrl'],
      text: json['text'],
      url: json['url'],
      );

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': this.imageUrl,
      'text': this.text,
      'url': this.url,
    };
  }
}
