import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_lapon/config/app_color.dart';
import 'package:flutter_lapon/model/transaction_marketplace/transaction_marketplace.dart';
import 'package:flutter_lapon/view/history_transaction_marketplace/transaction_marketplace_detail_page.dart';
import 'package:flutter_lapon/viewmodel/transaction_viewmodel.dart';

import '../../config/pref.dart';

class HistoryTransactionMarketplacePage extends StatefulWidget {
  const HistoryTransactionMarketplacePage({super.key});

  @override
  State<HistoryTransactionMarketplacePage> createState() =>
      _HistoryTransactionMarketplacePageState();
}

class _HistoryTransactionMarketplacePageState
    extends State<HistoryTransactionMarketplacePage> {
  List<TransactionMarketplace> _transactions = [];

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  void _fetchTransactions() async {
    String? token = await Session().getUserToken();

    if (token != null) {
      TransactionViewmodel()
          .transactionMarketplace()
          .then((response) {
        if (response.code == 200) {
          setState(() {
            _transactions = (response.data as List)
                .map((e) => TransactionMarketplace.fromJson(e))
                .toList();
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorPrimaryGreen,
      appBar: AppBar(
        backgroundColor: AppColor.colorPrimaryGreen,
        title: const Text(
          "Riwayat Transaksi Marketplace",
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
            const SizedBox(height: 24),
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
                  return _buildTransactionCard(transaction);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionCard(TransactionMarketplace transaction) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionMarketplaceDetailPage(transaction: transaction),));
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "https://laponid.com/storage/${transaction.product?.image}",
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
                      transaction.product?.nameProduct ?? "Unknown Product",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Transaction ID: ${transaction.transactionId ?? "-"}",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Total: Rp ${transaction.total ?? "0"}",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Text(
                transaction.status.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: transaction.status == "success"
                      ? Colors.green
                      : transaction.status == "failed"
                      ? Colors.red
                      : Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
