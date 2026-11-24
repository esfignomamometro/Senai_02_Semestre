const express = require('express');
const router = express.Router();

const Usuario = require('./controllers/usuario');
const Ocorrencia = require('./controllers/ocorrencia');

router.get('/', (req, res) => {
    res.json("Back-end Gestão de Resíduos Sólidos respondendo");
});


router.post('/usuarios', Usuario.cadastrar);
router.get('/usuarios', Usuario.listar);
router.put('/usuarios/:id', Usuario.alterar);
router.delete('/usuarios/:id', Usuario.excluir);
router.post('/usuarios/login', Usuario.login);


router.post('/ocorrencias', Ocorrencia.cadastrar);
router.get('/ocorrencias', Ocorrencia.listar);
router.put('/ocorrencias/:id', Ocorrencia.alterar);
router.delete('/ocorrencias/:id', Ocorrencia.excluir);
router.get('/ocorrencias/resumo', Ocorrencia.resumo);

module.exports = router;