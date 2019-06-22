import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class GalleryImagePage extends StatefulWidget {
  final images;
  GalleryImagePage({@required this.images});

  _GalleryImagePageState createState() => _GalleryImagePageState();
}

class _GalleryImagePageState extends State<GalleryImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            leading: IconButton(
              icon:Icon(Icons.arrow_back),
              onPressed: (){
                //返回上一页'
                Navigator.pop(context);
              },
              ),
            title: Text('图片'),
          ),
      backgroundColor: Colors.black,
      body: Container(       
        child:  new Swiper(
        itemBuilder: (BuildContext context,int index){
          return new Image.network(widget.images[index],fit: BoxFit.fitWidth,);
        },
        itemCount: widget.images.length,
        loop:false,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),
    ),
    );
  }
}