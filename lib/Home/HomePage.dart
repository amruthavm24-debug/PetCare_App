import 'package:flutter/material.dart';
import 'package:PetCare_App/Facility/models/Facility.dart';
import 'package:PetCare_App/Facility/viewmodels/FacilityViewModel.dart';
import 'package:provider/provider.dart';
import 'package:PetCare_App/Location/viewmodels/LocationViewModel.dart';
import 'package:PetCare_App/Facility/FacilityDetailsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchCtrl = TextEditingController();
  final List<String> categories = ['All', 'Vet', 'Grooming', 'Boarding', 'Training', 'Pet Store'];
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final location = context.watch<LocationViewModel>();
    final facilityVM = context.watch<FacilityViewModel>();
    final facilities = facilityVM.filtered(location.city);

    return SafeArea(
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              children: [
                // const Icon(Icons.pets, size: 28, color: Colors.teal),
                CircleAvatar(child: Image.asset("Asset/pet-care-logo.png")),
                // CircleAvatar(),
                const SizedBox(width: 8),
                const Text('PetCare', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color:  Color.fromARGB(255, 126, 15, 141),)),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const CircleAvatar(child: Icon(Icons.person)))
              ],
            ),
          ),

          // Location Chip
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(children: [
              GestureDetector(
                onTap: () => _showLocationPicker(context),
                child: Chip(label: Row(children: [const Icon(Icons.location_on, size: 16), const SizedBox(width: 6), 
                Text(location.city,style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141)),)])),
              ),
            ]),
          ),

          // Search
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (v) => facilityVM.setQuery(v),
              decoration: const InputDecoration(prefixIcon: Icon(Icons.search, color:  Color.fromARGB(255, 232, 163, 241),), 
              hintText: 'Search facilities or services...', border: OutlineInputBorder(),hintStyle: TextStyle(color: Color.fromARGB(255, 232, 163, 241))),
            ),
          ),

          // Category chips (horizontal)
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: categories.length,
              itemBuilder: (ctx, i) {
                final cat = categories[i];
                final selected = cat == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(cat,style: TextStyle(color: Color.fromARGB(255, 126, 15, 141)),),
                    selected: selected,
                    onSelected: (_) {
                      setState(() => _selectedCategory = cat);
                      facilityVM.setCategoryFilter(cat);
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // Facility grid/list
          Expanded(
            child: facilities.isEmpty
                ? Center(child: Text('No facilities found for ${location.city}'))
                : ListView.builder(
                    itemCount: facilities.length,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemBuilder: (ctx, i) {
                      final f = facilities[i];
                      return Card(
                        color: Color.fromARGB(255, 250, 231, 252),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(children: [
                            Container(width: 84, height: 84, color:  Color.fromARGB(255, 126, 15, 141), child: const Icon(Icons.storefront, size: 48,color: Colors.white,)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Row(children: [Text(f.name, style: const TextStyle(fontWeight: FontWeight.bold,color:  Color.fromARGB(255, 126, 15, 141))), const Spacer(), 
                                Text('★ ${f.rating.toStringAsFixed(1)}',style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141)),)]),
                                const SizedBox(height: 4),
                                Text(f.category,style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141)),),
                                const SizedBox(height: 4),
                                Row(children: [Text('From ₹${f.price}',style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141)),), 
                                const SizedBox(width: 8), Text('${f.distanceKm} km',style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141)),)]),
                                const SizedBox(height: 6),
                                Row(children: [
                                  if (f.openNow) Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), 
                                  decoration: BoxDecoration(color:  Color.fromARGB(255, 126, 15, 141), borderRadius: BorderRadius.circular(12)), 
                                  child: const Text('Open Now',style: TextStyle(color:  Colors.white)),),
                                  const Spacer(),
                                  TextButton(onPressed: () => _openDetails(context, f), child: const Text('View Details',style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141)),))
                                ])
                              ]),
                            )
                          ]),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }

  void _openDetails(BuildContext context, Facility f) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => FacilityDetailsPage(facilityId: f.id)));
  }

  void _showLocationPicker(BuildContext context) {
    showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
  ),
  builder: (context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(20),
          child: Column(children: [
          const SizedBox(height: 8),
          const Text('Select Location', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color:  Color.fromARGB(255, 126, 15, 141))),
          const SizedBox(height: 12),
          ListTile(title: const Text('Hyderabad',style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141)),), onTap: () { Provider.of<LocationViewModel>(context, listen: false).setCity('Hyderabad'); Navigator.pop(context); }),
          ListTile(title: const Text('Bengaluru',style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141)),), onTap: () { Provider.of<LocationViewModel>(context, listen: false).setCity('Bengaluru'); Navigator.pop(context); }),
          ListTile(title: const Text('Pune',style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141)),), onTap: () { Provider.of<LocationViewModel>(context, listen: false).setCity('Pune'); Navigator.pop(context); }),
          ListTile(title: const Text('Use Current Location (mock only)',style: TextStyle(color:  Color.fromARGB(255, 126, 15, 141)),), onTap: () { Provider.of<LocationViewModel>(context, listen: false).setCity('Hyderabad'); Navigator.pop(context); }),
        ]),
          ),
        );
      },
    );
  },
);
  }
}