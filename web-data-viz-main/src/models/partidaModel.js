let database = require("../database/config");

function buscarResumo(idUsuario) {
    let instrucaoSql = `
        SELECT
            COUNT(*) AS totalPartidas,
            SUM(CASE WHEN resultado = 'vitoria' THEN 1 ELSE 0 END) AS vitorias,
            SUM(CASE WHEN resultado = 'derrota' THEN 1 ELSE 0 END) AS derrotas,
            ROUND(AVG((kills + assists) / deaths), 2) AS kdaMedio
        FROM partida
        WHERE fkUsuario = ${idUsuario};
    `;
    return database.executar(instrucaoSql);
}

function buscarAgenteMaisJogado(idUsuario) {
    let instrucaoSql = `
        SELECT a.nome AS agente, COUNT(*) AS partidas
        FROM partida p
        JOIN agente a ON a.idAgente = p.fkAgente
        WHERE p.fkUsuario = ${idUsuario}
        GROUP BY a.nome
        ORDER BY partidas DESC
        LIMIT 1;
    `;
    return database.executar(instrucaoSql);
}

function buscarWinRatePorMapa(idUsuario) {
    let instrucaoSql = `
        SELECT
            m.nome AS mapa,
            ROUND(
                SUM(CASE WHEN p.resultado = 'vitoria' THEN 1 ELSE 0 END)
                / COUNT(*) * 100, 1
            ) AS winRate
        FROM partida p
        JOIN mapa m ON m.idMapa = p.fkMapa
        WHERE p.fkUsuario = ${idUsuario}
        GROUP BY m.nome
        ORDER BY m.nome;
    `;
    return database.executar(instrucaoSql);
}

function buscarDesempenhoPorAgente(idUsuario) {
    let instrucaoSql = `
        SELECT
            a.nome AS agente,
            COUNT(*) AS partidas,
            ROUND(
                SUM(CASE WHEN p.resultado = 'vitoria' THEN 1 ELSE 0 END)
                / COUNT(*) * 100, 1
            ) AS winRate,
            ROUND(AVG((p.kills + p.assists) / p.deaths), 2) AS kda
        FROM partida p
        JOIN agente a ON a.idAgente = p.fkAgente
        WHERE p.fkUsuario = ${idUsuario}
        GROUP BY a.nome
        ORDER BY winRate DESC;
    `;
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarResumo,
    buscarAgenteMaisJogado,
    buscarWinRatePorMapa,
    buscarDesempenhoPorAgente
};
