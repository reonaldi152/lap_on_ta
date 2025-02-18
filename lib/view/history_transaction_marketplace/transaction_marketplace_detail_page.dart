import 'package:flutter/material.dart';
import 'package:flutter_lapon/config/app_color.dart';
import 'package:flutter_lapon/model/transaction_marketplace/transaction_marketplace.dart';
import 'package:flutter_lapon/viewmodel/transaction_viewmodel.dart';

class TransactionMarketplaceDetailPage extends StatefulWidget {
  final TransactionMarketplace transaction;

  const TransactionMarketplaceDetailPage({super.key, required this.transaction});

  @override
  State<TransactionMarketplaceDetailPage> createState() => _TransactionMarketplaceDetailPageState();
}

class _TransactionMarketplaceDetailPageState extends State<TransactionMarketplaceDetailPage> {
  final List<String> shippingSteps = const [
    "Menunggu konfirmasi",
    "Sedang disiapkan",
    "Sedang dikirim",
    "Sampai tujuan"
  ];

  int getCurrentStep() {
    return shippingSteps.indexOf(_transactionMarketplace?.shipping_status ?? "Menunggu konfirmasi");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetailTransacMark();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Transaksi Marketplace"),
        backgroundColor: AppColor.colorPrimaryGreen,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        "https://laponid.com/storage/${widget.transaction.product?.image}",
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 80,
                          height: 80,
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
                            widget.transaction.product?.nameProduct ?? "Unknown Product",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Transaction ID: ${widget.transaction.transactionId ?? "-"}",
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Total: Rp ${widget.transaction.total ?? "0"}",
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Status Pengiriman",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.black,
              ),
            ),
            const SizedBox(height: 10),
            Stepper(
              currentStep: getCurrentStep(),
              controlsBuilder: (context, details) => const SizedBox(), // Hide next and previous buttons
              steps: shippingSteps.map((status) {
                return Step(
                  title: Text(status),
                  content: const SizedBox(),
                  isActive: shippingSteps.indexOf(status) <= getCurrentStep(),
                  state: shippingSteps.indexOf(status) <= getCurrentStep()
                      ? StepState.complete
                      : StepState.indexed,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  TransactionMarketplace? _transactionMarketplace;

  getDetailTransacMark(){
    TransactionViewmodel().detailTransactionMarketplace(transactionId: widget.transaction.id).then((value) {
      if (value.code == 200){
        setState(() {
          _transactionMarketplace = TransactionMarketplace.fromJson(value.data);
        });
      }
    },);
  }
}
