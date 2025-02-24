import 'package:flutter/material.dart';
import 'package:flutter_lapon/model/venue/field.dart';
import 'package:flutter_lapon/view/payment/payment_webview_page.dart';
import 'package:flutter_lapon/viewmodel/booking_viewmodel.dart';
import 'package:flutter_lapon/viewmodel/checkout_viewmodel.dart';
import 'package:flutter_lapon/widget/custom_toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/app_color.dart';
import '../../model/venue/venue.dart';
import '../../viewmodel/venue_viewmodel.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    super.key,
    this.venueId,
    this.categoryId,
    this.bookingDate,
    this.timeSlots,
    this.totalPayment,
    this.field,
  });

  final dynamic venueId;
  final dynamic categoryId;
  final dynamic bookingDate;
  final List<Map<String, dynamic>>? timeSlots;
  final dynamic totalPayment;
  final Field? field;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  dynamic code;
  bool isLoading = false;
  Venue? _venue;
  int bookingId = 0;

  @override
  void initState() {
    super.initState();
    postBooking();
    getDetailVenue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorPrimaryGreen,
      appBar: AppBar(
        backgroundColor: AppColor.colorPrimaryGreen,
        title: Text(
          "Check Out",
          style: fontTextStyle.copyWith(
              color: AppColor.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.only(top: 12),
        decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      "https://laponid.com/storage/${_venue?.image}",
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  _venue?.name ?? "",
                  style: fontTextStyle.copyWith(
                      color: AppColor.colorPrimaryGreen,
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_pin),
                    const SizedBox(width: 4),
                    Text(
                      _venue?.address ?? "",
                      style: fontTextStyle.copyWith(fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 36),
                Text(
                  "Jadwal Booking",
                  style: fontTextStyle.copyWith(
                    color: AppColor.colorPrimaryGreen,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _venue?.name ?? "",
                      style: fontTextStyle.copyWith(
                          color: AppColor.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    dateBooking.length, // Loop through the list of bookings
                        (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        dateBooking[index],
                        style: fontTextStyle.copyWith(
                          color: const Color(0xFF6F737A),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Column(children: List.generate(startTime.length, (index) => Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColor.colorPrimaryGreen.withOpacity(0.5), // Warna background baris hijau muda
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          "${startTime[index]} - ${endTime[index]}",
                          style: fontTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Text(
                          "${widget.field?.price}",
                          style: fontTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF4B6975), // Warna harga sesuai gambar
                          ),
                        ),
                      ),
                    ],
                  ),
                ),),),
                const SizedBox(height: 26),
                Text(
                  'Checkout Review',
                  style: fontTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: AppColor.colorPrimaryGreen, // Warna hijau teks header
                  ),
                ),
                const SizedBox(height: 16),
                Column(children: List.generate(total.length, (index) => _buildRow('Biaya Sewa', total[index]),),),

                const SizedBox(height: 8),
                _buildRow('Admin', '', isLink: true),
                const SizedBox(height: 8),
                _buildRow('PPN (11%)', ''),
                Divider(thickness: 1, color: Colors.grey[300]),
                const SizedBox(height: 8),
                Column(children: List.generate(total.length, (index) => _buildRow('Total', total[index]),),),
                Divider(thickness: 1, color: Colors.grey[300]),
                const SizedBox(height: 8),

                const SizedBox(height: 36),
              ],
            ),
          ),
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
                offset: const Offset(0.5, 0), // Changes position of shadow
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
                  // Display total sessions dynamically
                  Text(
                    "Total : ${bookingIds.length} Sesi terpilih",
                    style: fontTextStyle.copyWith(
                      color: const Color(0xFF121212),
                      fontSize: 12,
                    ),
                  ),
                  // Display combined total payment
                  Text(
                    "Rp ${total.fold<int>(0, (prev, amount) => prev + int.parse(amount))}",
                    style: fontTextStyle.copyWith(
                      color: const Color(0xFF121212),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  if (bookingIds.isNotEmpty) {
                    setState(() {
                      isLoading = true;
                    });
                    postCheckout();
                  } else {
                    showToast(context: context, msg: "Pilih setidaknya satu sesi sebelum checkout!");
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColor.colorPrimaryGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: isLoading
                      ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.white,
                      strokeWidth: 2,
                    ),
                  )
                      : Text(
                    "Checkout Sekarang",
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
      ),
    );
  }

  Widget _buildRow(String title, String value, {bool isLink = false, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isLink
            ? InkWell(
          onTap: () {
            // Aksi ketika teks link ditekan
          },
          child: Text(
            title,
            style: fontTextStyle.copyWith(
              fontSize: 16,
              color: const Color(0xFF4B6975), // Warna link biru
              decoration: TextDecoration.underline,
            ),
          ),
        )
            : Text(
          title,
          style: fontTextStyle.copyWith(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: fontTextStyle.copyWith(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: const Color(0xFF4B6975), // Warna teks angka
          ),
        ),
      ],
    );
  }

  List<int> bookingIds = [];
  List<dynamic> dateBooking = [], total = [], startTime = [], endTime = [];

  void postBooking() async {
    BookingViewmodel().booking(
      venueId: widget.venueId,
      fieldId: widget.field?.id,
      bookingDate: widget.bookingDate is List ? widget.bookingDate : [widget.bookingDate],
      taxPercentage: "11",
      timeSlots: widget.timeSlots,
    ).then((value) {
      if (value.code == 200) {
        // Clear existing lists before adding new bookings
        bookingIds.clear();
        dateBooking.clear();
        total.clear();
        startTime.clear();
        endTime.clear();

        // Extract data from response and update lists
        for (var booking in value.data) {
          bookingIds.add(booking['id']);
          dateBooking.add(booking['booking_date']);
          total.add(booking['total_payment'].toString());
          startTime.add(booking['start_time']);
          endTime.add(booking['end_time']);
        }

        // Update state after extracting all data
        setState(() {
          code = 200;
        });

        // Debug log to verify data
        print("Booking IDs: $bookingIds");
        print("Dates: $dateBooking");
        print("Total Payments: $total");
        print("Start Times: $startTime");
        print("End Times: $endTime");
      } else {
        showToast(context: context, msg: value.message);
      }
    });
  }




  void postCheckout() {
    setState(() => isLoading = true);
    // debugPrint("ids $bookingIds");
    CheckoutViewmodel().checkout(bookingId: bookingIds).then((value) {
      if (value.code == 200) {
        debugPrint("payment_url nya : ${value.data['payment_url']}");
        // Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentWebviewPage(url: value.data['payment_url']),));
        _launchUrl(url: value.data['payment_url']);
      } else {
        showToast(context: context, msg: value.message);
      }
      setState(() => isLoading = false);
    });
  }

  Future<void> _launchUrl({String? url}) async {
    if (!await launchUrl(Uri.parse(url ?? ""))) {
      throw Exception('Could not launch $url');
    }
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