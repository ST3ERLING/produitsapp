import 'package:flutter/material.dart';
import 'produit_box.dart';
import 'add_produit.dart';

class ProduitsList extends StatefulWidget {
  @override
  _ProduitsListState createState() => _ProduitsListState();
}

class _ProduitsListState extends State<ProduitsList> {
  List<String> produits = ['Produit 1', 'Produit 2', 'Produit 3'];
  Set<String> selectedProduits = Set();

  Future<void> _addProduit() async {
    final String? newProduit = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AddProduit();
      },
    );

    if (newProduit != null && newProduit.isNotEmpty) {
      setState(() {
        produits.add(newProduit);
      });
    }
  }

  void _deleteProduit(String produit) {
    setState(() {
      produits.remove(produit);
    });
  }

  void _deleteSelectedProduits() {
    setState(() {
      produits.removeWhere((produit) => selectedProduits.contains(produit));
      selectedProduits.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Produits'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addProduit,
          ),
          if (selectedProduits.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: _deleteSelectedProduits,
            ),
        ],
      ),
      body: ListView.builder(
        itemCount: produits.length,
        itemBuilder: (context, index) {
          return ProduitBox(
            nomProduit: produits[index],
            selProduit: selectedProduits.contains(produits[index]),
            onChanged: (bool? isSelected) {
              setState(() {
                if (isSelected == true) {
                  selectedProduits.add(produits[index]);
                } else {
                  selectedProduits.remove(produits[index]);
                }
              });
            },
            onDelete: () => _deleteProduit(produits[index]),
          );
        },
      ),
    );
  }
}
