extends Node

var camera
var rotacaoCabeca
var rotacaoPlayer
var Mouse_Sensitivity = 0.05
var peguei_arma :bool
var qtd_arma:int
var numero_arma:int
const ARMAMENTO = {0:"nao_equipado",1:"rifle"}
var municaoNaArma = 30
var municaoReserva = 400
var municaoMaxima = 30
var se_arma_esta_vazia = false
var pegueiLanterna = false
