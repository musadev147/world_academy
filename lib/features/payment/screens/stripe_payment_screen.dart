import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../common_wigdets/common_button.dart';
import '../../../common_wigdets/custom_textfiled.dart';

class StripePaymentScreen extends StatefulWidget {
  const StripePaymentScreen({super.key});

  @override
  State<StripePaymentScreen> createState() => _StripePaymentScreenState();
}

class _StripePaymentScreenState extends State<StripePaymentScreen> {
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvcController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvcController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Colors.white),
        ),
        backgroundColor: AppColors.allPrimaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.allPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.allPrimaryColor.withOpacity(0.1)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: AppColors.allPrimaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.security_rounded, color: AppColors.allPrimaryColor, size: 24.r),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Text(
                        'Payments are securely processed by Stripe.',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.allPrimaryColor,
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 10)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Details',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    CustomTextFormField(
                      controller: _nameController,
                      labelText: 'Cardholder Name',
                      hintText: 'Name on card',
                    ),
                    SizedBox(height: 16.h),
                    CustomTextFormField(
                      controller: _cardNumberController,
                      labelText: 'Card Number',
                      hintText: '0000 0000 0000 0000',
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            controller: _expiryController,
                            labelText: 'Expiry Date',
                            hintText: 'MM/YY',
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: CustomTextFormField(
                            controller: _cvcController,
                            labelText: 'CVC',
                            hintText: '123',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: Colors.grey.shade100),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Amount',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
                    ),
                    Text(
                      '\$49.99',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.allPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              SizedBox(
                width: double.infinity,
                child: CommonButton(
                  height: 48.h,
                  text: 'Pay \$49.99',
                  borderRadius: 16.r,
                  onPressed: () {
                    Get.back();
                    Get.snackbar(
                      'Payment Successful',
                      'Your payment has been processed successfully.',
                      backgroundColor: Colors.green.shade600,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      margin: EdgeInsets.all(16.w),
                      borderRadius: 16.r,
                      icon: Icon(Icons.check_circle_rounded, color: Colors.white),
                    );
                  },
                ),
              ),
              SizedBox(height: 24.h),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_rounded, size: 14.r, color: Colors.grey.shade400),
                    SizedBox(width: 6.w),
                    Text(
                      'Powered by Stripe',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w600,
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
  }
}
