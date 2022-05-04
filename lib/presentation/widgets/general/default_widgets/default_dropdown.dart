import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';

class DefaultDropdown extends StatefulWidget {
  final DefaultMenuItem value;
  final List<DefaultMenuItem> items;
  final void Function(DefaultMenuItem?)? onChanged;
  final Color? color;

  const DefaultDropdown(
      {required this.value,
      required this.items,
      required this.onChanged,
      this.color,
      Key? key})
      : super(key: key);

  @override
  State<DefaultDropdown> createState() => _DefaultDropdownState();
}

class _DefaultDropdownState extends State<DefaultDropdown> {
  late ThemeProvider _themeProvider;

  @override
  Widget build(BuildContext context) {
    _themeProvider = Provider.of<ThemeProvider>(context);

    return PopupMenuButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: const Color(0xFF323346),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: widget.color ?? _themeProvider.themeData().primaryColor,
            ),
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.value.name,
                  style: _themeProvider.themeData().textTheme.headline4!,
                ),
                const SizedBox(width: 10),
                Icon(
                  Iconsax.arrow_down_1,
                  size: 12,
                  color: _themeProvider.themeData().textTheme.headline4!.color,
                ),
              ],
            )),
        offset: const Offset(0, 45),
        onSelected: widget.onChanged,
        itemBuilder: (BuildContext context) => widget.items
                .map<PopupMenuEntry<DefaultMenuItem>>((DefaultMenuItem value) {
              return PopupMenuItem(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  height: 30,
                  value: value,
                  child: Text(value.name,
                      style: _themeProvider
                          .themeData()
                          .textTheme
                          .headline4!
                          .apply(color: Colors.white)));
            }).toList());
  }
}

class DefaultMenuItem {
  final String name;
  final dynamic value;

  const DefaultMenuItem(this.name, this.value);
}
