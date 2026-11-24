const tipoPessoa = document.querySelector("#tipoPessoa")
const nome = document.querySelector("#nome")
const email = document.querySelector("#email")
const campoEspecifico = document.querySelector("#campoEspecifico")
const salvar = document.querySelector("#salvar")

const tabelaAlunos = document.querySelector("#tabelaAlunos")
const tabelaProfessores = document.querySelector("#tabelaProfessores")

tipoPessoa.addEventListener("change", function(){
    if (tipoPessoa.value === "1") {
        campoEspecifico.placeholder = "Matrícula"
    } else if (tipoPessoa.value === "2") {
        campoEspecifico.placeholder = "Disciplina"
    }
})

salvar.addEventListener("click", function(){
    const linha = document.createElement('tr')
    const colunaNome = document.createElement('td')
    const colunaEmail = document.createElement('td')
    const colunaEspecifico = document.createElement('td')

    colunaNome.textContent = nome.value
    colunaEmail.textContent = email.value
    colunaEspecifico.textContent = campoEspecifico.value

    linha.append(colunaNome)
    linha.append(colunaEmail)
    linha.append(colunaEspecifico)

    if (tipoPessoa.value === "1") {
        tabelaAlunos.append(linha)
    } else if (tipoPessoa.value === "2") {
        tabelaProfessores.append(linha)
    }

    nome.value = ""
    email.value = ""
    campoEspecifico.value = ""
})