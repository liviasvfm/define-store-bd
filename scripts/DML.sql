-- Categoria
INSERT INTO Categoria (nome) VALUES
('Masculino'), ('Feminino'), ('Infantil'), ('Unissex'), ('Acessórios'),
('Calçados'), ('Suplementos'), ('Bolsas'), ('Outros'), ('Edição Limitada');

-- Produto
INSERT INTO Produto (nome, descricao, preco, tamanho, cor, marca, id_categoria) VALUES
('Camisa Dry Fit', 'Camisa esportiva masculina', 59.90, 'M', 'Preto', 'Nike', 1),
('Top Fitness', 'Top feminino de alta sustentação', 49.90, 'P', 'Rosa', 'Adidas', 2),
('Calça Legging', 'Legging compressiva', 89.90, 'M', 'Azul', 'Reebok', 2),
('Tênis Corrida', 'Tênis com amortecimento', 199.90, '42', 'Preto', 'Asics', 6),
('Mochila Gym', 'Mochila esportiva', 89.90, 'Único', 'Cinza', 'Under Armour', 8),
('Suplemento Whey', 'Proteína concentrada 900g', 149.90, 'Único', 'Branco', 'IntegralMédica', 7),
('Cinto de Levantamento', 'Cinto de couro', 99.90, 'G', 'Marrom', 'ProForce', 5),
('Jaqueta Fitness', 'Impermeável com zíper', 149.90, 'G', 'Azul', 'Nike', 1),
('Shorts Treino', 'Shorts leve masculino', 39.90, 'M', 'Cinza', 'Puma', 1),
('Boné Dry', 'Boné com tecido tecnológico', 29.90, 'Único', 'Preto', 'Adidas', 5);

-- Fornecedor
INSERT INTO Fornecedor (nome, telefone, email, endereco) VALUES
('FitDistribuidora', '11999999999', 'contato@fitdistribuidora.com', 'Rua das Laranjeiras, 123'),
('AtivaFitness', '11888888888', 'vendas@ativafitness.com', 'Av. Paulista, 1000'),
('SportCenter', '11777777777', 'suporte@sportcenter.com', 'Rua dos Atletas, 45'),
('MundoFitness', '11666666666', 'mundo@fitness.com', 'Rua Energia, 88'),
('NutriLife', '11555555555', 'contato@nutrilife.com', 'Av. Suplementos, 777'),
('Alpha Suplementos', '11444444444', 'alpha@suplementos.com', 'Rua Proteína, 321'),
('ForceStore', '11333333333', 'vendas@forcestore.com', 'Rua Peso, 654'),
('DryStyle', '11222222222', 'dry@style.com', 'Av. Seco, 432'),
('RunShop', '11111111111', 'contato@runshop.com', 'Rua Corrida, 999'),
('GymAll', '11989898989', 'gym@gymall.com', 'Rua Academia, 222');

-- Cliente
INSERT INTO Cliente (nome, telefone, email, endereco) VALUES
('Lucas Ferreira', '11911111111', 'lucas@exemplo.com', 'Rua A, 123'),
('Mariana Costa', '11922222222', 'mariana@exemplo.com', 'Rua B, 234'),
('Paulo Silva', '11933333333', 'paulo@exemplo.com', 'Rua C, 345'),
('Ana Beatriz', '11944444444', 'ana@exemplo.com', 'Rua D, 456'),
('Carlos Eduardo', '11955555555', 'carlos@exemplo.com', 'Rua E, 567'),
('Fernanda Lima', '11966666666', 'fernanda@exemplo.com', 'Rua F, 678'),
('Juliano Martins', '11977777777', 'juliano@exemplo.com', 'Rua G, 789'),
('Raquel Souza', '11988888888', 'raquel@exemplo.com', 'Rua H, 890'),
('Ricardo Oliveira', '11999999999', 'ricardo@exemplo.com', 'Rua I, 901'),
('Beatriz Ramos', '11900000000', 'beatriz@exemplo.com', 'Rua J, 012');
