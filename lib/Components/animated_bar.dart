import "package:flutter/material.dart";

class AnimatedBar extends StatelessWidget {
  // Declare the constructor for the class
  const AnimatedBar({
    Key? key, // Use the optional Key parameter
    required this.isActive, // Use the required named parameter
  });

  final bool isActive; // Declare the isActive variable as a final bool

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
          milliseconds: 400), // Set the duration of the animation
      margin: EdgeInsets.only(bottom: 2), // Set the margin of the container
      height: 4, // Set the height of the container
      width: isActive
          ? 20
          : 0, // Set the width of the container based on the isActive variable
      decoration: BoxDecoration(
        color: Color(0xFF81B4FF), // Set the color of the container
        borderRadius: BorderRadius.all(
          Radius.circular(12), // Set the border radius of the container
        ),
      ),
    );
  }
}
