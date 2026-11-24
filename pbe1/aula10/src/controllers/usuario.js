const con = require('../db');

const cadastrar = (req, res) => {
    const { nome, email, senha } = req.body;
    const sql = 'INSERT INTO usuario (nome, email, senha) VALUES (?, ?, password(?));';
    
    con.query(sql, [nome, email, senha], (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Erro ao cadastrar usuário', msg: err.sqlMessage });
        }
        res.status(201).json({ message: 'Usuário cadastrado com sucesso', id: results.insertId });
    });
};

const listar = (req, res) => {
    const sql = 'SELECT id, nome, email FROM usuario;';
    con.query(sql, (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Erro ao listar usuários' });
        }
        res.json(results);
    });
};

const alterar = (req, res) => {
    const id = Number(req.params.id);
    const { nome, email } = req.body;
    const sql = 'UPDATE usuario SET nome = ?, email = ? WHERE id = ?;';
    
    con.query(sql, [nome, email, id], (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Erro ao alterar usuário' });
        }
        if (results.affectedRows === 1) {
            res.json({ message: 'Usuário alterado com sucesso' });
        } else {
            res.status(404).json({ message: 'Usuário não encontrado' });
        }
    });
};

const excluir = (req, res) => {
    const id = Number(req.params.id);
    const sql = 'DELETE FROM usuario WHERE id = ?;';
    
    con.query(sql, [id], (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Erro ao excluir usuário' });
        }
        if (results.affectedRows === 1) {
            res.json({ message: 'Usuário excluído com sucesso' });
        } else {
            res.status(404).json({ message: 'Usuário não encontrado' });
        }
    });
};

const login = (req, res) => {
    const { email, senha } = req.body;
    const sql = 'SELECT id, nome, email FROM usuario WHERE email = ? AND senha = password(?);';
    
    con.query(sql, [email, senha], (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Erro no servidor durante o login' });
        }
        if (results.length > 0) {
            res.json({ message: 'Login realizado com sucesso', usuario: results[0] });
        } else {
            res.status(401).json({ error: 'E-mail ou senha inválidos' });
        }
    });
};

module.exports = { cadastrar, listar, alterar, excluir, login };