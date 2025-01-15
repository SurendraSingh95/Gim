import 'package:flutter/material.dart';

class BottomDialog {
  void showBottomDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: _buildDialogContent(),
        );
      },
      transitionBuilder: (_, animation1, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation1),
          child: child,
        );
      },
    );
  }

  Widget _buildDialogContent() {
    return IntrinsicHeight(
      child: Container(
        width: double.maxFinite,
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Material(
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildImage(),
              const SizedBox(height: 8),
              _buildContinueText(),
              const SizedBox(height: 16),
              _buildEmapleText(),
              const SizedBox(height: 16),
              _buildTextField(),
              const SizedBox(height: 16),
              _buildContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    const image =
        'https://user-images.githubusercontent.com/47568606/134579553-da578a80-b842-4ab9-ab0b-41f945fbc2a7.png';
    return SizedBox(
      height: 88,
      child: Image.network(image, fit: BoxFit.cover),
    );
  }

  Widget _buildContinueText() {
    return const Text(
      'Continue with account',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildEmapleText() {
    return const Text(
      'example.com',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTextField() {
    const iconSize = 40.0;
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.grey.withOpacity(0.4)),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        children: [
          Container(
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            child: const Center(
              child: Text('Е'),
            ),
          ),
          const SizedBox(height: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'elisa.g.beckett@gmail.com',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text('**********'),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      height: 40,
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: Color(0xFF3375e0),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: RawMaterialButton(
        onPressed: () {
          // Navigator.of(context, rootNavigator: true).pop();
        },
        child: const Center(
          child: Text(
            'Continue',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

}