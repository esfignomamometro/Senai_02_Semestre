const express = require("express")
const router = express.Router()

const Usuario = require("./controllers/usuário")

const rotaInicial = (req, res) => {
    res.json("Back-end Eventos Climáticos respondendo")
}

router.get('/', rotaInicial)
router.post('/usuarios', Usuario.cadastrar)
router.get('/usuarios', Usuario.listar)

module.exports = router