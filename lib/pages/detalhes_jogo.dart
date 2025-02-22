import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetalhesJogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String jogoId = ModalRoute.of(context)!.settings.arguments as String;

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('jogos').doc(jogoId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        var jogo = snapshot.data!.data() as Map<String, dynamic>;

        return Scaffold(
          appBar: AppBar(title: Text(jogo['nome'])),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.network(jogo['imagem'], height: 200)),
                SizedBox(height: 10),
                Text(jogo['nome'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text(jogo['descricao'], style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Text("Preço: R\$${jogo['preco']}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        );
      },
    );
  }
}
