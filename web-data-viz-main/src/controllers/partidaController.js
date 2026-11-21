let partidaModel = require("../models/partidaModel");

function buscarResumo(req, res) {
    let idUsuario = req.params.idUsuario;

    partidaModel.buscarResumo(idUsuario).then(function (resultado) {
        if (resultado.length > 0) {
            res.json(resultado[0]);
        } else {
            res.json({
                totalPartidas: 0,
                vitorias: 0,
                derrotas: 0,
                kdaMedio: "0.00"
            });
        }
    }).catch(function (erro) {
        console.log(erro);
        res.status(500).json(erro.sqlMessage);
    });
}

function buscarAgenteMaisJogado(req, res) {
    let idUsuario = req.params.idUsuario;

    partidaModel.buscarAgenteMaisJogado(idUsuario).then(function (resultado) {
        res.json(resultado);
    }).catch(function (erro) {
        console.log(erro);
        res.status(500).json(erro.sqlMessage);
    });
}

function buscarWinRatePorMapa(req, res) {
    let idUsuario = req.params.idUsuario;

    partidaModel.buscarWinRatePorMapa(idUsuario).then(function (resultado) {
        res.json(resultado);
    }).catch(function (erro) {
        console.log(erro);
        res.status(500).json(erro.sqlMessage);
    });
}

function buscarDesempenhoPorAgente(req, res) {
    let idUsuario = req.params.idUsuario;

    partidaModel.buscarDesempenhoPorAgente(idUsuario).then(function (resultado) {
        res.json(resultado);
    }).catch(function (erro) {
        console.log(erro);
        res.status(500).json(erro.sqlMessage);
    });
}

function listarMapas(req, res) {
    partidaModel.listarMapas().then(function (resultado) {
        res.json(resultado);
    }).catch(function (erro) {
        console.log(erro);
        res.status(500).json(erro.sqlMessage);
    });
}

function listarAgentes(req, res) {
    partidaModel.listarAgentes().then(function (resultado) {
        res.json(resultado);
    }).catch(function (erro) {
        console.log(erro);
        res.status(500).json(erro.sqlMessage);
    });
}

function cadastrar(req, res) {
    let idUsuario = req.body.idUsuarioServer;
    let fkMapa = req.body.fkMapaServer;
    let fkAgente = req.body.fkAgenteServer;
    let resultado = req.body.resultadoServer;
    let kills = req.body.killsServer;
    let deaths = req.body.deathsServer;
    let assists = req.body.assistsServer;

    if (idUsuario == undefined) {
        res.status(400).send("Seu idUsuario está undefined!");
    } else if (fkMapa == undefined) {
        res.status(400).send("Seu fkMapa está undefined!");
    } else if (fkAgente == undefined) {
        res.status(400).send("Seu fkAgente está undefined!");
    } else if (resultado == undefined) {
        res.status(400).send("Seu resultado está undefined!");
    } else if (kills == undefined) {
        res.status(400).send("Suas kills estão undefined!");
    } else if (deaths == undefined) {
        res.status(400).send("Suas deaths estão undefined!");
    } else if (assists == undefined) {
        res.status(400).send("Suas assists estão undefined!");
    } else {
        partidaModel.cadastrar(idUsuario, fkMapa, fkAgente, resultado, kills, deaths, assists)
            .then(function (resultadoBanco) {
                res.status(201).json(resultadoBanco);
            }).catch(function (erro) {
                console.log(erro);
                res.status(500).json(erro.sqlMessage);
            });
    }
}

module.exports = {
    buscarResumo,
    buscarAgenteMaisJogado,
    buscarWinRatePorMapa,
    buscarDesempenhoPorAgente,
    listarMapas,
    listarAgentes,
    cadastrar
};
