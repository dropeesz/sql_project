
/*Criando Banco de dados*/

CREATE DATABASE tcc_banco_de_dados;

USE tcc_banco_de_dados;

/*Criando tabelas*/

CREATE TABLE funcionario (
id_funcionario INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
nome VARCHAR(150) NOT NULL,
cpf VARCHAR(14) NOT NULL UNIQUE,
endereco VARCHAR(150) NOT NULL,
salario DECIMAL(10,2) NOT NULL
);

CREATE TABLE fornecedor (
id_fornecedor INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
nome VARCHAR(150) NOT NULL,
cnpj VARCHAR(18) NOT NULL UNIQUE,
endereco VARCHAR(150) NOT NULL,
telefone VARCHAR(20) NOT NULL 
);

CREATE TABLE cliente (
id_cliente INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
nome VARCHAR(150) NOT NULL,
cpf VARCHAR(14) NOT NULL UNIQUE,
endereco VARCHAR(150) NOT NULL
);

CREATE TABLE forma_pagamento (
id_pagamento INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
tipo VARCHAR(20) NOT NULL 
);

CREATE TABLE pedido (
id_pedido INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
data_pedido DATE NOT NULL,
valor_unitario DECIMAL(10,2) NOT NULL,
fk_id_funcionarios INT NOT NULL ,
fk_id_clientes INT NOT NULL ,
fk_id_pagamento INT NOT NULL 
);

/*Adicionando chaves estrangeiras*/

ALTER TABLE pedido ADD CONSTRAINT fk_id_funcionarios FOREIGN
KEY (fk_id_funcionarios) REFERENCES funcionario(id_funcionario);

ALTER TABLE pedido ADD CONSTRAINT fk_id_clientes FOREIGN
KEY (fk_id_clientes) REFERENCES cliente(id_cliente);

ALTER TABLE pedido ADD CONSTRAINT fk_id_pagamento FOREIGN
KEY (fk_id_pagamento) REFERENCES forma_pagamento(id_pagamento);

/*Continuando na criação de tabelas*/

CREATE TABLE produto (
id_produto INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
quantidade INT NOT NULL,
valor DECIMAL(10,2) NOT NULL,
volume VARCHAR(50) NOT NULL,
fk_id_fornecedor INT NOT NULL,
FOREIGN KEY (fk_id_fornecedor) REFERENCES fornecedor (id_fornecedor)
);

CREATE TABLE pedido_produto (
fk_id_pedido INT NOT NULL ,
fk_id_produto INT NOT NULL ,
quantidade INT NOT NULL,
valor_unitario DECIMAL(10,2) NOT NULL,
FOREIGN KEY (fk_id_pedido) REFERENCES pedido (id_pedido),
FOREIGN KEY (fk_id_produto) REFERENCES produto (id_produto)
);

CREATE TABLE backup_produto (
    id_backup INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT,
    nome VARCHAR(150),
    valor DECIMAL(10,2),
    quantidade INT,
    volume VARCHAR(20),
    id_fornecedor INT,
    data_excluido DATETIME
);

/*Adicionou TRIGGER*/

DELIMITER $$
CREATE TRIGGER trg_backup_produto
BEFORE DELETE ON produto
FOR EACH ROW
BEGIN
  INSERT INTO backup_produto (
    id_produto, nome, valor, quantidade, volume, id_fornecedor, data_excluido
  ) VALUES (
    OLD.id_produto, OLD.nome, OLD.valor, OLD.quantidade, OLD.volume, OLD.fk_id_fornecedor, NOW()
  );
END$$
DELIMITER ;

/*Adicionando coluna esquecida*/

ALTER TABLE produto ADD COLUMN nome VARCHAR(20);

/*Adicionando TRIGGER*/

DELIMITER $$

CREATE TRIGGER trg_baixar_estoque
AFTER INSERT ON pedido_produto
FOR EACH ROW
BEGIN
    UPDATE produto
    SET quantidade = quantidade - NEW.quantidade
    WHERE id_produto = NEW.id_produto;
END$$

DELIMITER ;

/*Fazendo "INSERT INTO" */

INSERT INTO cliente (nome, cpf, endereco) VALUES
('João Mendes', '101.202.303-40', 'Rua Alfa, 10'),
('Paula Castro', '505.606.707-80', 'Rua Beta, 20'),
('André Lima', '909.808.707-60', 'Rua Gama, 30'),
('Fernanda Reis', '303.404.505-50', 'Rua Delta, 40'),
('Gabriel Costa', '808.707.606-30', 'Rua Ômega, 50');

INSERT INTO forma_pagamento (tipo) VALUES
('Crédito'),
('Débito'),
('Pix'),
('Dinheiro'),
('Boleto');

INSERT INTO pedido (data_pedido, valor_unitario, fk_id_funcionarios, fk_id_clientes, fk_id_pagamento) VALUES
('2025-01-15', 120.50, 1, 1, 1),
('2025-01-16', 250.00, 2, 2, 3),
('2025-01-17', 80.90, 3, 3, 2),
('2025-01-18', 300.00, 4, 4, 4),
('2025-01-19', 150.75, 5, 5, 5);

INSERT INTO produto (quantidade, valor, volume, fk_id_fornecedor) VALUES
(50, 10.00, '500ml', 1),
(30, 25.00, '1L', 2),
(100, 5.50, '200ml', 3),
(20, 80.00, '2L', 4),
(75, 12.75, '750ml', 5);

INSERT INTO pedido_produto (fk_id_pedido, fk_id_produto, quantidade, valor_unitario) VALUES
(1, 1, 2, 10.00),
(2, 2, 1, 25.00),
(3, 3, 5, 5.50),
(4, 4, 1, 80.00),
(5, 5, 3, 12.75);

INSERT INTO backup_produto (id_produto, nome, valor, quantidade, volume, id_fornecedor, data_excluido) VALUES
(1, 'Água Mineral', 10.00, 50, '500ml', 1, '2025-02-01 10:30:00'),
(2, 'Suco Natural', 25.00, 30, '1L', 2, '2025-02-02 11:00:00'),
(3, 'Refrigerante', 5.50, 100, '200ml', 3, '2025-02-03 12:15:00'),
(4, 'Detergente', 80.00, 20, '2L', 4, '2025-02-04 09:45:00'),
(5, 'Óleo de Cozinha', 12.75, 75, '750ml', 5, '2025-02-05 14:20:00');

/*Criando TRIGGER*/

DELIMITER $$

CREATE TRIGGER trg_baixar_estoque
AFTER INSERT ON pedido_produto
FOR EACH ROW
BEGIN
    UPDATE produto
    SET quantidade = quantidade - NEW.quantidade
    WHERE id_produto = NEW.fk_id_produto;
END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION total_produto (quantidade_produto int, preco decimal (10,2) )
RETURNS decimal (10,2)
DETERMINISTIC
BEGIN
    RETURN quantidade_produto * preco;
END$$

DELIMITER ;

SELECT total_produto (20, 10);

/*SELECT FROM */

SELECT * FROM produto;

/*Alterando um dado*/

UPDATE produto 
SET nome= "ego"
WHERE id_produto = 5;

/*SELECT FROM */

SELECT * FROM backup_produto;

START TRANSACTION;

/*1. Inserir pedido*/

INSERT INTO pedido (data_pedido, valor_unitario, fk_id_funcionarios, fk_id_clientes, fk_id_pagamento)
VALUES (NOW(2), 5.50 * 3, 1, 3, 2);

/*Recupera o ID do pedido inserido*/

SET @id_pedido = LAST_INSERT_ID(1);

/*2. Inserir produto no pedido*/

INSERT INTO pedido_produto (quantidade, valor_unitario)
VALUES (3, 5.50);

COMMIT;
