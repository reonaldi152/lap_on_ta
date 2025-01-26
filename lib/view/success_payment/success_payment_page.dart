import 'package:flutter/material.dart';

import '../../config/app_color.dart';
import '../base_page.dart';

class SuccessPaymentPage extends StatelessWidget {
  const SuccessPaymentPage({super.key, this.status});
  final dynamic status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/ic_not_tagihan.png", width: 196),
              const SizedBox(height: 24),
              Text(
                status == "settlement" || status == "capture"
                    ? "Pembayaran Berhasil"
                    : status == "pending"
                    ? "Sedang Menunggu Pembayaran"
                    : "Pembayaran gagal",
                style: fontTextStyle.copyWith(
                  fontSize: 18,
                  color: AppColor.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "Untuk melihat transaksi, mohon ke halaman riwayat transaksi",
                style: fontTextStyle.copyWith(color: AppColor.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: AppColor.black,
                    borderRadius: BorderRadius.circular(6)),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const BasePage()),
                            (Route<dynamic> route) => false);
                  },
                  child: Text("Ke Beranda",
                      style: fontTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColor.white,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
