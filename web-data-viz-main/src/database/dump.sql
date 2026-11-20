CREATE DATABASE valorantStats;
USE valorantStats;

CREATE TABLE usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    email VARCHAR(80) NOT NULL UNIQUE,
    senha VARCHAR(50) NOT NULL,
    dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

insert into usuario(nome, email, senha) VALUES ('Luis', 'luis@gmail.com', 'senha123');

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

INSERT INTO perfilJogador (nickname, tag, rankAtual, fkUsuario) VALUES
('LsNN', 'BR1', 'Imortal 1', 1);

INSERT INTO mapa (nome) VALUES
('Ascent'), ('Bind'), ('Haven'), ('Split'), ('Icebox') , ('Lotus'), ('Sunset'), ('Abyss');

INSERT INTO agente (nome, funcao) VALUES
-- Duelistas
('Hush', 'Duelista'),
('Iso', 'Duelista'),
('Jett', 'Duelista'),
('Neon', 'Duelista'),
('Phoenix', 'Duelista'),
('Raze', 'Duelista'),
('Reyna', 'Duelista'),
('Waylay', 'Duelista'),
('Yoru', 'Duelista'),

-- Iniciadores
('Breach', 'Iniciador'),
('Fade', 'Iniciador'),
('Gekko', 'Iniciador'),
('KAY/O', 'Iniciador'),
('Skye', 'Iniciador'),
('Sova', 'Iniciador'),
('Tejo', 'Iniciador'),

-- Controladores
('Astra', 'Controlador'),
('Brimstone', 'Controlador'),
('Clove', 'Controlador'),
('Harbor', 'Controlador'),
('Miks', 'Controlador'),
('Omen', 'Controlador'),
('Viper', 'Controlador'),

-- Sentinelas
('Chamber', 'Sentinela'),
('Cypher', 'Sentinela'),
('Deadlock', 'Sentinela'),
('Killjoy', 'Sentinela'),
('Sage', 'Sentinela'),
('Veto', 'Sentinela'),
('Vyse', 'Sentinela');

SET @usuario = (SELECT idUsuario FROM usuario WHERE email = 'luis@gmail.com');

SET @raze    = (SELECT idAgente FROM agente WHERE nome = 'Raze');
SET @hush    = (SELECT idAgente FROM agente WHERE nome = 'Hush');
SET @chamber = (SELECT idAgente FROM agente WHERE nome = 'Chamber');

SET @ascent = (SELECT idMapa FROM mapa WHERE nome = 'Ascent');
SET @bind   = (SELECT idMapa FROM mapa WHERE nome = 'Bind');
SET @haven  = (SELECT idMapa FROM mapa WHERE nome = 'Haven');
SET @split  = (SELECT idMapa FROM mapa WHERE nome = 'Split');
SET @lotus  = (SELECT idMapa FROM mapa WHERE nome = 'Lotus');
SET @icebox = (SELECT idMapa FROM mapa WHERE nome = 'Icebox');
SET @sunset = (SELECT idMapa FROM mapa WHERE nome = 'Sunset');
SET @abyss  = (SELECT idMapa FROM mapa WHERE nome = 'Abyss');


INSERT INTO partida
(dtPartida, resultado, kills, deaths, assists, fkUsuario, fkMapa, fkAgente) VALUES
('2026-10-28 20:15:00', 'vitoria', 24, 15, 6, @usuario, @ascent, @hush),
('2026-10-28 21:40:00', 'derrota', 17, 17, 4, @usuario, @bind,   @hush),
('2026-10-29 19:30:00', 'vitoria', 28, 16, 5, @usuario, @split,  @raze),
('2026-10-29 20:50:00', 'vitoria', 26, 17, 3, @usuario, @lotus,  @raze),
('2026-10-30 21:10:00', 'derrota', 15, 18, 6, @usuario, @haven,  @chamber),
('2026-10-30 22:25:00', 'vitoria', 23, 14, 4, @usuario, @ascent, @chamber),
('2026-10-31 15:00:00', 'vitoria', 25, 17, 7, @usuario, @lotus,  @hush),
('2026-10-31 16:20:00', 'derrota', 19, 20, 5, @usuario, @bind,   @raze),
('2026-11-01 20:00:00', 'vitoria', 29, 15, 4, @usuario, @ascent, @raze),
('2026-11-02 21:30:00', 'derrota', 16, 18, 8, @usuario, @split,  @hush),
('2026-11-03 19:45:00', 'vitoria', 22, 13, 3, @usuario, @bind,   @chamber),
('2026-11-04 22:10:00', 'vitoria', 27, 16, 6, @usuario, @haven,  @hush),
('2026-11-05 20:20:00', 'derrota', 14, 19, 5, @usuario, @lotus,  @raze),
('2026-11-06 21:00:00', 'vitoria', 30, 17, 2, @usuario, @split,  @raze),
('2026-11-07 14:30:00', 'vitoria', 21, 15, 5, @usuario, @haven,  @chamber),
('2026-11-08 16:00:00', 'derrota', 13, 17, 4, @usuario, @split,  @chamber),
('2026-11-09 20:35:00', 'vitoria', 26, 18, 7, @usuario, @ascent, @hush),
('2026-11-10 21:15:00', 'derrota', 17, 20, 6, @usuario, @lotus,  @hush),
('2026-11-11 19:50:00', 'vitoria', 27, 16, 3, @usuario, @bind,   @raze),
('2026-11-12 22:00:00', 'derrota', 16, 18, 4, @usuario, @haven,  @raze),
('2026-11-13 20:40:00', 'vitoria', 24, 14, 5, @usuario, @lotus,  @chamber),
('2026-11-14 15:30:00', 'vitoria', 28, 19, 8, @usuario, @split,  @hush),
('2026-11-15 21:20:00', 'derrota', 14, 16, 3, @usuario, @ascent, @chamber),
('2026-11-16 20:10:00', 'vitoria', 25, 15, 4, @usuario, @ascent, @raze),
('2026-11-17 22:30:00', 'derrota', 15, 16, 5, @usuario, @bind,   @hush),
('2026-10-29 22:15:00', 'vitoria', 27, 16, 4, @usuario, @icebox, @raze),
('2026-11-01 21:40:00', 'derrota', 14, 18, 5, @usuario, @sunset, @chamber),
('2026-11-03 21:05:00', 'vitoria', 26, 17, 7, @usuario, @abyss,  @hush),
('2026-11-06 22:30:00', 'vitoria', 24, 14, 3, @usuario, @icebox, @chamber),
('2026-11-08 18:00:00', 'derrota', 17, 18, 4, @usuario, @sunset, @raze),
('2026-11-10 22:40:00', 'vitoria', 29, 16, 5, @usuario, @abyss,  @raze),
('2026-11-13 22:15:00', 'derrota', 15, 17, 6, @usuario, @icebox, @hush),
('2026-11-15 18:45:00', 'vitoria', 28, 18, 8, @usuario, @sunset, @hush),
('2026-11-17 23:20:00', 'derrota', 16, 17, 3, @usuario, @abyss,  @chamber);