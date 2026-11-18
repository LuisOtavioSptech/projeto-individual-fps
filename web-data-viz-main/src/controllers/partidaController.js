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

module.exports = {
    buscarResumo,
    buscarAgenteMaisJogado,
    buscarWinRatePorMapa,
    buscarDesempenhoPorAgente
};
