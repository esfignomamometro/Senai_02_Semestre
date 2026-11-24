const express = require('express');
const cors = require('cors');
const routes = require('./src/routes');

const app = express();
app.use(express.json());
app.use(cors());


app.post('/teste', (req, res) => {
    res.json({ mensagem: "A rota de teste está a funcionar!" });
});

app.use(routes);

app.listen(3000, () => {
    console.log('Servidor respondendo em: http://localhost:3000');
});