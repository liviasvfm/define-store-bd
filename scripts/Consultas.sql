4.5 20 consultas SQL (DQL): JOIN e/ou SELECT


 Relatório de Consultas SQL para o Sistema DEFINE STORE:

1. Relatório de Produtos por Categoria

SELECT p.nome AS produto, p.preco, c.nome AS categoria
FROM Produto p
JOIN Categoria c ON p.id_categoria = c.id_categoria;


2. Produtos com Estoque Crítico 
Objetivo: Identificar produtos que necessitam de reposição urgente
```
SELECT p.nome, e.quantidade
FROM Produto p
JOIN Estoque e ON p.id_produto = e.id_produto
WHERE e.quantidade < 5;
```

3. Top 5 Produtos Mais Vendidos
Objetivo: Identificar os produtos com maior saída
```sql
SELECT p.nome, SUM(iv.quantidade) AS total_vendido
FROM Produto p
JOIN ItemVenda iv ON p.id_produto = iv.id_produto
GROUP BY p.nome
ORDER BY total_vendido DESC
LIMIT 5;
```

4. Clientes que Mais Compraram (Ranking)
Objetivo: Fidelizar os melhores clientes
```sql
SELECT c.nome, COUNT(v.id_venda) AS total_compras, SUM(v.total) AS valor_total
FROM Cliente c
JOIN Venda v ON c.id_cliente = v.id_cliente
GROUP BY c.nome
ORDER BY valor_total DESC;
```

5. Promoções Ativas e Seus Produtos
Objetivo: Monitorar campanhas promocionais
```sql
SELECT p.nome, pr.percentual_desconto
FROM Produto p
JOIN ProdutoPromocao pp ON p.id_produto = pp.id_produto
JOIN Promocao pr ON pp.id_promocao = pr.id_promocao
WHERE CURDATE() BETWEEN pr.data_inicio AND pr.data_fim;
```

6. Vendas por Funcionário (Desempenho)
Objetivo: Avaliar performance da equipe
```sql
SELECT f.nome, COUNT(v.id_venda) AS vendas, SUM(v.total) AS valor_total
FROM Funcionario f
JOIN Venda v ON f.id_funcionario = v.id_funcionario
GROUP BY f.nome;
```

7. Produtos Nunca Vendidos
Objetivo: Identificar itens com baixa rotatividade
```sql
SELECT p.nome, p.preco
FROM Produto p
WHERE p.id_produto NOT IN (SELECT id_produto FROM ItemVenda);
```

8. Média de Preço por Categoria
Objetivo: Análise de precificação estratégica
```sql
SELECT c.nome, AVG(p.preco) AS media_preco
FROM Categoria c
JOIN Produto p ON c.id_categoria = p.id_categoria
GROUP BY c.nome;
```

9. Fornecedores e Seus Produtos em Estoque
Objetivo: Gerenciar relações com fornecedores
```sql
SELECT f.nome AS fornecedor, p.nome AS produto, e.quantidade
FROM Fornecedor f
JOIN Estoque e ON f.id_fornecedor = e.id_fornecedor
JOIN Produto p ON e.id_produto = p.id_produto;
```

10. Formas de Pagamento Mais Utilizadas
Objetivo: Otimizar métodos de pagamento
```sql
SELECT forma_pagamento, COUNT(*) AS total_vendas
FROM Venda
GROUP BY forma_pagamento;
```

11. Produtos com Maior Margem de Lucro
Objetivo: Focar nos itens mais rentáveis
```sql
SELECT nome, preco
FROM Produto
WHERE preco > (SELECT AVG(preco)*1.5 FROM Produto);
```






12. Histórico de Entrada no Estoque (Últimos 30 dias)
Objetivo: Controlar fluxo de mercadorias
```sql
SELECT p.nome, e.data_entrada, e.quantidade
FROM Produto p
JOIN Estoque e ON p.id_produto = e.id_produto
WHERE e.data_entrada >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);
```

13. Clientes que Compraram em Promoção
Objetivo: Identificar comportamento de compra
```sql
SELECT DISTINCT c.nome
FROM Cliente c
JOIN Venda v ON c.id_cliente = v.id_cliente
JOIN ItemVenda iv ON v.id_venda = iv.id_venda
JOIN ProdutoPromocao pp ON iv.id_produto = pp.id_produto;
```

14. Vendas por Período (Mensal/Anual)
Objetivo: Análise sazonal
```sql
SELECT 
    YEAR(data_venda) AS ano,
    MONTH(data_venda) AS mes, 
    SUM(total) AS total_vendido
FROM Venda
GROUP BY YEAR(data_venda), MONTH(data_venda);
```

15. Produtos por Marca e Categoria
Objetivo: Análise de mix de produtos
```sql
SELECT marca, c.nome AS categoria, COUNT(*) AS total_produtos
FROM Produto p
JOIN Categoria c ON p.id_categoria = c.id_categoria
GROUP BY marca, c.nome;
```

16. Ticket Médio por Cliente
Objetivo: Melhorar valor médio das compras
```sql
SELECT 
    c.nome,
    COUNT(v.id_venda) AS qtd_compras,
    SUM(v.total) AS total_gasto,
    SUM(v.total)/COUNT(v.id_venda) AS ticket_medio
FROM Cliente c
JOIN Venda v ON c.id_cliente = v.id_cliente
GROUP BY c.nome;
```

17. Produtos com Maior Tempo em Estoque
Objetivo: Identificar itens parados
```sql
SELECT p.nome, DATEDIFF(CURDATE(), e.data_entrada) AS dias_estoque
FROM Produto p
JOIN Estoque e ON p.id_produto = e.id_produto
ORDER BY dias_estoque DESC;
```



18. Funcionários com Vendas Acima da Média
Objetivo: Reconhecer bons desempenhos
```sql
SELECT f.nome, COUNT(v.id_venda) AS vendas
FROM Funcionario f
JOIN Venda v ON f.id_funcionario = v.id_funcionario
GROUP BY f.nome
HAVING vendas > (SELECT COUNT(*)/COUNT(DISTINCT id_funcionario) FROM Venda);
```











19. Categorias com Produtos Mais Caros
Objetivo: Estratégia de precificação
```sql
SELECT 
    c.nome AS categoria,
    (SELECT p.nome FROM Produto p 
     WHERE p.id_categoria = c.id_categoria 
     ORDER BY p.preco DESC LIMIT 1) AS produto_mais_caro,
    (SELECT MAX(p.preco) FROM Produto p 
     WHERE p.id_categoria = c.id_categoria) AS preco_maximo
FROM Categoria c;
```

20. Relação Completa: Venda-Item-Cliente-Funcionário
Objetivo: Visão detalhada das transações

```sql
SELECT 
    v.id_venda,
    c.nome AS cliente,
    f.nome AS funcionario,
    p.nome AS produto,
    iv.quantidade,
    iv.preco_unitario,
    v.total
FROM Venda v
JOIN Cliente c ON v.id_cliente = c.id_cliente
JOIN Funcionario f ON v.id_funcionario = f.id_funcionario
JOIN ItemVenda iv ON v.id_venda = iv.id_venda
JOIN Produto p ON iv.id_produto = p.id_produto;
```

