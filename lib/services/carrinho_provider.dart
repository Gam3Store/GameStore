import 'package:flutter/material.dart';

class Produto {
  final String id;
  final String nome;
  final double preco;
  final String imagem;
  int quantidade;

  Produto({
    required this.id,
    required this.nome,
    required this.preco,
    required this.imagem,
    this.quantidade = 1,
  });
}

class CarrinhoProvider with ChangeNotifier {
  final List<Produto> _produtos = [];

  List<Produto> get produtos => _produtos;

  void adicionarProduto(Produto produto) {
    var existente = _produtos.firstWhere(
      (p) => p.id == produto.id,
      orElse: () => Produto(id: "", nome: "", preco: 0.0, imagem: ""),
    );

    if (existente.id.isNotEmpty) {
      existente.quantidade++;
    } else {
      _produtos.add(produto);
    }
    
    print("Produto adicionado: ${produto.nome}, Total no carrinho: ${_produtos.length}"); // Debugging
    notifyListeners();
  }


  void removerProduto(String id) {
    _produtos.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  double calcularTotal() {
    return _produtos.fold(0.0, (total, p) => total + (p.preco * p.quantidade));
  }

  void limparCarrinho() {
    _produtos.clear();
    notifyListeners();
  }
}
