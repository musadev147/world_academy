import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/app_colors.dart';

class AdminInvoicesScreen extends StatelessWidget {
  const AdminInvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final List<Map<String, dynamic>> invoices = [
      {'id': 'INV-1001', 'student': 'John Doe', 'amount': '\$500.00', 'status': 'Unpaid'},
      {'id': 'INV-1002', 'student': 'Jane Smith', 'amount': '\$750.00', 'status': 'Paid'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices'),
        backgroundColor: AppColors.allPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search by Student Name or Invoice ID...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                      ),
                      value: 'All Status',
                      items: ['All Status', 'Paid', 'Unpaid'].map((String value) {
                        return DropdownMenuItem<String>(value: value, child: Text(value, style: TextStyle(fontSize: 12.sp)));
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                      ),
                      value: 'All Programs',
                      items: ['All Programs', 'SCM', 'HR'].map((String value) {
                        return DropdownMenuItem<String>(value: value, child: Text(value, style: TextStyle(fontSize: 12.sp)));
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
                itemCount: invoices.length,
                itemBuilder: (context, index) {
                  final invoice = invoices[index];
                  final isPaid = invoice['status'] == 'Paid';

                  return Card(
                    margin: EdgeInsets.only(bottom: 12.h),
                    child: ListTile(
                      title: Text('Invoice: ${invoice['id']}', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Student: ${invoice['student']}'),
                          Text('Amount: ${invoice['amount']}', style: TextStyle(color: AppColors.allPrimaryColor, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      trailing: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: isPaid ? Colors.green.shade100 : Colors.red.shade100,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          invoice['status'],
                          style: TextStyle(color: isPaid ? Colors.green : Colors.red, fontSize: 12.sp),
                        ),
                      ),
                      onTap: () {
                        _showPaymentDetailsModal(context, invoice);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentDetailsModal(BuildContext context, Map<String, dynamic> invoice) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2.r)),
                ),
              ),
              SizedBox(height: 24.h),
              Text('Payment Status Details', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 24.h),
              _buildDetailRow('Invoice ID', invoice['id']),
              _buildDetailRow('Student Name', invoice['student']),
              _buildDetailRow('Total Amount', invoice['amount']),
              _buildDetailRow('Amount Due', invoice['status'] == 'Paid' ? '\$0.00' : invoice['amount']),
              _buildDetailRow('Last Payment Date', invoice['status'] == 'Paid' ? '2026-08-15' : 'N/A'),
              _buildDetailRow('Payment Method', invoice['status'] == 'Paid' ? 'Stripe (Credit Card)' : 'N/A'),
              SizedBox(height: 32.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.allPrimaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  child: Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
        ],
      ),
    );
  }
}
