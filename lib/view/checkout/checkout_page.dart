

import 'package:flutter/material.dart';
import 'package:flutter_lapon/viewmodel/booking_viewmodel.dart';
import 'package:flutter_lapon/widget/custom_toast.dart';

import '../../config/app_color.dart';
import '../../model/venue/venue.dart';
import '../../viewmodel/venue_viewmodel.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key, this.venueId, this.categoryId, this.bookingDate, this.startTime, this.endTime, this.totalPayment});
  final dynamic venueId;
  final dynamic categoryId;
  final dynamic bookingDate;
  final dynamic startTime;
  final dynamic endTime;
  final dynamic totalPayment;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    getBooking();
    getDetailVenue();
    super.initState();
  }

  dynamic code;

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
      body: code != 201 ? Center(child: CircularProgressIndicator(),) : Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(top: 12),
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
                    IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: AppColor.colorPrimaryGreen,),),
                  ],
                ),
                Text(
                  dateBooking,
                  style: fontTextStyle.copyWith(
                    color: Color(0xFF6F737A),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColor.colorPrimaryGreen.withOpacity(0.5), // Warna background baris hijau muda
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                "${startTime} - ${endTime}",
                                style: fontTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Text(
                                'Rp 70.000',
                                style: fontTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4B6975), // Warna harga sesuai gambar
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                Text(
                  'Checkout Review',
                  style: fontTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: AppColor.colorPrimaryGreen, // Warna hijau teks header
                  ),
                ),
                SizedBox(height: 16),
                _buildRow('Biaya Sewa', total),
                SizedBox(height: 8),
                _buildRow('Admin', '', isLink: true),
                SizedBox(height: 8),
                _buildRow('PPN (10%)', ''),
                Divider(thickness: 1, color: Colors.grey[300]),
                SizedBox(height: 8),
                _buildRow('Total', total, isBold: true),
                Divider(thickness: 1, color: Colors.grey[300]),
                SizedBox(height: 8),

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
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
              color: AppColor.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff94A8BE).withOpacity(0.3),
                  spreadRadius: 0.4,
                  blurRadius: 6,
                  offset: const Offset(
                      0.5, 0), // changes position of shadow
                )
              ],
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total : 1 Sesi terpilih",
                    style: fontTextStyle.copyWith(
                      color: const Color(0xFF121212),
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    total,
                    style: fontTextStyle.copyWith(
                        color: const Color(0xFF121212),
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage(),));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 11, horizontal: 16),
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppColor.colorPrimaryGreen,
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
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
              color: Color(0xFF4B6975), // Warna link biru
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
            color: Color(0xFF4B6975), // Warna teks angka
          ),
        ),
      ],
    );
  }

  String dateBooking = "", total = "", startTime = "", endTime = "";

  getBooking(){
    BookingViewmodel().booking(categoryId: widget.categoryId, bookingDate: widget.bookingDate, endTime: widget.endTime, startTime: widget.startTime, taxPercentage: "1000", totalPayment: widget.totalPayment, venueId: widget.venueId).then((value) {
      if (value.code == 201){
        setState(() {
          code = value.code;
          dateBooking = value.data['booking_date'];
          total = value.data['total_payment'];
          startTime = value.data['start_time'];
          endTime = value.data['end_time'];
        });
      } else {
        showToast(context: context, msg: value.message);
      }
    },);
  }

  Venue? _venue;
  getDetailVenue() {
    VenueViewmodel().detailVenue(venueid: widget.venueId).then((value) {
      if (value.code == 200) {
        setState(() {
          _venue = Venue.fromJson(value.data);
        });
      }
    });
  }
}



