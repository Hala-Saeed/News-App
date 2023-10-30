import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_task/controller/user_information_controller.dart';

class DetailsScreen extends StatelessWidget {
  static const String routeName = '/details-screen';
  final String title, description, urlToImage, publishedAt, source;
  const DetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.publishedAt,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              UserInformationController().addToFavourites(
                  title: title,
                  publishedAt: publishedAt,
                  urlToImage: urlToImage,
                  source: source,
                  description: description);
              Fluttertoast.showToast(msg: 'Added to favourites');
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            SizedBox(
              height: size.height * .5,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                child: CachedNetworkImage(
                    placeholder: (_, s) => Container(
                          color: Colors.grey.shade200,
                        ),
                    imageUrl: urlToImage,
                    fit: BoxFit.cover),
              ),
            ),
            Container(
              height: size.height * .5,
              margin: EdgeInsets.only(top: size.height * .45),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              child: ListView(
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        source,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 3,
                      ),
                      Text(
                        publishedAt,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
