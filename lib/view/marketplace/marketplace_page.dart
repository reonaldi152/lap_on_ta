import 'dart:collection';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lapon/config/app_color.dart';
import 'package:flutter_lapon/model/category_marketplace/category_marketplace.dart';
import 'package:flutter_lapon/model/product/product.dart';
import 'package:flutter_lapon/view/marketplace/product_detail/product_detail_page.dart';
import 'package:flutter_lapon/viewmodel/product_viewmodel.dart';

import '../../widget/custom_toast.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;

  final List<String> _bannerList = [
    "assets/market_banner1.png",
    "assets/market_banner2.png",
  ];

  // String selectedCategory = "All";
  // List<String> categories = ["All", "Sepak Bola", "Basket", "Futsal"];

  int selectedCategory = 0;

  @override
  void initState() {
    getCategoryMarketplace();
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff94A8BE).withOpacity(0.3),
                        spreadRadius: 0.1,
                        blurRadius: 4,
                        offset:
                            const Offset(0.5, 0), // changes position of shadow
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset("assets/ic_notif_market.png", width: 24),
                ),
                Text(
                  "Marketplace",
                  style: fontTextStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColor.black,
                    fontSize: 22,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff94A8BE).withOpacity(0.3),
                        spreadRadius: 0.1,
                        blurRadius: 4,
                        offset:
                            const Offset(0.5, 0), // changes position of shadow
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset("assets/ic_history_market.png", width: 24),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff94A8BE).withOpacity(0.3),
                        spreadRadius: 0.1,
                        blurRadius: 4,
                        offset:
                            const Offset(0.5, 0), // changes position of shadow
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset("assets/ic_cart.png", width: 24),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    flex: 13,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff94A8BE).withOpacity(0.3),
                            spreadRadius: 0.1,
                            blurRadius: 4,
                            offset: const Offset(
                                0.5, 0), // changes position of shadow
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Image.asset("assets/ic_search_market.png", width: 24),
                          Text(
                            "Search Product",
                            style: fontTextStyle.copyWith(
                                color: Color(0xFFA2A2A2)),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff94A8BE).withOpacity(0.3),
                            spreadRadius: 0.1,
                            blurRadius: 4,
                            offset: const Offset(
                                0.5, 0), // changes position of shadow
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset("assets/ic_favourite.png", width: 24),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            CarouselSlider(
              items: _bannerList
                  .map((e) => GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(right: 6, left: 6),
                          child: Center(
                            child: Image.asset(
                              e,
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
                  // initialPage: (_bannerList.length / 2).floor(),
                  aspectRatio: 2.4,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            const SizedBox(height: 16),
            _listCategoryMarketplace.isEmpty
                ? Container()
                : SizedBox(
              height: 36,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 13, right: 26),
                itemCount: _listCategoryMarketplace.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  bool isSelected =
                      selectedCategory == _listCategoryMarketplace[index].id;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = _listCategoryMarketplace[index].id;
                      });
                      getProductByCategory(
                          categoryMarketplaceId: _listCategoryMarketplace[index].id);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 13),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                          color: isSelected
                              ? AppColor.colorPrimaryGreen
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: AppColor.colorPrimaryGreen)),
                      child: Text(
                        _listCategoryMarketplace[index].name,
                        style: fontTextStyle.copyWith(
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: isSelected
                              ? AppColor.white
                              : AppColor.colorPrimaryGreen,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Text(
                    "New Arrivals",
                    style: fontTextStyle.copyWith(
                        fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  const Spacer(),
                  // Text(
                  //   "See All",
                  //   style: fontTextStyle.copyWith(
                  //     fontWeight: FontWeight.w700,
                  //     color: AppColor.colorPrimaryGreen,
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: List.generate(
                _listProduct.length,
                (index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(productId: _listProduct[index].productId,),));
                    },
                    child: Container(
                      width: 184,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0), // Margin antar item
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff94A8BE).withOpacity(0.3),
                            spreadRadius: 0.1,
                            blurRadius: 4,
                            offset:
                                const Offset(0.5, 0), // Mengatur posisi bayangan
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            "https://laponid.com/storage/${_listProduct[index].image}",
                            width: 160, // Tentukan tinggi gambar
                            fit: BoxFit
                                .cover, // Mengatur agar gambar menutupi lebar dan tinggi
                            errorBuilder:
                                (context, error, stackTrace) =>
                            const SizedBox(width: double.infinity, height: 100, child: Center(child: Text("Can't Load Image"),),),
                          ),
                          const SizedBox(
                              height: 8), // Jarak antara gambar dan teks
                          Text(
                            _listProduct[index].nameProduct ?? "",
                            style: fontTextStyle.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          // Text(
                          // "${_listProduct[index].categoryMarketplaceId}",
                          //   style: fontTextStyle.copyWith(
                          //     fontWeight: FontWeight.w700,
                          //     fontSize: 16,
                          //     color: const Color(0xFFA2A2A2),
                          //   ),
                          // ),
                          const SizedBox(
                              height: 8), // Jarak antara teks dan harga
                          Row(
                            children: [
                              Text(
                                "${_listProduct[index].price}",
                                style: fontTextStyle.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: AppColor.colorPrimaryGreen,
                                ),
                                child: Icon(Icons.add, color: AppColor.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
            ),
            const SizedBox(height: 30),

            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => ProductDetailPage(),
            //         ));
            //   },
            //   child: Card(
            //     margin: const EdgeInsets.symmetric(horizontal: 24),
            //     color: AppColor.white,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(16.0),
            //     ),
            //     elevation: 4.0,
            //     child: Padding(
            //       padding: const EdgeInsets.all(16.0),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Align(
            //             alignment: Alignment.topRight,
            //             child: Icon(
            //               Icons.favorite_border,
            //               color: Colors.teal,
            //             ),
            //           ),
            //           // Center(
            //           //   child: Image.network(
            //           //     'https://moltensports.com/images/products/20200807_162244basketball-GG7X-700px.png',
            //           //     width: 120,
            //           //     height: 120,
            //           //   ),
            //           // ),
            //           Center(
            //             child: Image.asset(
            //               'assets/basket.png',
            //               width: 120,
            //               height: 120,
            //             ),
            //           ),
            //           SizedBox(height: 16.0),
            //           Text(
            //             'For Lifestyle',
            //             style: fontTextStyle.copyWith(
            //               color: Colors.grey,
            //               fontSize: 12.0,
            //             ),
            //           ),
            //           Text(
            //             'Basket Ball',
            //             style: fontTextStyle.copyWith(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 18.0,
            //             ),
            //           ),
            //           SizedBox(height: 8.0),
            //           Text(
            //             'This edition features bold pops of color & amplified detailing.',
            //             style: fontTextStyle.copyWith(
            //               color: Colors.grey,
            //               fontSize: 12.0,
            //             ),
            //           ),
            //           SizedBox(height: 16.0),
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 'Rp 990.000',
            //                 style: fontTextStyle.copyWith(
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 16.0,
            //                 ),
            //               ),
            //               // ElevatedButton(
            //               //   style: ElevatedButton.styleFrom(
            //               //     shape: RoundedRectangleBorder(
            //               //       borderRadius: BorderRadius.circular(20.0),
            //               //     ),
            //               //   ),
            //               //   onPressed: () {},
            //               //   child: Text('Sewa'),
            //               // ),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 30),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Row(
            //     children: [
            //       Text(
            //         "By Categories",
            //         style: fontTextStyle.copyWith(
            //             fontWeight: FontWeight.w700, fontSize: 16),
            //       ),
            //       const Spacer(),
            //       Text(
            //         "See All",
            //         style: fontTextStyle.copyWith(
            //           fontWeight: FontWeight.w700,
            //           color: AppColor.colorPrimaryGreen,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }


  List<CategoryMarketplace> _listCategoryMarketplace = [];
  getCategoryMarketplace() {
    ProductViewmodel().categoryMarketplace().then((value) {
      if (value.code == 200) {
        UnmodifiableListView listData = UnmodifiableListView(value.data);
        setState(() {
          _listCategoryMarketplace = listData.map((e) => CategoryMarketplace.fromJson(e)).toList();
        });
        if (_listCategoryMarketplace.isNotEmpty) {
          selectedCategory = _listCategoryMarketplace[0]
              .id; // Set default selected category to the first item
          getProductByCategory(categoryMarketplaceId: selectedCategory);
        }
      } else {
        if (!mounted) return;

        showToast(context: context, msg: value.message);
      }
    });
  }

  List<Product> _listProduct = [];
  getProductByCategory({required int categoryMarketplaceId}) async {
    try {
      final value =
      await ProductViewmodel().productByCategory(categoryMarketplaceId: categoryMarketplaceId);

      if (value.code == 200) {
        if (value.data != null && value.data is List) {
          setState(() {
            _listProduct = (value.data as List)
                .map((e) => Product.fromJson(e))
                .toList();
          });
        } else {
          setState(() {
            _listProduct = [];
          });
          if (!mounted) return;
          showToast(context: context, msg: "Data venue tidak valid");
        }
      } else {
        setState(() {
          _listProduct = [];
        });
        if (!mounted) return;
        showToast(context: context, msg: value.message);
      }
    } catch (e) {
      setState(() {
        _listProduct = [];
      });
      if (!mounted) return;
      showToast(context: context, msg: "Terjadi kesalahan: $e");
    }
  }
}
