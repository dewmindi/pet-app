import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChannelVet extends StatefulWidget {
  const ChannelVet({super.key});

  @override
  State<ChannelVet> createState() => _ChannelVetState();
}

class _ChannelVetState extends State<ChannelVet> {
  final Map<String, bool> _isHovered = {};
  final Map<String, bool> _isClicked = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Column(
        children: [
          Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
          ),
          Row(
            children: [
              _cardMenu(
                key: ValueKey('ADOPT'),
                title: 'ADOPT',
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const PetAdopt(),
                //     ),
                //   );
                // },
                icon: 'assets/images/adopt.png',
                color: Colors.indigoAccent,
                fontColor: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _cardMenu({
    required ValueKey<String> key,
    required String title,
    required String icon,
    VoidCallback? onTap,
    Color color = Colors.white,
    Color fontColor = Colors.grey,
    double iconHeight = 50,
    double iconWidth = 50,
  }) {
    return MouseRegion(
      onEnter: (_) => _onHover(key.value, true),
      onExit: (_) => _onHover(key.value, false),
      child: GestureDetector(
        onTapDown: (_) => _onClick(key.value, true),
        onTapUp: (_) {
          _onClick(key.value, false);
          if (onTap != null) onTap();
        },
        onTapCancel: () => _onClick(key.value, false),
        child: Container(
          width: 150,
          padding: EdgeInsets.symmetric(vertical: 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: _isClicked[key.value] == true
                ? Colors.blueGrey
                : (_isHovered[key.value] == true ? Colors.blueGrey : color),
          ),
          child: Column(
            children: [
              Image.asset(
                icon,
                height: iconHeight,
                width: iconWidth,
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: fontColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _onHover(String key, bool isHovered) {
    setState(() {
      _isHovered[key] = isHovered;
    });
  }

  void _onClick(String key, bool isClicked) {
    setState(() {
      _isClicked[key] = isClicked;
    });
  }
}
