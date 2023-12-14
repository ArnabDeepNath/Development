import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

class SelectiveColor extends StatefulWidget {
  const SelectiveColor({Key? key}) : super(key: key);

  @override
  State<SelectiveColor> createState() => _SelectiveColorState();
}

class _SelectiveColorState extends State<SelectiveColor> {
  Future<Uint8List?> _applySelectiveColor(String imageUrl) async {
    try {
      // Fetch image from the network
      var response = await http.get(Uri.parse(imageUrl));
      img.Image image = img.decodeImage(response.bodyBytes)!;

      // Define the custom color
      int customColor = img.getColor(177, 155, 100); // #B19B64

      // Apply selective color transformation
      for (int y = 0; y < image.height; y++) {
        for (int x = 0; x < image.width; x++) {
          int red = img.getRed(image.getPixel(x, y));
          int green = img.getGreen(image.getPixel(x, y));
          int blue = img.getBlue(image.getPixel(x, y));

          // Adjust this threshold to control sensitivity to the custom color
          int colorThreshold = 50;

          // Calculate the Euclidean distance to the custom color
          double distance = colorDistance(
            customColor,
            img.getColor(red, green, blue),
          );

          // Desaturate non-custom color pixels
          if (distance > colorThreshold) {
            int avg = ((red + green + blue) ~/ 3).clamp(0, 255);
            image.setPixel(x, y, img.getColor(avg, avg, avg));
          }
        }
      }

      // Encode the modified image back to Uint8List
      Uint8List desaturatedImageBytes =
          Uint8List.fromList(img.encodePng(image));

      return desaturatedImageBytes;
    } catch (e) {
      print('Error applying selective color: $e');
      return null;
    }
  }

  // Function to calculate the Euclidean distance between two colors
  double colorDistance(int color1, int color2) {
    int r1 = (color1 >> 16) & 0xFF;
    int g1 = (color1 >> 8) & 0xFF;
    int b1 = color1 & 0xFF;

    int r2 = (color2 >> 16) & 0xFF;
    int g2 = (color2 >> 8) & 0xFF;
    int b2 = color2 & 0xFF;

    return ((r1 - r2).abs() + (g1 - g2).abs() + (b1 - b2).abs()).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        'https://images.unsplash.com/photo-1592931723381-9f9b75d3953b?q=80&w=1332&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'; // Replace with your image URL

    return Scaffold(
      body: Center(
        child: FutureBuilder<Uint8List?>(
          future: _applySelectiveColor(imageUrl),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError || snapshot.data == null) {
                return Text('Error applying selective color');
              } else {
                return ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Color.fromARGB(
                        200, 177, 155, 100), // Adjust the color as needed
                    BlendMode.softLight,
                  ),
                  child: Image.memory(snapshot.data!),
                );
              }
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
