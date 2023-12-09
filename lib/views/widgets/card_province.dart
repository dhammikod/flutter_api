part of 'widgets.dart';

class Card_Province extends StatefulWidget {
  final CostResult costresult;
  const Card_Province(this.costresult);

  @override
  State<Card_Province> createState() => _Card_ProvinceState();
}

class _Card_ProvinceState extends State<Card_Province> {
  @override
  Widget build(BuildContext context) {
    CostResult costresult = widget.costresult;

    return Column(
      children: costresult.costs?.map((cost) {
            // Assuming there is only one CostInfo for each Cost
            CostInfo? costInfo =
                cost.cost?.isNotEmpty == true ? cost.cost![0] : null;
            return Card(
              color: Colors.white, // Set the card color to white
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              elevation: 2,
              child: ListTile(
                contentPadding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                leading: Icon(
                  Icons
                      .business, // Use any Flutter default icon, e.g., Icons.business
                  size: 40, // Adjust the size as needed
                  color: Colors.blue, // Adjust the color as needed
                ),
                title: Text("${cost.description} (${cost.service})"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Biaya: ${costInfo?.value}"),
                    Text(
                      "Estimasi sampai: ${costInfo?.etd}",
                      style: TextStyle(
                        color: Colors.green, // Set the text color to green
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList() ??
          [],
    );
  }
}
