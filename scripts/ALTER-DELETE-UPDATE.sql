4.2 Alterações nas Tabelas (ALTER TABLE)

ALTER TABLE Produto ADD COLUMN descricao_curta VARCHAR(100);

ALTER TABLE Cliente MODIFY COLUMN nome VARCHAR(150);

ALTER TABLE Cliente ADD COLUMN cpf VARCHAR(14);

ALTER TABLE Funcionario CHANGE telefone telefone_celular VARCHAR(20);

ALTER TABLE Venda ADD COLUMN status VARCHAR(20) DEFAULT 'Em aberto';

ALTER TABLE Estoque ADD CONSTRAINT fk_estoque_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id_fornecedor);

ALTER TABLE Produto DROP COLUMN descricao_curta;

ALTER TABLE Fornecedor ADD COLUMN instagram VARCHAR(100);

ALTER TABLE Cliente ADD INDEX idx_email_cliente (email);

ALTER TABLE Promocao MODIFY COLUMN percentual_desconto DECIMAL(6,2);


ALTER TABLE Promocao MODIFY COLUMN percentual_desconto DECIMAL(6,2);


4.3 Destruição das Tabelas (DROP TABLE)

-- Script de exclusão de todas as tabelas do banco loja_roupas

DROP TABLE IF EXISTS ProdutoPromocao;
DROP TABLE IF EXISTS ItemVenda;
DROP TABLE IF EXISTS Estoque;
DROP TABLE IF EXISTS Venda;
DROP TABLE IF EXISTS Promocao;
DROP TABLE IF EXISTS Produto;
DROP TABLE IF EXISTS Categoria;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Funcionario;
DROP TABLE IF EXISTS Fornecedor;


4.4 UPDATE / DELETE
-- UPDATE e DELETE – Manipulação de Dados (20 comandos)
-- UPDATES (10 comandos)
UPDATE Produto SET preco = preco * 0.9 WHERE id_categoria = 1;
UPDATE Cliente SET telefone = '11987654321' WHERE nome = 'Lucas Ferreira';
UPDATE Fornecedor SET email = 'novoemail@fitdistribuidora.com' WHERE nome = 'FitDistribuidora';
UPDATE Venda SET status = 'Finalizada' WHERE id_venda = 1;
UPDATE Funcionario SET cargo = 'Supervisor' WHERE id_funcionario = 2;
UPDATE Produto SET cor = 'Verde' WHERE nome = 'Top Fitness';
UPDATE Estoque SET quantidade = quantidade + 10 WHERE id_produto = 1;
UPDATE Promocao SET percentual_desconto = 20.00 WHERE descricao LIKE '%Inverno%';
UPDATE Cliente SET nome = 'Carlos E. Souza' WHERE id_cliente = 5;
UPDATE Produto SET preco = 29.99 WHERE nome = 'Boné Dry';

-- DELETES (10 comandos)
DELETE FROM ProdutoPromocao WHERE id_produto = 3;
DELETE FROM ItemVenda WHERE id_item = 5;
DELETE FROM Estoque WHERE quantidade = 0;
DELETE FROM Venda WHERE id_venda = 2;
DELETE FROM Cliente WHERE id_cliente = 10;
DELETE FROM Fornecedor WHERE nome = 'DryStyle';
DELETE FROM Produto WHERE nome = 'Suplemento Whey';
DELETE FROM Promocao WHERE data_fim < CURDATE();
DELETE FROM Funcionario WHERE cargo = 'Estagiário';
DELETE FROM Categoria WHERE nome = 'Outros';


