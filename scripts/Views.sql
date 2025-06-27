4.6 Criação de Views (DDL)
As views foram criadas para facilitar a análise de dados, como os produtos mais vendidos, clientes que mais compraram, produtos em estoque crítico, entre outros. Isso promove maior agilidade na tomada de decisões e na geração de relatórios gerenciais.

Remoção das views antigas
DROP VIEW IF EXISTS 
    vw_produtos_por_categoria,
    vw_estoque_critico,
    vw_top_produtos_mais_vendidos,
    vw_clientes_fieis,
    vw_promocoes_ativas,
    vw_vendas_por_funcionario,
    vw_produtos_nunca_vendidos,
    vw_media_preco_por_categoria,
    vw_formas_pagamento_mais_usadas,
    vw_ticket_medio_cliente;

1. Produtos por Categoria
CREATE VIEW vw_produtos_por_categoria AS
SELECT p.nome AS produto, p.preco, c.nome AS categoria
FROM Produto p
JOIN Categoria c ON p.id_categoria = c.id_categoria;

2. Produtos com Estoque Crítico
CREATE VIEW vw_estoque_critico AS
SELECT p.nome, e.quantidade
FROM Produto p
JOIN Estoque e ON p.id_produto = e.id_produto
WHERE e.quantidade < 5;

3. Top Produtos Mais Vendidos
CREATE VIEW vw_top_produtos_mais_vendidos AS
SELECT p.nome, SUM(iv.quantidade) AS total_vendido
FROM Produto p
JOIN ItemVenda iv ON p.id_produto = iv.id_produto
GROUP BY p.nome
ORDER BY total_vendido DESC
LIMIT 5;

4. Clientes Fieis (Mais Compraram)
CREATE VIEW vw_clientes_fieis AS
SELECT c.nome, COUNT(v.id_venda) AS total_compras, SUM(v.total) AS valor_total
FROM Cliente c
JOIN Venda v ON c.id_cliente = v.id_cliente
GROUP BY c.nome
ORDER BY valor_total DESC;

 5. Promoções Ativas e Produtos
CREATE VIEW vw_promocoes_ativas AS
SELECT p.nome, pr.percentual_desconto
FROM Produto p
JOIN ProdutoPromocao pp ON p.id_produto = pp.id_produto
JOIN Promocao pr ON pp.id_promocao = pr.id_promocao
WHERE CURDATE() BETWEEN pr.data_inicio AND pr.data_fim;

6. Vendas por Funcionário
CREATE VIEW vw_vendas_por_funcionario AS
SELECT f.nome, COUNT(v.id_venda) AS vendas, SUM(v.total) AS valor_total
FROM Funcionario f
JOIN Venda v ON f.id_funcionario = v.id_funcionario
GROUP BY f.nome;

7. Produtos Nunca Vendidos
CREATE VIEW vw_produtos_nunca_vendidos AS
SELECT p.nome, p.preco
FROM Produto p
WHERE p.id_produto NOT IN (SELECT id_produto FROM ItemVenda);


8. Média de Preço por Categoria
CREATE VIEW vw_media_preco_por_categoria AS
SELECT c.nome, AVG(p.preco) AS media_preco
FROM Categoria c
JOIN Produto p ON c.id_categoria = p.id_categoria
GROUP BY c.nome;

9. Formas de Pagamento Mais Usadas
CREATE VIEW vw_formas_pagamento_mais_usadas AS
SELECT forma_pagamento, COUNT(*) AS total_vendas
FROM Venda
GROUP BY forma_pagamento;

10. Ticket Médio por Cliente
CREATE VIEW vw_ticket_medio_cliente AS
SELECT 
    c.nome,
    COUNT(v.id_venda) AS qtd_compras,
    SUM(v.total) AS total_gasto,
    SUM(v.total)/COUNT(v.id_venda) AS ticket_medio
FROM Cliente c
JOIN Venda v ON c.id_cliente = v.id_cliente
GROUP BY c.nome;
