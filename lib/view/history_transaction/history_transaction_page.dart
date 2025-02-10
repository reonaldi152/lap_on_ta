import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_lapon/config/app_color.dart';
import 'package:flutter_lapon/model/transaction/transaction.dart';
import 'package:flutter_lapon/viewmodel/refund_viewmodel.dart';
import 'package:flutter_lapon/viewmodel/transaction_viewmodel.dart';
import 'package:flutter_lapon/widget/custom_toast.dart';

import '../../config/pref.dart';

class HistoryTransactionPage extends StatefulWidget {
  const HistoryTransactionPage({super.key});

  @override
  State<HistoryTransactionPage> createState() => _HistoryTransactionPageState();
}

class _HistoryTransactionPageState extends State<HistoryTransactionPage> {
  String _selectedStatus = "pending";
  List<Transaction> _transactions = [];

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  void _fetchTransactions() async {
    String? token = await Session().getUserToken();

    if (token != null) {
      TransactionViewmodel()
          .transactionVenue(status: _selectedStatus)
          .then((response) {
        if (response.code == 200) {
          setState(() {
            _transactions = (response.data as List)
                .map((e) => Transaction.fromJson(e))
                .toList();
          });
        }
      });
    }
  }

  void _handleRefund(BuildContext context, String bookingId) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            "Konfirmasi Refund",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Pembatalan yang terjadi akan dikenakan biaya potongan transaksi venue sebesar 20%. Apakah Anda yakin ingin melanjutkan?",
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text(
                "Batal",
                style: TextStyle(color: Colors.red),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                RefundViewmodel().refund(bookingId: bookingId).then((value) {
                  if (value.code == 201) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: const Text("Refund berhasil diajukan."),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.of(context).pop(); // Tutup dialog

                    }
                    _fetchTransactions(); // Refresh transaksi
                  } else {
                    if (mounted) {
                      showToast(context: context, msg: value.message);

                    }
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.colorPrimaryGreen,
              ),
              child: const Text(
                "Konfirmasi",
                style: TextStyle(color: AppColor.white),
              ),
            ),


          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorPrimaryGreen,
      appBar: AppBar(
        backgroundColor: AppColor.colorPrimaryGreen,
        title: const Text(
          "Riwayat Transaksi",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: _transactions.isEmpty
                  ? const Center(
                child: Text(
                  "No Transactions Found",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final transaction = _transactions[index];
                  return _buildTransactionCard(context, transaction);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionCard(BuildContext context, Transaction transaction) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "https://laponid.com/storage/${transaction.venue?.image}",
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 50,
                  height: 50,
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
                    transaction.venue?.name ?? "Unknown Venue",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Booking ID: ${transaction.booking?.bookingId ?? "-"}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${transaction.booking?.bookingDate} ${transaction.booking?.startTime} - ${transaction.booking?.endTime}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  transaction.total != null
                      ? "Rp ${transaction.total}"
                      : "Rp 0",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColor.colorPrimaryGreen,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    _handleRefund(context, transaction.booking?.id.toString() ?? "");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 12),
                  ),
                  child: const Text(
                    "Refund",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
