import 'package:flutter/material.dart';
import 'package:gamestore/services/pesquisa_jogos.dart';
import 'package:provider/provider.dart';
import 'package:gamestore/services/carrinho_provider.dart';

class CarrinhoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final carrinho = Provider.of<CarrinhoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
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
        ],
        ),
      body: carrinho.produtos.isEmpty
          ? Center(child: Text("Seu carrinho está vazio!"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: carrinho.produtos.length,
                    itemBuilder: (context, index) {
                      final produto = carrinho.produtos[index];
                      return ListTile(
                        leading: Image.network(produto.imagem, width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(produto.nome),
                        subtitle: Text("R\$${produto.preco} x ${produto.quantidade}"),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            carrinho.removerProduto(produto.id);
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Total: R\$${carrinho.calcularTotal().toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    carrinho.limparCarrinho();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Compra finalizada!")),
                    );
                  },
                  child: Text("Finalizar Compra"),
                ),
              ],
            ),
    );
  }
}
