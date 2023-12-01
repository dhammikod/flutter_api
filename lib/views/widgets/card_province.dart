part of 'widgets.dart';

class Card_Province extends StatefulWidget {
  final Province prov;
  const Card_Province(this.prov);

  @override
  State<Card_Province> createState() => _Card_ProvinceState();
}

class _Card_ProvinceState extends State<Card_Province> {
  @override
  Widget build(BuildContext context) {
    Province prov = widget.prov;
    return Card(
      color: Color(0xFFFFFF),
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        title: Text(prov.province.toString()),
        subtitle: Text(prov.province.toString()),
      ),
    );
  }
}
