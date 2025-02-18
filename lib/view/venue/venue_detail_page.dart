import 'package:flutter/material.dart';
import 'package:flutter_lapon/config/app_color.dart';
import 'package:flutter_lapon/model/venue/venue.dart';
import 'package:flutter_lapon/view/booking/booking_page.dart';
import 'package:flutter_lapon/viewmodel/venue_viewmodel.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/venue/field.dart';

class VenueDetailPage extends StatefulWidget {
  const VenueDetailPage({super.key, this.venueId});
  final dynamic venueId;

  @override
  State<VenueDetailPage> createState() => _VenueDetailPageState();
}

class _VenueDetailPageState extends State<VenueDetailPage> {
  Venue? _venue;
  Field? _selectedField;

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
        title: const Text(
          "Venue Detail",
          style: TextStyle(
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
            Image.network(
              "https://laponid.com/storage/${_venue?.image}",
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) =>
              const Center(child: Text("Can't Load Image")),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _venue?.name ?? "",
                    style: const TextStyle(
                      color: AppColor.colorPrimaryGreen,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _venue?.description ?? "",
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Lapangan yang tersedia",
                    style: TextStyle(
                      color: AppColor.colorPrimaryGreen,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _venue?.field != null && _venue!.field!.isNotEmpty
                      ? Column(
                    children: _venue!.field!.map((field) {
                      bool isSelected = _selectedField == field;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedField = field;
                          });
                        },
                        child: Card(
                          color: isSelected ? AppColor.colorPrimaryGreen.withOpacity(0.3) : Colors.white,
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    "https://laponid.com/storage/${field.image}",
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      width: 70,
                                      height: 70,
                                      color: Colors.grey[200],
                                      child: const Icon(Icons.image, color: Colors.grey),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        field.name ?? "Unknown Field",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Rp ${field.price}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.colorPrimaryGreen,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  )
                      : const Center(
                    child: Text("Tidak ada lapangan tersedia"),
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
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColor.white,
        height: 80,
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
              color: AppColor.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff94A8BE).withOpacity(0.3),
                  spreadRadius: 0.4,
                  blurRadius: 6,
                  offset: const Offset(0.5, 0),
                )
              ],
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Harga : Rp ${_selectedField?.price ?? "-"}",
                    style: const TextStyle(
                        color: Color(0xFF121212),
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                ],
              ),
              InkWell(
                onTap: _selectedField != null
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingPage(
                        venueId: widget.venueId,
                        field: _selectedField,
                      ),
                    ),
                  );
                }
                    : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
                  height: 40,
                  decoration: BoxDecoration(
                      color: _selectedField != null ? AppColor.colorPrimaryGreen : Colors.grey,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Text(
                    "Book Sekarang",
                    style: TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
