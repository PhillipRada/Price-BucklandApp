import 'package:practise1/Components/Login_Form.dart';
import 'package:practise1/Screens/chat_bot.dart';
import 'package:practise1/Screens/profile_screen.dart';
import 'package:rive/rive.dart';

import '../Screens/favourites_screen.dart';
import '../Screens/settings_screen.dart';

class RiveAsset {
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;

  var page;

  RiveAsset(
    this.src, {
    required this.artboard,
    required this.stateMachineName,
    required this.title,
    this.input,
    this.page,
  });

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> bottomNavs = [
  RiveAsset(
    "assets/RiveAssets/icons .riv",
    artboard: "HOME",
    stateMachineName: "HOME_Interactivity",
    title: "Home",
    page: HomePage(),
  ),
  RiveAsset(
    "assets/RiveAssets/icons .riv",
    artboard: "CHAT",
    stateMachineName: "CHAT_Interactivity",
    title: "Chat",
    page: ChatbotPage(),
  ),
  RiveAsset(
    "assets/RiveAssets/icons .riv",
    artboard: "USER",
    stateMachineName: "USER_Interactivity",
    title: "Profile",
    page: ProfileScreen(),
  ),
  RiveAsset(
    "assets/RiveAssets/icons .riv",
    artboard: "LIKE/STAR",
    stateMachineName: "STAR_Interactivity",
    title: "Favorites",
    page: favouritescreen(),
  ),
  RiveAsset(
    "assets/RiveAssets/icons .riv",
    artboard: "SETTINGS",
    stateMachineName: "SETTINGS_Interactivity",
    title: "Settings",
    page: SettingsScreen(),
  ),
];
