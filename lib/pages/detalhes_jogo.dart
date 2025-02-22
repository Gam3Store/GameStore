import 'package:flutter/material.dart';
import 'package:gamestore/services/pesquisa_jogos.dart';
import 'package:provider/provider.dart';
import 'package:gamestore/services/carrinho_provider.dart';

class DetalhesJogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final jogo = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final carrinho = Provider.of<CarrinhoProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(jogo['nome']),
                actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PesquisaJogos()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, size: 30),
            onPressed: () {
              // Adicione uma ação aqui, como abrir uma tela de perfil
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/carrinho');
            },
          ),
          ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(jogo['imagem'], height: 200),
            ),
            SizedBox(height: 10),
            Text(
              jogo['nome'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'R\$ ${jogo['preco']?.toStringAsFixed(2) ?? "0.00"}',
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
                ElevatedButton(
                  onPressed: () {
                    final preco = (jogo['preco'] is num) ? jogo['preco'].toDouble() : 0.0;
                    final novoProduto = Produto(
                      id: jogo['id'],
                      nome: jogo['nome'],
                      preco: preco,
                      imagem: jogo['imagem'],
                    );
                    carrinho.adicionarProduto(novoProduto);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${jogo['nome']} adicionado ao carrinho!")),
                    );
                  },
                  child: Text("Adicionar ao Carrinho"),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              jogo['descricao'] ?? 'Descrição não disponível',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
