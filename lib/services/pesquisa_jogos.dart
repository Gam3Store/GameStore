import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PesquisaJogos extends StatefulWidget {
  @override
  _PesquisaJogosState createState() => _PesquisaJogosState();
}

class _PesquisaJogosState extends State<PesquisaJogos> {
  TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _resultados = [];

  void _pesquisarJogos(String termo) async {
    if (termo.isEmpty) {
      setState(() => _resultados = []);
      return;
    }

    String termoLower = termo.toLowerCase();

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('jogos')
        .where('nome_lower', isGreaterThanOrEqualTo: termoLower)
        .where('nome_lower', isLessThanOrEqualTo: termoLower + '\uf8ff')
        .get();

    setState(() {
      _resultados = querySnapshot.docs
          .map((doc) => {"id": doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pesquisar Jogos")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Digite o nome do jogo...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: _pesquisarJogos,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _resultados.length,
              itemBuilder: (context, index) {
                var jogo = _resultados[index];
                return ListTile(
                  leading: Image.network(jogo['imagem'], width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(jogo['nome']),
                  subtitle: Text("R\$${jogo['preco']}"),
                  onTap: () {
                    Navigator.pushNamed(context, '/detalhes_jogo', arguments: jogo);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
