import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../route/app_pages.dart';
import '../../../constants/app_colors.dart';
import '../../../common_wigdets/common_button.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final List<Map<String, dynamic>> invoices = [
      {
        'installment': 'Installment - 1',
        'paidUnpaid': '6000',
        'status': 'paid',
        'method': 'Online Payment',
        'subcategory': 'SSL',
        'paidDate': '2025-04-16',
        'dueDate': '',
      },
      {
        'installment': 'Installment - 2',
        'paidUnpaid': '6000',
        'status': 'unpaid',
        'method': 'Bank',
        'subcategory': 'EBL',
        'paidDate': '',
        'dueDate': '2025-05-31',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment History',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Colors.white),
        ),
        backgroundColor: AppColors.allPrimaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          itemCount: invoices.length,
          itemBuilder: (context, index) {
            final invoice = invoices[index];
            final isPaid = invoice['status'].toString().toLowerCase() == 'paid';

            return Container(
              margin: EdgeInsets.only(bottom: 20.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.r),
                              decoration: BoxDecoration(
                                color: AppColors.allPrimaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.receipt_long_rounded, color: AppColors.allPrimaryColor, size: 20.r),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              invoice['installment'],
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp, color: Colors.black87),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: isPaid ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            isPaid ? 'Paid' : 'Unpaid',
                            style: TextStyle(
                              color: isPaid ? Colors.green : Colors.red,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Divider(color: Colors.grey.shade100, height: 1),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPaymentDetail('Amount', '${invoice['paidUnpaid']} BDT'),
                        _buildPaymentDetail('Method', invoice['method']),
                        _buildPaymentDetail('Subcategory', invoice['subcategory']),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPaymentDetail('Paid Date', invoice['paidDate'].isEmpty ? 'N/A' : invoice['paidDate']),
                        _buildPaymentDetail('Due Date', invoice['dueDate'].isEmpty ? 'N/A' : invoice['dueDate']),
                        _buildPaymentDetail('', ''), // placeholder for alignment
                      ],
                    ),
                    if (!isPaid) ...[
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: double.infinity,
                        child: CommonButton(
                          height: 44.h,
                          text: 'Pay Now',
                          borderRadius: 12.r,
                          onPressed: () {
                            Get.toNamed(Routes.STRIPE_PAYMENT);
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPaymentDetail(String label, String value) {
    if (label.isEmpty) return Expanded(child: SizedBox.shrink());
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade500, fontSize: 11.sp, fontWeight: FontWeight.w500)),
          SizedBox(height: 4.h),
          Text(value, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp, color: Colors.black87)),
        ],
      ),
    );
  }
}
