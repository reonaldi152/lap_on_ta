import 'package:flutter/material.dart';
import 'package:flutter_lapon/config/app_color.dart';
import 'package:flutter_lapon/model/venue/venue.dart';
import 'package:flutter_lapon/view/booking/booking_page.dart';
import 'package:flutter_lapon/viewmodel/venue_viewmodel.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class VenueDetailPage extends StatefulWidget {
  const VenueDetailPage({super.key, this.venueId});
  final dynamic venueId;

  @override
  State<VenueDetailPage> createState() => _VenueDetailPageState();
}

class _VenueDetailPageState extends State<VenueDetailPage> {
  Venue? _venue;

  @override
  void initState() {
    getDetailVenue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text(
          "Venue Detail",
          style: fontTextStyle.copyWith(
              color: AppColor.colorPrimaryGreen, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColor.colorPrimaryGreen,
            size: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 36),
                  child: Image.network(
                    "https://laponid.com/storage/${_venue?.image}",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder:
                        (context, error, stackTrace) =>
                    const Center(child: Text("Can't Load Image"),),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 300),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      color: AppColor.white),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 26),
                        Text(
                          _venue?.name ?? "",
                          style: fontTextStyle.copyWith(
                            color: AppColor.colorPrimaryGreen,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.location_pin),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                _venue?.owner?.storeAddress ?? "No address available",
                                style: fontTextStyle.copyWith(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Text(
                          _venue?.description ?? "",
                          style: fontTextStyle.copyWith(fontSize: 12),
                        ),
                        const SizedBox(height: 36),
                        Text(
                          "Lokasi",
                          style: fontTextStyle.copyWith(
                            color: AppColor.colorPrimaryGreen,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 300,
                          child: _venue?.latitude != null && _venue?.longitude != null
                              ? FlutterMap(
                            options: MapOptions(
                              initialCenter: LatLng(_venue?.latitude, _venue?.longitude), // Center the map over London
                              initialZoom: 16,
                            ),
                            children: [
                              TileLayer( // Display map tiles from any source
                                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
                                userAgentPackageName: 'com.example.app',
                                // And many more recommended properties!
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point: LatLng(_venue?.latitude, _venue?.longitude),
                                    width: 80,
                                    height: 80,
                                    child:  const Icon(Icons.location_pin, color: Colors.red,),
                                  ),
                                ],
                              ),
                              RichAttributionWidget( // Include a stylish prebuilt attribution widget that meets all requirments
                                attributions: [
                                  TextSourceAttribution(
                                    'OpenStreetMap contributors',
                                    onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')), // (external)
                                  ),
                                  // Also add images...
                                ],
                              ),
                            ],
                          )
                              : Center(
                            child: Text(
                              "Peta tidak tersedia",
                              style: fontTextStyle.copyWith(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xff94A8BE).withOpacity(0.3),
                                spreadRadius: 0.4,
                                blurRadius: 6,
                                offset: const Offset(0.5, 0), // changes position of shadow
                              )
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mulai dari",
                                    style: fontTextStyle.copyWith(
                                      color: const Color(0xFF121212),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "${_venue?.price}",
                                    style: fontTextStyle.copyWith(
                                        color: const Color(0xFF121212),
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookingPage(
                                        venueId: widget.venueId,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 11, horizontal: 16),
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColor.colorPrimaryGreen,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    "Book Sekarang",
                                    style: fontTextStyle.copyWith(
                                      color: AppColor.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void getDetailVenue() {
    VenueViewmodel().detailVenue(venueid: widget.venueId).then((value) {
      if (value.code == 200) {
        setState(() {
          _venue = Venue.fromJson(value.data);
        });
      }
    });
  }
}
