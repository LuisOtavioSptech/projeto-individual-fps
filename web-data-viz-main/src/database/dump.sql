CREATE DATABASE valorantStats;
USE valorantStats;

CREATE TABLE usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    email VARCHAR(80) NOT NULL UNIQUE,
    senha VARCHAR(50) NOT NULL,
    dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 1:1 com usuario
CREATE TABLE perfilJogador (
    idPerfil INT PRIMARY KEY AUTO_INCREMENT,
    nickname VARCHAR(30) NOT NULL,
    tag VARCHAR(10) NOT NULL,
    rankAtual VARCHAR(20),
    fkUsuario INT NOT NULL UNIQUE,
    CONSTRAINT fkPerfilUsuario FOREIGN KEY (fkUsuario)
        REFERENCES usuario(idUsuario)
);

CREATE TABLE mapa (
    idMapa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE agente (
    idAgente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30) NOT NULL UNIQUE,
    funcao VARCHAR(20) NOT NULL,
    CONSTRAINT chkFuncao CHECK (funcao IN
        ('Duelista', 'Sentinela', 'Controlador', 'Iniciador'))
);

-- 1:n com usuario, mapa e agente
CREATE TABLE partida (
    idPartida INT PRIMARY KEY AUTO_INCREMENT,
    dtPartida DATETIME NOT NULL,
    resultado VARCHAR(10) NOT NULL,
    kills INT NOT NULL,
    deaths INT NOT NULL,
    assists INT NOT NULL,
    fkUsuario INT NOT NULL,
    fkMapa INT NOT NULL,
    fkAgente INT NOT NULL,
    CONSTRAINT chkResultado CHECK (resultado IN ('vitoria', 'derrota')),
    CONSTRAINT fkPartidaUsuario FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario),
    CONSTRAINT fkPartidaMapa FOREIGN KEY (fkMapa) REFERENCES mapa(idMapa),
    CONSTRAINT fkPartidaAgente FOREIGN KEY (fkAgente) REFERENCES agente(idAgente)
);

INSERT INTO usuario (nome, email, senha) VALUES
('Luis Otávio', 'luis@email.com', 'senha123'),
('Jogador Teste', 'teste@email.com', 'senha123');

INSERT INTO perfilJogador (nickname, tag, rankAtual, fkUsuario) VALUES
('LuisOt', 'BR1', 'Ouro 2', 1),
('Teste', 'BR2', 'Prata 3', 2);

INSERT INTO mapa (nome) VALUES
('Ascent'), ('Bind'), ('Haven'), ('Split'), ('Lotus');

INSERT INTO agente (nome, funcao) VALUES
('Jett', 'Duelista'),
('Reyna', 'Duelista'),
('Sage', 'Sentinela'),
('Omen', 'Controlador'),
('Sova', 'Iniciador');

INSERT INTO partida
(dtPartida, resultado, kills, deaths, assists, fkUsuario, fkMapa, fkAgente) VALUES
('2026-11-01 20:00:00', 'vitoria', 22, 14, 5, 1, 1, 1),
('2026-11-02 21:30:00', 'derrota', 15, 18, 7, 1, 2, 4),
('2026-11-03 19:45:00', 'vitoria', 19, 11, 3, 1, 1, 2),
('2026-11-04 22:10:00', 'vitoria', 25, 16, 4, 1, 3, 1),
('2026-11-05 20:20:00', 'derrota', 12, 17, 9, 1, 4, 5);