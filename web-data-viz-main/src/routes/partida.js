let express = require("express");
let router = express.Router();

let partidaController = require("../controllers/partidaController");

router.get("/resumo/:idUsuario", function (req, res) {
    partidaController.buscarResumo(req, res);
});

router.get("/agenteMaisJogado/:idUsuario", function (req, res) {
    partidaController.buscarAgenteMaisJogado(req, res);
});

router.get("/desempenhoPorAgente/:idUsuario", function (req, res) {
    partidaController.buscarDesempenhoPorAgente(req, res);
});

router.get("/winRatePorMapa/:idUsuario", function (req, res) {
    partidaController.buscarWinRatePorMapa(req, res);
});

router.get("/mapas", function (req, res) {
    partidaController.listarMapas(req, res);
});

router.get("/agentes", function (req, res) {
    partidaController.listarAgentes(req, res);
});

router.post("/cadastrar", function (req, res) {
    partidaController.cadastrar(req, res);
});

module.exports = router;