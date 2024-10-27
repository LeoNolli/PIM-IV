CREATE DATABASE IF NOT EXISTS `fazenda`;
USE `fazenda`;

-- Tabela Usuario
CREATE TABLE IF NOT EXISTS `Usuario` (
  `UsuarioId` INT NOT NULL AUTO_INCREMENT,
  `Email` VARCHAR(50),
  `Senha` VARCHAR(255),
  `DataCriacao` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `Funcao` VARCHAR(15),
  PRIMARY KEY (`UsuarioId`),
  CONSTRAINT UQ_Usuario_EmailLogin UNIQUE (`Email`)
);

-- Tabela Cliente
CREATE TABLE IF NOT EXISTS `Cliente` (
  `ClienteId` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(50),
  `CPF` VARCHAR(14),
  `RG` VARCHAR(20),
  `Endereco` VARCHAR(100),
  `Telefone` VARCHAR(20),
  `UsuarioId` INT,
  CONSTRAINT PK_Cliente PRIMARY KEY (`ClienteId`),
  CONSTRAINT UQ_Cliente_CPF UNIQUE (`CPF`),
  FOREIGN KEY (`UsuarioId`) REFERENCES `Usuario`(`UsuarioId`) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Tabela Funcionario
CREATE TABLE IF NOT EXISTS `Funcionario` (
  `FuncionarioId` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(50),
  `CPF` VARCHAR(14),
  `RG` VARCHAR(20),
  `Endereco` VARCHAR(100),
  `Telefone` VARCHAR(20),
  `Cargo` VARCHAR(30),
  `UsuarioId` INT,
  CONSTRAINT PK_Funcionario PRIMARY KEY (`FuncionarioId`),
  CONSTRAINT UQ_Funcionario_CPF UNIQUE (`CPF`),
  FOREIGN KEY (`UsuarioId`) REFERENCES `Usuario`(`UsuarioId`) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Tabela ControleProducao
CREATE TABLE IF NOT EXISTS `ControleProducao` (
  `ProducaoId` INT NOT NULL AUTO_INCREMENT,
  `Data` DATE,
  `Hora` TIME,
  `Quantidade` INT,
  `DataInicio` DATE,
  `DataConclusao` DATE,
  `Status` VARCHAR(50),
  `FuncionarioId` INT,
  CONSTRAINT PK_ControleProducao PRIMARY KEY (`ProducaoId`),
  FOREIGN KEY (`FuncionarioId`) REFERENCES `Funcionario`(`FuncionarioId`) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Tabela Insumos
CREATE TABLE IF NOT EXISTS `Insumo` (
  `InsumoId` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(50),
  `Descricao` VARCHAR(100),
  `Quantidade` INT,
  `Preco` FLOAT,
  CONSTRAINT PK_Insumos PRIMARY KEY (`InsumoId`)
);

-- Tabela Produto
CREATE TABLE IF NOT EXISTS `Produto` (
  `ProdutoId` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(50),
  `Descricao` VARCHAR(100),
  `QuantidadeEstoque` INT,
  `Preco` FLOAT,
  `FuncionarioId` INT,
  CONSTRAINT PK_Produto PRIMARY KEY (`ProdutoId`),
  FOREIGN KEY (`FuncionarioId`) REFERENCES `Funcionario`(`FuncionarioId`) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Tabela Venda
CREATE TABLE IF NOT EXISTS `Venda` (
  `VendaId` INT NOT NULL AUTO_INCREMENT,
  `Data` DATE,
  `Hora` TIME,
  `ValorTotal` FLOAT,
  `ClienteId` INT,
  CONSTRAINT PK_Venda PRIMARY KEY (`VendaId`),
  FOREIGN KEY (`ClienteId`) REFERENCES `Cliente`(`ClienteId`) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Tabela ItemVenda
CREATE TABLE IF NOT EXISTS `ItemVenda` (
  `ProdutoId` INT,
  `VendaId` INT,
  `Quantidade` INT,
  `PrecoVenda` FLOAT,
  CONSTRAINT PK_ItemVenda PRIMARY KEY (`ProdutoId`, `VendaId`),
  FOREIGN KEY (`ProdutoId`) REFERENCES `Produto`(`ProdutoId`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`VendaId`) REFERENCES `Venda`(`VendaId`) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabela InsumoProducao
CREATE TABLE IF NOT EXISTS `InsumoProducao` (
  `Quantidade` FLOAT,
  `ProducaoId` INT,
  `InsumoId` INT,
  CONSTRAINT PK_InsumoProducao PRIMARY KEY (`ProducaoId`, `InsumoId`),
  FOREIGN KEY (`ProducaoId`) REFERENCES `ControleProducao`(`ProducaoId`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`InsumoId`) REFERENCES `Insumo`(`InsumoId`) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO `fazenda`.`usuario`
(`Email`,
`Senha`,
`DataCriacao`,
`Funcao`)
VALUES
('Admin@Admin',
'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI=',
'2024-10-17 20:37:26',
'Admin');
