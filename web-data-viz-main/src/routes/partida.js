var express = require("express");
var router = express.Router();

var partidaController = require("../controllers/partidaController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.get("/resumo/:idUsuario", function (req, res) {
    partidaController.buscarResumo(req, res);
})

router.get("/agenteMaisJogado/:idUsuario", function (req, res) {
    partidaController.buscarAgenteMaisJogado(req, res);
})

router.get("/desempenhoPorAgente/:idUsuario", function (req, res) {
    partidaController.buscarDesempenhoPorAgente(req, res);
})

router.get("/winRatePorMapa/:idUsuario", function (req, res) {
    partidaController.buscarWinRatePorMapa(req, res);
})

module.exports = router;