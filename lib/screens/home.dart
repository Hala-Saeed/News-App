import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app_task/controller/news_controller.dart';
import 'package:news_app_task/models/headline_model.dart';
import 'package:news_app_task/screens/details_screen.dart';
import 'package:news_app_task/screens/favourites_screen.dart';

import '../models/categories_model.dart';
import 'profile_screen.dart';

class Home extends StatefulWidget {
  static const routeName = '/Home-screen';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

enum NewsChannels{
  bbc('bbc-news'),
  ary('ary-news'),
  alJazeera('al-jazeera-english'),
  cbc('cbc-news'),
  abcNews('abc-news');

  final String value;
  const NewsChannels(this.value);
}

class _HomeState extends State<Home> {
  late NewsController newsController;
  final format = DateFormat('MMMM dd, yyyy');
  String sourceName = NewsChannels.bbc.value;

  @override
  void initState() {
    super.initState();
    newsController = NewsController();
  }

  //Loader
  spinKit(){
    return const Center(
      child: SpinKitCircle(
        color: Colors.blue,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('News',
        style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black),),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.person, color: Colors.black,),
          onPressed: (){
            Navigator.pushNamed(context, ProfileScreen.routeName);
          },
        ),
        elevation: 0,
        actions: [

          InkWell(
              onTap: (){
                Navigator.pushNamed(context, FavouritesScreen.routeName);
              },
              child: const Icon(Icons.favorite_outline, color: Colors.red,)),


          PopupMenuButton(
            icon: const Icon(Icons.more_vert_outlined, color: Colors.black, size: 26,),
              onSelected: (item){
                if(item.name == NewsChannels.bbc.name){
                  sourceName = NewsChannels.bbc.value;
                }
                else if(item.name == NewsChannels.ary.name){
                  sourceName = NewsChannels.ary.value;
                }
                else if(item.name == NewsChannels.alJazeera.name){
                  sourceName = NewsChannels.alJazeera.value;
                }
                else if(item.name == NewsChannels.cbc.name){
                  sourceName = NewsChannels.cbc.value;
                }
                else if(item.name == NewsChannels.abcNews.name){
                  sourceName = NewsChannels.abcNews.value;
                }

              setState(() {});
              },

              itemBuilder: (context) => <PopupMenuEntry<NewsChannels>>[
                const PopupMenuItem(value: NewsChannels.bbc,child: Text('BBC News')),
                const PopupMenuItem(value: NewsChannels.ary,child: Text('ARY News')),
                const PopupMenuItem(value: NewsChannels.cbc,child: Text('CBC News')),
                const PopupMenuItem(value: NewsChannels.abcNews,child: Text('ABC News')),
                const PopupMenuItem(value: NewsChannels.alJazeera,child: Text('AlJazeera')),

          ]),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height*.55,
              width: size.width,
              child: FutureBuilder<NewsHeadLineModel>(
                future: newsController.fetchNewsHeadLines(sourceName),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return spinKit();
                  }
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index){
                         final item = snapshot.data!.articles![index];
                         final dateTime = DateTime.parse(item.publishedAt.toString());
                         return InkWell(
                           onTap: (){
                             Navigator.pushNamed(context, DetailsScreen.routeName,
                                 arguments: {
                               'title': item.title.toString(),
                               'description': item.description.toString(),
                               'urlToImage': item.urlToImage.toString(),
                               'publishedAt': format.format(dateTime),
                               'source': item.source!.name.toString(),
                             });
                           },
                           child: Stack(
                             alignment: Alignment.center,
                             children: [
                               Padding(
                                 padding:  EdgeInsets.symmetric(horizontal: size.width * .015, vertical: size.height*.01),
                                 child: SizedBox(
                                   height: size.height * .55,
                                   width: size.width * .9,
                                   child: ClipRRect(
                                     borderRadius: BorderRadius.circular(20),
                                     child: CachedNetworkImage(
                                       imageUrl: item.urlToImage.toString(),
                                       placeholder: (context, _) => spinKit(),
                                       errorWidget: (context, url, _) => const Icon(Icons.error_outline, size: 20,),
                                       fit: BoxFit.cover,
                                     ),
                                   ),
                                 ),
                               ),

                               Positioned(
                                 bottom: 20,
                                 child: SizedBox(
                                   height: size.height * 0.17,
                                   width: size.width * 0.8,
                                   child: Card(
                                     color: Colors.white,
                                     shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(20),
                                     ),
                                     child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Column(
                                         mainAxisSize: MainAxisSize.min,
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         children: [
                                           Text(item.title.toString(),
                                           style: GoogleFonts.poppins(
                                             fontSize: 16, fontWeight: FontWeight.bold,
                                           ),
                                           maxLines: 3, overflow: TextOverflow.ellipsis,),

                                           const Spacer(),

                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               Text(item.source!.name.toString(),
                                                 style: GoogleFonts.poppins(
                                                   fontSize: 15, fontWeight: FontWeight.w600,),),

                                               Text(format.format(dateTime),
                                                 style: GoogleFonts.poppins(
                                                   fontSize: 15, fontWeight: FontWeight.w600,),),
                                             ],
                                           ),
                                         ],

                                       ),),),),),],),
                         );});},),),

            // General News
            FutureBuilder<CategoriesModel>(
              future: newsController.fetchNews(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return spinKit();
                }
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index){
                      final item = snapshot.data!.articles![index];
                      final dateTime = DateTime.parse(item.publishedAt.toString());
                      return InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, DetailsScreen.routeName,
                              arguments: {
                                'title': item.title.toString(),
                                'description': item.description.toString(),
                                'urlToImage': item.urlToImage.toString(),
                                'publishedAt': format.format(dateTime),
                                'source': item.source!.name.toString(),
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 17),
                          child: SizedBox(
                            height: size.height * .2,
                            width: size.width * 1,
                            child: Row(
                              children: [

                                SizedBox(
                                  height: size.height * .25,
                                  width: size.width * .3,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                                    child: CachedNetworkImage(
                                       placeholder:(_,s) =>  Container(color: Colors.grey.shade200,),
                                        imageUrl: item.urlToImage.toString(),
                                        fit: BoxFit.cover),
                                  ),
                                ),

                              const SizedBox(width: 13,),

                              SizedBox(
                                width: size.width * .6,
                                height: size.height * .19,
                                child: Column(
                                  children: [
                                    Text(item.title.toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 14, fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 3, overflow: TextOverflow.ellipsis,),

                                    const Spacer(),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: Text(item.author.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12, fontWeight: FontWeight.w600, ),),
                                        ),

                                        Text(format.format(dateTime),
                                          style: GoogleFonts.poppins(
                                            fontSize: 12, fontWeight: FontWeight.w600,),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                    ),
                        ),
                      );
                  }
              );
            },
            ),
          ],
        ),
      ),
    );
  }
}
