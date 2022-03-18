import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/service_icon.dart';

class PostWidget extends StatefulWidget {
  final PostModel post;
  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late ThemeProvider themeProvider;
  @override
  Widget build(BuildContext context) {
    PostModel post = widget.post;
    ProfileModel profile = post.profile;
    ServiceModel service = profile.service;
    themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
        width: 400,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: themeProvider.themeData().primaryColor),
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Text(profile.fullName),
                      if (post.isArchived != null)
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Icon(Iconsax.archive_tick, size: 14),
                        )
                    ]),
                    //Text(widget.post.title ?? "No title"),
                    Row(
                      children: [
                        Text(
                            DateFormat('dd/MM/yyyy, HH:mm')
                                .format(post.timestamp),
                            style: const TextStyle(
                                color: Color(0xFFABAAB8), fontSize: 12)),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: ServiceIcon(service: service, size: 12),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Text(post.description ?? "No description",
                    style: const TextStyle(fontSize: 11)),
                const SizedBox(height: 10),
                Row(
                    children: post.tags != null
                        ? List.generate(
                            post.mentions!.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Text("#${post.tags![index].name}",
                                      style: const TextStyle(fontSize: 11)),
                                ))
                        : []),
                const SizedBox(height: 10),
                Row(
                    children: post.mentions != null
                        ? List.generate(
                            post.mentions!.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Text("@${post.mentions![index].name}",
                                      style: const TextStyle(
                                          color: Color(0xFFABAAB8),
                                          fontSize: 11)),
                                ))
                        : []),
                const SizedBox(height: 10),
                if (post.medias != null)
                  CarouselSlider(
                    options: CarouselOptions(
                      enlargeCenterPage: false,
                      viewportFraction: 1.0,
                    ),
                    items: post.medias!
                        .map(
                            (item) => Center(child: Image.asset(item.uri.path)))
                        .toList(),
                  ),
                const SizedBox(height: 10),
                Text(
                  post.title ?? "No title",
                  style:
                      const TextStyle(color: Color(0xFFABAAB8), fontSize: 10),
                ),
              ],
            )));
  }
}
