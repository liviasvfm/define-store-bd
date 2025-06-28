-- PROCEDURES – DEFINE STORE

-- 1. Cadastrar nova venda
DELIMITER //
CREATE PROCEDURE sp_realizar_venda(
    IN p_id_cliente INT,
    IN p_id_funcionario INT,
    IN p_forma_pagamento VARCHAR(30),
    IN p_total DECIMAL(10,2)
)
BEGIN
    DECLARE nova_venda_id INT;

    INSERT INTO Venda (id_cliente, id_funcionario, data_venda, forma_pagamento, total)
    VALUES (p_id_cliente, p_id_funcionario, CURDATE(), p_forma_pagamento, p_total);

    SET nova_venda_id = LAST_INSERT_ID();

    UPDATE Venda SET status = 'Finalizada' WHERE id_venda = nova_venda_id;

    SELECT * FROM Venda WHERE id_venda = nova_venda_id;
END;
//
DELIMITER ;

-- 2. Aplicar desconto por categoria
DELIMITER //
CREATE PROCEDURE sp_aplicar_desconto_categoria(
    IN p_id_categoria INT,
    IN p_percentual DECIMAL(5,2)
)
BEGIN
    UPDATE Produto
    SET preco = preco * (1 - p_percentual / 100)
    WHERE id_categoria = p_id_categoria;

    SELECT nome, preco FROM Produto WHERE id_categoria = p_id_categoria;

    INSERT INTO Promocao (descricao, data_inicio, data_fim, percentual_desconto)
    VALUES (CONCAT('Desconto de ', p_percentual, '%'), CURDATE(), CURDATE() + INTERVAL 7 DAY, p_percentual);
END;
//
DELIMITER ;

-- 3. Adicionar cliente com verificação
DELIMITER //
CREATE PROCEDURE sp_adicionar_cliente(
    IN p_nome VARCHAR(100),
    IN p_telefone VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_endereco TEXT
)
BEGIN
    IF EXISTS (SELECT 1 FROM Cliente WHERE email = p_email) THEN
        SELECT 'Cliente já existe com este e-mail.' AS mensagem;
    ELSE
        INSERT INTO Cliente (nome, telefone, email, endereco)
        VALUES (p_nome, p_telefone, p_email, p_endereco);

        SELECT * FROM Cliente WHERE email = p_email;
    END IF;
END;
//
DELIMITER ;

-- 4. Relatório estoque por fornecedor
DELIMITER //
CREATE PROCEDURE sp_relatorio_estoque_fornecedor()
BEGIN
    SELECT f.nome AS fornecedor, SUM(e.quantidade) AS total_estoque, COUNT(DISTINCT e.id_produto) AS produtos
    FROM Fornecedor f
    JOIN Estoque e ON f.id_fornecedor = e.id_fornecedor
    GROUP BY f.nome;

    SELECT COUNT(*) AS total_fornecedores FROM Fornecedor;
END;
//
DELIMITER ;

-- 5. Registrar funcionário com verificação
DELIMITER //
CREATE PROCEDURE sp_registrar_funcionario(
    IN p_nome VARCHAR(100),
    IN p_cargo VARCHAR(50),
    IN p_telefone VARCHAR(20),
    IN p_email VARCHAR(100)
)
BEGIN
    IF EXISTS (SELECT 1 FROM Funcionario WHERE email = p_email) THEN
        UPDATE Funcionario SET cargo = p_cargo WHERE email = p_email;
        SELECT 'Funcionário existente atualizado.' AS mensagem;
    ELSE
        INSERT INTO Funcionario (nome, cargo, telefone, email)
        VALUES (p_nome, p_cargo, p_telefone, p_email);
        SELECT 'Novo funcionário registrado.' AS mensagem;
    END IF;
END;
//
DELIMITER ;

-- 6. Vendas em período
DELIMITER //
CREATE PROCEDURE sp_vendas_periodo(
    IN data_inicio DATE,
    IN data_fim DATE
)
BEGIN
    SELECT * FROM Venda
    WHERE data_venda BETWEEN data_inicio AND data_fim;

    SELECT SUM(total) AS total_vendido
    FROM Venda
    WHERE data_venda BETWEEN data_inicio AND data_fim;

    SELECT COUNT(*) AS quantidade_vendas
    FROM Venda
    WHERE data_venda BETWEEN data_inicio AND data_fim;

    SELECT f.nome, COUNT(v.id_venda) AS vendas
    FROM Venda v
    JOIN Funcionario f ON v.id_funcionario = f.id_funcionario
    WHERE v.data_venda BETWEEN data_inicio AND data_fim
    GROUP BY f.nome;
END;
//
DELIMITER ;
