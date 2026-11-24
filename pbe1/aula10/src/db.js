const mysql = require('mysql2');

const con = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '', // Insira sua senha, se houver
    database: 'gestao_residuos'
});

con.connect((err) => {
    if (err) {
        console.error('Erro ao conectar ao banco de dados:', err);
        return;
    }
    console.log('Conectado ao banco de dados gestao_residuos com sucesso!');
});

module.exports = con;