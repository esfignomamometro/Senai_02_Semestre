const con = require('../db');

const cadastrar = (req, res) => {
    const { usuarioId, local, tipoResiduo, nivelRisco, status } = req.body;
    const sql = 'INSERT INTO ocorrencia (usuarioId, local, tipoResiduo, nivelRisco, status) VALUES (?, ?, ?, ?, ?)';
    
    con.query(sql, [usuarioId, local, tipoResiduo, nivelRisco || 'Medio', status || 'Novo'], (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Erro ao cadastrar ocorrência', msg: err.sqlMessage });
        }
        res.status(201).json({ message: 'Ocorrência cadastrada com sucesso', id: results.insertId });
    });
};

const listar = (req, res) => {
    const sql = `
        SELECT o.id, o.local, o.tipoResiduo, o.nivelRisco, o.data, o.status, 
               u.id as usuarioId, u.nome as usuarioNome 
        FROM ocorrencia o 
        JOIN usuario u ON o.usuarioId = u.id;
    `;
    con.query(sql, (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Erro ao listar ocorrências' });
        }
        res.json(results);
    });
};

const alterar = (req, res) => {
    const id = Number(req.params.id);
    const { local, tipoResiduo, nivelRisco, status } = req.body;
    const sql = 'UPDATE ocorrencia SET local = ?, tipoResiduo = ?, nivelRisco = ?, status = ? WHERE id = ?;';
    
    con.query(sql, [local, tipoResiduo, nivelRisco, status, id], (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Erro ao alterar ocorrência' });
        }
        if (results.affectedRows === 1) {
            res.json({ message: 'Ocorrência alterada com sucesso' });
        } else {
            res.status(404).json({ message: 'Ocorrência não encontrada' });
        }
    });
};

const excluir = (req, res) => {
    const id = Number(req.params.id);
    const sql = 'DELETE FROM ocorrencia WHERE id = ?;';
    
    con.query(sql, [id], (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Erro ao excluir ocorrência' });
        }
        if (results.affectedRows === 1) {
            res.json({ message: 'Ocorrência excluída com sucesso' });
        } else {
            res.status(404).json({ message: 'Ocorrência não encontrada' });
        }
    });
};

const resumo = (req, res) => {
    const sqlTratados = "SELECT COUNT(*) as totalTratados FROM ocorrencia WHERE status = 'Tratado';";
    const sqlGeral = "SELECT * FROM ocorrencia;";

    con.query(sqlTratados, (err, resTratados) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Erro ao gerar resumo' });
        }
        con.query(sqlGeral, (err, resGeral) => {
            if (err) {
                console.error(err);
                return res.status(500).json({ error: 'Erro ao buscar ocorrências' });
            }
            res.json({
                totalTratados: resTratados[0].totalTratados,
                ocorrencias: resGeral
            });
        });
    });
};

module.exports = { cadastrar, listar, alterar, excluir, resumo };