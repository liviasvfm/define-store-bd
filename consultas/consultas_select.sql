-- CONSULTAS SQL (DQL) – DEFINE STORE


-- 1. Produtos por categoria
SELECT p.nome AS produto, p.preco, c.nome AS categoria
FROM Produto p
JOIN Categoria c ON p.id_categoria = c.id_categoria;

-- 2. Produtos com estoque crítico (menos de 5)
SELECT p.nome, e.quantidade
FROM Produto p
JOIN Estoque e ON p.id_produto = e.id_produto
WHERE e.quantidade < 5;

-- 3. Top 5 produtos mais vendidos
SELECT p.nome, SUM(iv.quantidade) AS total_vendido
FROM Produto p
JOIN ItemVenda iv ON p.id_produto = iv.id_produto
GROUP BY p.nome
ORDER BY total_vendido DESC
LIMIT 5;

-- 4. Clientes que mais compraram
SELECT c.nome, COUNT(v.id_venda) AS total_compras, SUM(v.total) AS valor_total
FROM Cliente c
JOIN Venda v ON c.id_cliente = v.id_cliente
GROUP BY c.nome
ORDER BY valor_total DESC;

-- 5. Promoções ativas e seus produtos
SELECT p.nome, pr.percentual_desconto
FROM Produto p
JOIN ProdutoPromocao pp ON p.id_produto = pp.id_produto
JOIN Promocao pr ON pp.id_promocao = pr.id_promocao
WHERE CURDATE() BETWEEN pr.data_inicio AND pr.data_fim;

-- 6. Vendas por funcionário
SELECT f.nome, COUNT(v.id_venda) AS vendas, SUM(v.total) AS valor_total
FROM Funcionario f
JOIN Venda v ON f.id_funcionario = v.id_funcionario
GROUP BY f.nome;

-- 7. Produtos nunca vendidos
SELECT p.nome
FROM Produto p
WHERE p.id_produto NOT IN (SELECT DISTINCT id_produto FROM ItemVenda);

-- 8. Média de preço por categoria
SELECT c.nome, AVG(p.preco) AS media_preco
FROM Categoria c
JOIN Produto p ON c.id_categoria = p.id_categoria
GROUP BY c.nome;

-- 9. Fornecedores e seus produtos
SELECT f.nome AS fornecedor, p.nome AS produto, e.quantidade
FROM Fornecedor f
JOIN Estoque e ON f.id_fornecedor = e.id_fornecedor
JOIN Produto p ON e.id_produto = p.id_produto;

-- 10. Formas de pagamento mais utilizadas
SELECT forma_pagamento, COUNT(*) AS total
FROM Venda
GROUP BY forma_pagamento;

-- 11. Produtos com maior margem (acima de 1.5x a média)
SELECT nome, preco
FROM Produto
WHERE preco > (SELECT AVG(preco) * 1.5 FROM Produto);

-- 12. Entrada em estoque nos últimos 30 dias
SELECT p.nome, e.data_entrada, e.quantidade
FROM Produto p
JOIN Estoque e ON p.id_produto = e.id_produto
WHERE e.data_entrada >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

-- 13. Clientes que compraram produtos em promoção
SELECT DISTINCT c.nome
FROM Cliente c
JOIN Venda v ON c.id_cliente = v.id_cliente
JOIN ItemVenda iv ON v.id_venda = iv.id_venda
JOIN ProdutoPromocao pp ON iv.id_produto = pp.id_produto;

-- 14. Vendas por mês/ano
SELECT YEAR(data_venda) AS ano, MONTH(data_venda) AS mes, SUM(total) AS total_vendido
FROM Venda
GROUP BY YEAR(data_venda), MONTH(data_venda);

-- 15. Produtos por marca e categoria
SELECT marca, c.nome AS categoria, COUNT(*) AS total_produtos
FROM Produto p
JOIN Categoria c ON p.id_categoria = c.id_categoria
GROUP BY marca, c.nome;

-- 16. Ticket médio por cliente
SELECT c.nome, COUNT(v.id_venda) AS qtd, SUM(v.total) AS total, AVG(v.total) AS ticket_medio
FROM Cliente c
JOIN Venda v ON c.id_cliente = v.id_cliente
GROUP BY c.nome;

-- 17. Produtos com mais tempo no estoque
SELECT p.nome, DATEDIFF(CURDATE(), e.data_entrada) AS dias
FROM Produto p
JOIN Estoque e ON p.id_produto = e.id_produto
ORDER BY dias DESC;

-- 18. Funcionários com vendas acima da média
SELECT f.nome, COUNT(v.id_venda) AS total
FROM Funcionario f
JOIN Venda v ON f.id_funcionario = v.id_funcionario
GROUP BY f.nome
HAVING total > (SELECT COUNT(*) / COUNT(DISTINCT id_funcionario) FROM Venda);

-- 19. Categoria com produto mais caro
SELECT c.nome AS categoria,
       (SELECT p.nome FROM Produto p WHERE p.id_categoria = c.id_categoria ORDER BY p.preco DESC LIMIT 1) AS produto,
       (SELECT MAX(p.preco) FROM Produto p WHERE p.id_categoria = c.id_categoria) AS preco
FROM Categoria c;

-- 20. Venda completa (venda, item, cliente, funcionário)
SELECT v.id_venda, c.nome AS cliente, f.nome AS funcionario,
       p.nome AS produto, iv.quantidade, iv.preco_unitario, v.total
FROM Venda v
JOIN Cliente c ON v.id_cliente = c.id_cliente
JOIN Funcionario f ON v.id_funcionario = f.id_funcionario
JOIN ItemVenda iv ON v.id_venda = iv.id_venda
JOIN Produto p ON iv.id_produto = p.id_produto;



