import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lapon/config/app_color.dart';
import 'package:flutter_lapon/model/schedule/data_schedule.dart';
import 'package:flutter_lapon/model/schedule/schedule.dart';
import 'package:flutter_lapon/view/checkout/checkout_page.dart';
import 'package:flutter_lapon/viewmodel/venue_viewmodel.dart';

import '../../model/venue/field.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key, this.venueId, this.field});
  final dynamic venueId;
  final Field? field;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime _dateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day); // Inisialisasi dengan tanggal saat ini tanpa waktu
  ScheduleModel? _scheduleModel;
  List<DataSchedule> selectedSchedules = [];
  double totalPrice = 0.0;
  bool isSelected = false;

  @override
  void initState() {
    getScheduleVenue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorPrimaryGreen,
      appBar: AppBar(
        backgroundColor: AppColor.colorPrimaryGreen,
        title: Text(
          "Cek Jadwal",
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
      body: _scheduleModel == null ? const Center(child: CircularProgressIndicator(),) : Container(
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.only(top: 12),
        decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              EasyDateTimeLine(
                initialDate: DateTime.now(),
                onDateChange: (selectedDate) {
                  setState(() {
                    _dateTime = selectedDate;
                    getScheduleVenue();
                  });
                },
                activeColor: AppColor.colorPrimaryGreen,
                dayProps: const EasyDayProps(
                  todayHighlightStyle: TodayHighlightStyle.withBackground,
                  todayHighlightColor: Color(0xffE1ECC8),
                ),
              ),
              const SizedBox(height: 26),
              ExpansionTile(
                title: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          "https://laponid.com/storage/${_scheduleModel?.venue?.image}",
                          width: 70,
                          errorBuilder: (context, error, stackTrace) => Image.network(
                            "https://picsum.photos/300/300",
                            width: 70,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _scheduleModel?.venue?.name ?? "",
                              style: fontTextStyle.copyWith(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                              maxLines: 3, // Batasi hanya 1 baris
                            ),
                            Text(
                              "${_scheduleModel?.availableSchedulesCount ?? 0} Jadwal Tersedia",
                              style: fontTextStyle.copyWith(
                                  color: AppColor.colorPrimaryGreen,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                children: List.generate(
                  _scheduleModel!.schedules!.length,
                      (index) {
                    DataSchedule data = _scheduleModel!.schedules![index];
                    bool isDisabled = data.is_past ?? false; // Cek apakah jadwal sudah lewat
                    bool isSelected = selectedSchedules.contains(data);

                    return GestureDetector(
                      onTap: isDisabled || data.is_booked
                          ? null
                          : () {
                        setState(() {
                          if (isSelected) {
                            selectedSchedules.remove(data);
                          } else {
                            selectedSchedules.add(data);
                          }
                          totalPrice = selectedSchedules.length *
                              double.parse(widget.field?.price ?? "0");
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: isDisabled || data.is_booked
                              ? Colors.grey[300]
                              : isSelected
                              ? AppColor.colorPrimaryGreen
                              : AppColor.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xff94A8BE).withOpacity(0.3),
                              spreadRadius: 0.1,
                              blurRadius: 4,
                              offset: const Offset(0.5, 0),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "60 Menit",
                                  style: fontTextStyle.copyWith(
                                    fontSize: 10,
                                    color: isDisabled
                                        ? Colors.grey
                                        : const Color(0xFF6F737A),
                                  ),
                                ),
                                Text(
                                  "${data.start_time} - ${data.end_time}",
                                  style: fontTextStyle.copyWith(
                                    color: isDisabled ? Colors.grey : AppColor.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "${_scheduleModel?.venue?.price}",
                                  style: fontTextStyle.copyWith(
                                    color: isDisabled ? Colors.grey : AppColor.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  isDisabled || data.is_booked
                                      ? Icons.cancel
                                      : isSelected
                                      ? Icons.check_circle
                                      : Icons.circle_outlined,
                                  color: isDisabled
                                      ? Colors.grey
                                      : isSelected
                                      ? AppColor.white
                                      : AppColor.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 36),
            ],
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
                      0.5, 0),
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
                    "Total : ${selectedSchedules.length} Sesi terpilih",
                    style: fontTextStyle.copyWith(
                      color: const Color(0xFF121212),
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "Rp $totalPrice",
                    style: fontTextStyle.copyWith(
                        color: const Color(0xFF121212),
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  // Periksa jika ada jadwal yang dipilih
                  if (selectedSchedules.isNotEmpty && widget.field != null && widget.venueId != null) {
                    // Ubah semua jadwal terpilih menjadi format time slot sesuai kebutuhan API
                    List<Map<String, dynamic>> timeSlots = selectedSchedules.map((schedule) {
                      return {
                        "start_time": schedule.start_time.substring(0, 5),
                        "end_time": schedule.end_time.substring(0, 5),
                      };
                    }).toList();

                    // Pindah ke halaman Checkout dengan daftar waktu booking
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutPage(
                          field: widget.field,
                          venueId: widget.venueId,
                          bookingDate:
                          "${_dateTime.year.toString().padLeft(4, '0')}-${_dateTime.month.toString().padLeft(2, '0')}-${_dateTime.day.toString().padLeft(2, '0')}",
                          timeSlots: timeSlots,
                          totalPayment: totalPrice,
                          categoryId: _scheduleModel?.venue?.categoryId,
                        ),
                      ),
                    );
                  } else {
                    // Tampilkan pesan error jika belum memilih jadwal
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Pilih setidaknya satu slot jadwal!")),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColor.colorPrimaryGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
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

  void getScheduleVenue() {
    String formattedDate = "${_dateTime.year.toString().padLeft(4, '0')}-${_dateTime.month.toString().padLeft(2, '0')}-${_dateTime.day.toString().padLeft(2, '0')}";
    VenueViewmodel()
        .scheduleVenue(venueID: widget.venueId, date: formattedDate)
        .then(
          (value) {
        if (value.code == 200) {
          setState(() {
            _scheduleModel = ScheduleModel.fromJson(value.data);
          });
        }
      },
    );
  }


}


