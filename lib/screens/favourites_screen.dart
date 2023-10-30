import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app_task/controller/news_controller.dart';
import 'package:news_app_task/models/favourite_model.dart';

import '../controller/user_information_controller.dart';
import 'details_screen.dart';

class FavouritesScreen extends StatelessWidget {
  static const routeName = '/favourites-screen';

  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        body: FutureBuilder<List<FavouriteModel>>(
            future: UserInformationController().getFavourites(),
            builder: (context, snapshot) {
              print(snapshot.connectionState);
              if (snapshot.connectionState == ConnectionState.waiting &&
                  snapshot.connectionState == ConnectionState.none ) {
                return const Center(
                  child: SpinKitCircle(
                    color: Colors.blue,
                  ),
                );
              } else {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                      final item = snapshot.data![index];
                      return InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, DetailsScreen.routeName,
                              arguments: {
                                'title': item.title.toString(),
                                'description': item.description.toString(),
                                'urlToImage': item.urlToImage.toString(),
                                'publishedAt': item.publishedAt,
                                'source': item.source.toString(),
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
                                            child: Text(item.source.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                fontSize: 12, fontWeight: FontWeight.w600, ),),
                                          ),

                                          Text(item.publishedAt,
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
              }
            }));
  }
}
