import 'package:calcular_preco_venda/objects/MyAd.dart';
import 'package:calcular_preco_venda/services/FirebaseRemoteConfig.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAdWidget extends StatefulWidget {
  final int? AdSize;
  MyAdWidget({this.AdSize, Key? key}) : super(key: key);

  @override
  State<MyAdWidget> createState() => _MyAdWidgetState();
}

class _MyAdWidgetState extends State<MyAdWidget> {
  List<MyAd> AdList = [];

  @override
  void initState() {
    super.initState();
    getAdList();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = AdList.map((item) => TextButton(
          // Link para o anuncio
          onPressed: () => launchUrl(Uri.tryParse(item.url!)!),
          child: Container(
            margin: EdgeInsets.all(1.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Imagem do anuncio
                    imageWidget(item),

                    // Texto do anuncio
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        '${item.text}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        )).toList();

    return Container(
      child: Column(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              autoPlayInterval: const Duration(seconds: 5),
              height:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? MediaQuery.of(context).size.height - 80
                      : MediaQuery.of(context).size.height - 200,
              autoPlay: true,
              // aspectRatio: 1.5,
              enlargeCenterPage: false,
            ),
            items: imageSliders,
          ),
        ],
      ),
    );
  }

// Obtem a lista de anuncios
  getAdList() async {
    for (var i = 0; i < widget.AdSize!; i++) {
      var myAdImage = await FirebaseRemoteConfig().getMyAdImage(i);
      var myAdText = await FirebaseRemoteConfig().getMyAdText(i);
      var myAdUrl = await FirebaseRemoteConfig().getMyLinkAd(i);

      if ((myAdImage != null && myAdImage.isNotEmpty) &&
          (myAdText != null && myAdText.isNotEmpty) &&
          (myAdUrl != null && myAdUrl.isNotEmpty)) {
        AdList.add(MyAd(imageUrl: myAdImage, text: myAdText, url: myAdUrl));
      }
    }
    setState(() {});
  }

  // Define o tamanho da imagem de acordo com a orientacao
  imageWidget(MyAd item) {
    print(
        "MediaQuery.of(context).orientation = ${MediaQuery.of(context).orientation}");
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return Expanded(
        child: Image.network(
          item.imageUrl!,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width * 0.9,
        ),
      );
    } else {
      return Image.network(
        item.imageUrl!,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }
  }
}
