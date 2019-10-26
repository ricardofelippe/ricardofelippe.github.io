# Cubos OLAP e Solução de BI com Linguagem R

# Instala o pacote data.cube
install.packages("data.cube", repos = paste0("https://", c("jangorecki.gitlab.io/data.cube", "cloud.r-project.org")))

# Instala o pacote data.table
install.packages("data.table")

# Instala o pacote rpivotTable
install.packages("rpivotTable")

# Carregando pacotes na sessão
library(data.table)
library(data.cube)
library(rpivotTable)

##### Criando um array com a massa de dados ##### 

# Definindo o nome das dimensões
# Produto: representa o tipo de produto
# Ano: representa o ano em que os dados foram coletados
# Status: representa o status de cada tipo de produto
nomes_dimensoes = list(produto = sort(c("TV", "Geladeira", "Laptop", "Smartphone")), 
                       ano = as.character(2015:2019), 
                       status = sort(c("Em Estoque", "Em Preparação Para Entrega", "Em Transporte", "Devolvido")))

# Definindo o comprimento das dimensões
comprimento_dimensoes = sapply(nomes_dimensoes, length)

# Criando o array com alguns dados aleatórios usando a função sample()
# Incluímos alguns valores NA (Not Available) para deixar as coisas mais emocionantes!
set.seed(142)
df_produtos = array(sample(c(rep(NA, 5), 15:190/2), prod(comprimento_dimensoes), TRUE), 
                    unname(comprimento_dimensoes),
                    nomes_dimensoes)

# Visualizando os dados
View(df_produtos)


##### Criando o Cubo ##### 

# Cria o cubo a partir do array anterior
?as.cube
cubo_prod = as.cube(df_produtos)

# Veja que agora temos um objeto do tipo cubo
class(cubo_prod)

# Imprimindo o cubo
# Observe que temos dimensões e fatos
print(cubo_prod)

# Observe agora os tipos de dados
# Cada dimensão é tratada como um data.table, o que nos permite fazer diversas operações com os dados
str(cubo_prod)

# Usando a função all.equal() podemos comparar o array com o cubo
# As dimensões são as mesmas, mas com o objeto do tipo cubo teremos diversas opções de operações OLAP
all.equal(dim(df_produtos), dim(cubo_prod))
all.equal(dimnames(df_produtos), dimnames(cubo_prod))


##### Operações OLAP ##### 


# Slice (Fatiamento dos Dados)

# Cria uma fatia
fatia1 = cubo_prod["TV",]
print(fatia1)
as.data.table(fatia1)

# Mostra a dimensão (por isso drop=FALSE)
fatia2 = cubo_prod["TV",,,drop=FALSE]
print(fatia2)
as.data.table(fatia2)

# Cria uma fatia usando duas dimensões
fatia3 = cubo_prod["TV",,"Em Estoque"]
print(fatia3)
as.data.table(fatia3)

# Cria uma fatia com os totais de TV em estoque no ano de 2016
fatia4 = cubo_prod["TV", 2016,"Em Estoque"]
print(fatia4)
as.data.table(fatia4)


# Dice (divisão das "fatias" em porções ainda menores)

dice1 = cubo_prod["TV",, c("Em Estoque", "Em Preparação Para Entrega", "Em Transporte")]
print(dice1)
as.data.table(dice1)
as.data.table(dice1, na.fill = TRUE)

dice2 = cubo_prod["TV", c(2016, 2017), c("Em Estoque", "Em Preparação Para Entrega", "Em Transporte")]
print(dice2)
as.data.table(dice2)


# Roll-up e Drilldown

# A função capply faz agregação dos dados
?capply
format(capply(cubo_prod, c("produto", "ano"), sum))

# Roll-up (Agregação)
?rollup
roll1 = rollup(cubo_prod, MARGIN = c("produto", "ano"), FUN = sum)
format(roll1)

roll2 = rollup(cubo_prod, MARGIN = c("ano", "status"), FUN = mean)
format(roll2)

# DrillDown (Detalhamento)
roll3 = rollup(cubo_prod, MARGIN = c("ano","status"), INDEX = 1:1, FUN = sum)
format(roll3)

# Pivot
roll4 = capply(cubo_prod, c("ano","produto"), sum)
format(roll4, dcast = TRUE, formula = ano ~ produto)

# Interface gráfica
library(rpivotTable)
roll5 = rollup(cubo_prod, c("ano", "status"), FUN = sum, normalize = FALSE)
?rpivotTable
rpivotTable(Titanic)
rpivotTable(roll5, rows = "ano", cols = c("status"), width = "150%", height = "500px")

# Selecione Average e então Value
# Escolha o gráfico e tipo de estatística desejados




