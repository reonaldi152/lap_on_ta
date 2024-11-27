import 'dart:collection';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lapon/config/app_color.dart';
import 'package:flutter_lapon/model/banner/banner_model.dart';
import 'package:flutter_lapon/model/category/category.dart';
import 'package:flutter_lapon/model/venue/venue.dart';
import 'package:flutter_lapon/view/venue/venue_detail_page.dart';
import 'package:flutter_lapon/viewmodel/auth_viewmodel.dart';
import 'package:flutter_lapon/viewmodel/banner_viewmodel.dart';
import 'package:flutter_lapon/viewmodel/venue_viewmodel.dart';

import '../../config/pref.dart';
import '../../model/user/user.dart';
import '../../widget/custom_toast.dart';
import '../base_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  final List<String> _bannerList = [
    "assets/banner1.png",
    "assets/banner2.png",
    "assets/banner1.png",
  ];

  int selectedCategory = 0;
  List<String> categories = ["Semua", "Rekomendasi", "Populer", "Terdekat"];

  @override
  void initState() {
    getUserProfile();
    getCategory();
    getBanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _users == null ? const Center(child: CircularProgressIndicator(color: AppColor.colorPrimaryGreen,)) : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + 36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _users?.name ?? "",
                    style: fontTextStyle.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Jelajahi Olahraga yang seru!",
                    style: fontTextStyle.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            CarouselSlider(
              items: _listBanner
                  .map((e) => GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(right: 6, left: 6),
                          child: Center(
                            child: Image.network(
                              "https://laponid.com/storage/${e.imageUrl ?? ""}",
                              // width: 320,
                              fit: BoxFit.cover,
                              // errorBuilder: (context, error,
                              //     stackTrace) =>
                              //     Image.asset(
                              //         "assets/placeholder_ads.png"),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
              carouselController: _controller,

              options: CarouselOptions(
                  initialPage: (_bannerList.length / 2).floor(),
                  aspectRatio: 2.4,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Text(
                "Categories",
                style: fontTextStyle.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 33),
            _listCategory.isEmpty ? Container() : SizedBox(
              height: 36,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 13, right: 26),
                itemCount: _listCategory.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  bool isSelected = selectedCategory == _listCategory[index].id;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory =
                        _listCategory[index].id;
                      });
                      getVenueByCategory(categoryId: _listCategory[index].id);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 13),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: isSelected
                              ? AppColor.colorPrimaryGreen
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(color: AppColor.colorPrimaryGreen)),
                      child: Text(
                        _listCategory[index].name,
                        style: fontTextStyle.copyWith(
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected ? AppColor.white : AppColor.colorPrimaryGreen,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            _listVenue.isEmpty ? Container() : Column(
              children: List.generate(_listVenue.length, (index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => VenueDetailPage(venueId: _listVenue[index].id,),));
                  },
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff94A8BE).withOpacity(0.3),
                            spreadRadius: 0.1,
                            blurRadius: 4,
                            offset: const Offset(0.5, 0), // changes position of shadow
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network("https://laponid.com/storage/${_listVenue[index].image ?? ""}", width: 340,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${_listVenue[index].name}", style: fontTextStyle.copyWith(color: AppColor.black, fontWeight: FontWeight.w700),),
                                const SizedBox(height: 4),
                                Text("${_listVenue[index].address}", style: fontTextStyle.copyWith(color: AppColor.black.withOpacity(0.5), fontSize: 12),),
                                const SizedBox(height: 10),
                                Text("${_listVenue[index].price}/jam", style: fontTextStyle.copyWith(color: AppColor.black, fontWeight: FontWeight.w700),),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },),
            ),

          ],
        ),
      ),
    );
  }

  Users? _users;
  getUserProfile() async {
    String? token = await Session().getUserToken();

    if (token != null) {
      AuthViewmodel().userDetail().then((value) async {
        if (value.code == 200) {
          setState(() {
            _users = Users.fromJson(value.data);
          });
        } else {
          await Session().logout();
          if (!mounted) return;
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const BasePage()),
                  (Route<dynamic> route) => false);
        }
      });
    }
  }

  List<Category> _listCategory = [];
  getCategory() {
    VenueViewmodel().category().then((value){
      if (value.code == 200){
        UnmodifiableListView listData = UnmodifiableListView(value.data);
        setState(() {
          _listCategory = listData.map((e) => Category.fromJson(e)).toList();
        });
        if (_listCategory.isNotEmpty) {
          selectedCategory = _listCategory[0].id; // Set default selected category to the first item
          getVenueByCategory(categoryId: selectedCategory);
        }
      } else {
        showToast(context: context, msg: value.message);
      }
    });
  }

  List<Venue> _listVenue = [];
  getVenueByCategory({categoryId}) {
    VenueViewmodel().venueByCategory(categoryId: categoryId).then((value){
      if (value.code == 200){
        UnmodifiableListView listData = UnmodifiableListView(value.data);
        setState(() {
          _listVenue = listData.map((e) => Venue.fromJson(e)).toList();
        });
      } else {
        setState(() {
          _listVenue = [];
        });
        // showToast(context: context, msg: value.message);
      }
    });
  }

  List<BannerModel> _listBanner = [];
  getBanner() {
    BannerViewmodel().banner().then((value){
      if (value.code == 200){
        UnmodifiableListView listData = UnmodifiableListView(value.data);
        setState(() {
          _listBanner = listData.map((e) => BannerModel.fromJson(e)).toList();
        });
        if (_listCategory.isNotEmpty) {
          selectedCategory = _listCategory[0].id; // Set default selected category to the first item
          getVenueByCategory(categoryId: selectedCategory);
        }
      } else {
        showToast(context: context, msg: value.message);
      }
    });
  }
}
