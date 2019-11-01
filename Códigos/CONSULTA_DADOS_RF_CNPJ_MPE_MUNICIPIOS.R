# Consulta dados P?blicos CNPJ- Receita Federal
# Fonte: https://receita.economia.gov.br/orientacao/tributaria/cadastros/cadastro-nacional-de-pessoas-juridicas-cnpj/dados-publicos-cnpj

# Log Atualizações:
# 11/07/19 : Base disponibilizada em múltiplos arquivos zip. Salvo em uma pasta e realizado conversão para SQLITE usando o prompt de comandos via Python. 

# Bibliotecas necessárias
library(RSQLite)
library(dplyr)



# Criando driver e conexão ao banco de dados
drv = dbDriver("SQLite")

#========== Acessando base de dados Completa CNPJ_full.db (Base de dados 01 a 10) ===================

# Criando/acessando o banco de dados AllData, para consolidar os dados
# Configurando o diretório de trabalho
#pasta<-paste("C:/Users/ricardo.ramos/OneDrive - Ministerio do Desenvolvimento da Industria e Comercio Exterior/R-projects/DAMPE-SEMPE/DadosPublicosCnpj/Python/CNPJ-full/data",sep="")

pastaC<-"C:/BigData/CNPJ/BigData01_10"

setwd(pastaC)
getwd()

conFull = dbConnect(drv, dbname = "CNPJ_full.db")
dbListTables(conFull)


#dbDisconnect(con2)

# Consulta simples dos dados 

# query = "select cnpj,opc_simples,porte,opc_mei,cnae_fiscal,email,tipo_logradouro,logradouro,numero,
# complemento,bairro,cep,uf,ddd_1,telefone_1,ddd_2,telefone_2 from empresas where opc_simples = 05"
# 
# query2 = "select cnpj,opc_simples,porte,opc_mei,cnae_fiscal,email,tipo_logradouro,logradouro,numero,
# complemento,bairro,cep,uf from empresas"

# query3 = "select cnpj,opc_simples,porte,opc_mei,cnae_fiscal,logradouro,numero,
# bairro,cep,uf,cod_municipio,municipio,ddd_1,telefone_1,ddd_2,telefone_2,email,qualif_resp from empresas"

query3 = "select cnpj,opc_simples,porte,opc_mei,logradouro,numero,
cep,uf,cod_municipio,municipio,ddd_1,telefone_1,email,qualif_resp from empresas"



#query = "select * from empresas "
# Consultando os dados e criando o dataframe
rs = dbSendQuery(conFull, query3)
dados = fetch(rs, n = -1)

dbDisconnect(conFull)

# MEI_dados011a10<-dados %>% filter(email !="",opc_mei=="S",)
# # 
# Simplesdados01a10<-dados %>% filter(email !="",opc_simples=="5" | opc_simples=="7")

#MPE_Simplesdados01a10<-dados %>% filter(porte=="01" | porte=="03",email !="",opc_simples=="5" | opc_simples=="7")

MPE_Municipios_Simplesdados01a10_opc5<-dados %>% filter(porte=="01" | porte=="03",email !="",opc_simples=="5" )

#wck=paste("MPE_Simples_cod_05_Dados01a10",".csv",sep="")

#write.csv(MPE_Simplesdados01a10_opc5, file=wck)

MPE_Municipios_Simplesdados01a10_opc7<-dados %>% filter(porte=="01" | porte=="03",email !="",opc_simples=="7" )


#wck=paste("MPE_Simples_cod_07_Dados01a10",".csv",sep="")

#write.csv(MPE_Simplesdados01a10_opc7, file=wck)


# dadosFull é concebido somente para consultas locais no R, devido ao tamanho do arquivo.
dadosFull<-data.frame()
dadosFull<-rbind(dadosFull, MPE_Municipios_Simplesdados01a10_opc5,MPE_Municipios_Simplesdados01a10_opc7)


rm(dados)

dadosFull<-rbind(dadosFull, MPE_Municipios_Simplesdados01a10_opc5,MPE_Municipios_Simplesdados01a10_opc7)

# granfpolisMunicipios<-c("AGUAS MORNAS","ALFREDO WAGNER","ANGELINA","ANITAPOLIS","ANTONIO CARLOS","BIGUACU","CANELINHA","FLORIANOPOLIS","GAROPABA","GOVERNADOR CELSO RAMOS","LEOBERTO LEAL","MAJOR GERCINO","NOVA TRENTO","PALHOCA","PAULO LOPES","RANCHO QUEIMADO","SANTO AMARO DA IMPERATRIZ","SAO BONIFACIO","SAO JOAO BATISTA","SAO JOSE","SAO PEDRO DE ALCANTARA","TIJUCAS")
# dados_Filtrados<-dadosFull %>% filter(municipio %in% granfpolisMunicipios)


# Demanda EDIVAN 31/10/19
RMC<-toupper(c("Curitiba","Almirante Tamandare","Araucaria","Balsa Nova","Bocaiuva do Sul","Campina Grande do Sul","Campo Largo","Colombo","Contenda","Mandirituba","Piraquara"))

RMC_dados_Filtrados<-dadosFull %>% filter(municipio %in% RMC)



pastaC<-"C:/BigData/CNPJ/Extração_Curitiba_RMC"

setwd(pastaC)
getwd()


#wck=paste("GRANFPOLIS",".csv",sep="")
wck=paste("RMC_PARTE_1",".csv",sep="")


write.csv(RMC_dados_Filtrados, file=wck)




# head(dados01a10)

# pastaC<-"C:/BigData/CNPJ/Extracao_Municipios_Set2019"
# 
# setwd(pastaC)
# getwd()
# 
# 
# 
# wck=paste("MPE_Municipios_Simples_cod_05_Dados01a10",".csv",sep="")
# 
# write.csv(MPE_Municipios_Simplesdados01a10_opc5, file=wck)
# 
# 
# wck=paste("MPE_Municipios_Simplesdados01a10_opc7",".csv",sep="")
# 
# write.csv(MPE_Municipios_Simplesdados01a10_opc7, file=wck)



# dadosAgrupados <-MEI_dados011a10%>% group_by(cnae_fiscal) %>% 
#   summarize(n=n())





# wck=paste("MPE","-","BASE_DADOS_01_10",".csv",sep="")
# 
# write.csv(dados, file=wck)

#========== Acessando base de dados Completa CNPJ_full.db (Base de dados 11 a 20) ===================

pastaC<-"C:/BigData/CNPJ/BigData11_20"

#pastaC<-"C:/BigData"

setwd(pastaC)
getwd()

conFull = dbConnect(drv, dbname = "CNPJ_full.db")
dbListTables(conFull)


#dbDisconnect(con2)

# Consulta simples dos dados 

# query = "select cnpj,opc_simples,porte,opc_mei,cnae_fiscal,email,tipo_logradouro,logradouro,numero,
# complemento,bairro,cep,uf,ddd_1,telefone_1,ddd_2,telefone_2 from empresas where opc_simples = 05"
# 
# query2 = "select cnpj,opc_simples,porte,opc_mei,cnae_fiscal,email,tipo_logradouro,logradouro,numero,
# complemento,bairro,cep,uf from empresas"


# query3 = "select cnpj,opc_simples,porte,opc_mei,cnae_fiscal,email,logradouro,numero,
# bairro,cep,uf from empresas"

query3 = "select cnpj,opc_simples,porte,opc_mei,logradouro,numero,
cep,uf,cod_municipio,municipio,ddd_1,telefone_1,email,qualif_resp from empresas"




#query = "select * from empresas "
# Consultando os dados e criando o dataframe
rs = dbSendQuery(conFull, query3)
dados2 = fetch(rs, n = -1)

dbDisconnect(conFull)

# dados11a20<-dados %>% filter(email !="",porte=="05",)
# 
# MEI_dados11a20<-dados %>% filter(email !="",opc_mei=="S",)

# 
# Simplesdados11a20<-dados2 %>% filter(email !="",opc_simples=="5" | opc_simples=="7")
# 
# 
# #dadosFull<-rbind(dados, dados2)
# 
# Simples_dadosFull<-rbind(Simplesdados01a10, Simplesdados11a20)

#MPE_Simplesdados11a20<-dados2 %>% filter(porte=="01" | porte=="03",email !="",opc_simples=="5" | opc_simples=="7")

MPE_Simplesdados11a20_opc5<-dados2 %>% filter(porte=="01" | porte=="03",email !="",opc_simples=="5" )

# wck=paste("MPE_Simples_cod_05_Dados11a20",".csv",sep="")
# 
# write.csv(MPE_Simplesdados11a20_opc5, file=wck)

MPE_Simplesdados11a20_opc7<-dados2 %>% filter(porte=="01" | porte=="03",email !="",opc_simples=="7" )

# wck=paste("MPE_Simples_cod_07_Dados11a20",".csv",sep="")
# 
# write.csv(MPE_Simplesdados11a20_opc7, file=wck)


# emailValidos<-dadosFull %>% filter(email !="",)

# wck=paste("MPE_Simples_cod_05_07_Dados01a10",".csv",sep="")
# 
# write.csv(MPE_Simplesdados11a20, file=wck)


# dadosFull é concebido somente para consultas locais no R, devido ao tamanho do arquivo.
dadosFull<-rbind(dadosFull, MPE_Simplesdados11a20_opc5,MPE_Simplesdados11a20_opc7)

rm(dados)


# granfpolisMunicipios<-c("AGUAS MORNAS","ALFREDO WAGNER","ANGELINA","ANITAPOLIS","ANTONIO CARLOS","BIGUACU","CANELINHA","FLORIANOPOLIS","GAROPABA","GOVERNADOR CELSO RAMOS","LEOBERTO LEAL","MAJOR GERCINO","NOVA TRENTO","PALHOCA","PAULO LOPES","RANCHO QUEIMADO","SANTO AMARO DA IMPERATRIZ","SAO BONIFACIO","SAO JOAO BATISTA","SAO JOSE","SAO PEDRO DE ALCANTARA","TIJUCAS")
# dados_Filtrados<-dadosFull %>% filter(municipio %in% granfpolisMunicipios)

# Demanda EDIVAN 31/10/19
RMC<-toupper(c("Curitiba","Almirante Tamandare","Araucaria","Balsa Nova","Bocaiuva do Sul","Campina Grande do Sul","Campo Largo","Colombo","Contenda","Mandirituba","Piraquara"))


# 
# pastaC<-"C:/BigData/CNPJ/Extracao_Municipios_Set2019"
# setwd(pastaC)
# getwd()
#  wck=paste("GRANFPOLIS_2",".csv",sep="")
#  write.csv(dados_Filtrados, file=wck)

 
 RMC<-toupper(c("Curitiba","Almirante Tamandare","Araucaria","Balsa Nova","Bocaiuva do Sul","Campina Grande do Sul","Campo Largo","Colombo","Contenda","Mandirituba","Piraquara"))
 
 RMC_dados_Filtrados<-dadosFull %>% filter(municipio %in% RMC)
 
 
 
 pastaC<-"C:/BigData/CNPJ/Extração_Curitiba_RMC"
 
 setwd(pastaC)
 getwd()
 
 
 #wck=paste("GRANFPOLIS",".csv",sep="")
 wck=paste("RMC_PARTE_2",".csv",sep="")
 
 
 write.csv(RMC_dados_Filtrados, file=wck)
 
 
 
 
  
 
# wck=paste("MPE_Simples_cod_05_Dados11a20",".csv",sep="")
# 
# write.csv(MPE_Simplesdados11a20_opc5, file=wck)
# 
# 
# wck=paste("MPE_Simples_cod_07_Dados11a20",".csv",sep="")
# 
# write.csv(MPE_Simplesdados11a20_opc7, file=wck)
# 
# 
# # dadosFull é concebido somente para consultas locais no R, devido ao tamanho do arquivo.
# dadosFull<-rbind(dadosFull, MPE_Simplesdados11a20_opc5,MPE_Simplesdados11a20_opc7)


# wck=paste("Simples_cod_05_07",".csv",sep="")
# 
# write.csv(emailValidos, file=wck)


#==================Validação de dados========================

basedados<-dadosFull


cnae_9700500 <-basedados  %>%  filter(cnae_fiscal=="9700500") %>% 
  summarize(n=n())


email_CNAE9700500 <-basedados  %>%  filter(cnae_fiscal=="9700500")



cnae_9311500 <-basedados  %>%  filter(cnae_fiscal=="9311500") %>% 
  summarize(n=n())

cnae_56611202 <-basedados  %>%  filter(cnae_fiscal=="5611202") %>% 
  summarize(n=n())


cnae_0116402 <-basedados  %>%  filter(cnae_fiscal=="0116402") %>% 
  summarize(n=n())  # Resultado esperadod: 01 

cnae_0111303 <-basedados  %>%  filter(cnae_fiscal=="0111303") %>% 
  summarize(n=n())  # Resultado esperadod: 02 


cnae_4781400 <-basedados  %>%  filter(cnae_fiscal=="4781400") %>% 
  summarize(n=n())  # Resultado esperadod: 914716
 

cnae<-dadosFull %>% group_by(cnae_fiscal) %>% summarize(n=n())

wck=paste("CNAE","-","AGRUPADA",".csv",sep="")

write.csv(cnae,file=wck)


# ********************* COMANDOS AUXILIARES *********************
# Remover o banco SQLite, caso exista - Não é obrigatório
#system("del AllData.db") # --> no Windows
# system("rm exemplo.db")    # --> no Mac e Linux


# Copiando somente a estrutura do dataset e suas colunas, sem os dados.
dbWriteTable(conFull, "empresas", empresas[0, ], row.names = TRUE)

# Este comando copia somente a estrutura do dataset mtcars e suas colunas, sem os dados
dbWriteTable(con, "mtcars2", mtcars[0, ], row.names = TRUE)

# Listando uma tabela
dbListTables(con)
dbExistsTable(con,"mtcars")
dbExistsTable(con,"mtcars2")
dbListFields(con,"mtcars")

# Lendo o conteúdo da tabela
dbReadTable(con, "mtcars")

# Criando uma tabela e carregando com dados do dataset mtcars
dbWriteTable(con, "empresas","empresas.csv", sep=",",header=T)
dbWriteTable(con, "Emprego_Caged_Nov2018","Monitoramento_Emprego_Nov18.csv",sep=";",header=T)

# Desconectando 
dbDisconnect(con)

# Acessando a tabela empresas do banco de dados

empresas<-dbReadTable(conFull,"empresas")

# Consultando uma tabela espec??fica do banco de dados
year_1988_2015 <- dbReadTable(con2015, 'year_1988_2015')


# Cancluate Total trade amount per country
year_1988_2015 %>% group_by(Country) %>% 
  summarize(total_vy = sum(VY))

# Cancluate Total trade amount per country
year_1988_2015 %>% group_by(Country) %>% 
  summarize(total_vy = sum(VY))


head(dados11a20)


wck=paste("MPE","-","BASE_DADOS_11_20",".csv",sep="")



# Validação de totais

cnae<-dados %>% group_by(cnae_fiscal) %>% summarize(total = sum(VY))

cnae<-dados %>% group_by(cnae_fiscal) %%> summarize(n=n())



# Codigo para calcular top 10
year_1988_2015 %>% group_by(Year, Country) %>% 
  summarize(total_vy = sum(VY)) %>%
  top_n(10, total_vy)







summary(dados1)

dadosFull<-rbind(dados01a10,dados11a20)
dadosFull<-rbind(dados, dados2)

wck=paste("Base11_20",".csv",sep="")

write.csv(dados2, file=wck)



# ********************* FIM COMANDOS ÚTEIS *********************




# Criando uma tabela e carregando com dados do dataset mtcars
dbWriteTable(con, "empresas","empresas.csv", sep=",",header=T)
dbWriteTable(con, "Emprego_Caged_Nov2018","Monitoramento_Emprego_Nov18.csv",sep=";",header=T)

dbWriteTable(con, "iris", "iris.csv", sep = ",", header = T)

dbRemoveTable(con, "empresas")


dbWriteTable(con, "resul_radial_2","resul_radial_2.csv", row.names = TRUE)
dbWriteTable(con, "iris", "iris.csv", sep = ",", header = T)

dbReadTable(con, "Emprego_Caged_Nov2018")
# Executando consultas no banco de dados

query2 = "select email,porte from empresas where opc_simples = 05"

query = "select Faixa_Empr_Inicio_Jan from Emprego_Caged_NOv2018"
query2 = "select Faixa_Empr_Inicio_Jan,Setor, Movimentação from Emprego_Caged_NOv2018 where Movimentação = -8.634"
query3 = "select Faixa_Empr_Inicio_Jan,Setor, Movimentação from Emprego_Caged_NOv2018 where Movimentação = -4.086"
query4 = "select Faixa_Empr_Inicio_Jan,Setor, Movimentação from Emprego_Caged_NOv2018 where Movimentação = -915"

rs = dbSendQuery(con, query2)
dados = fetch(rs, n = -1)
dados
class(dados)

# Executando consultas no banco de dados
query = "select id,classe from resul_radial_2 where classe = 1"
rs = dbSendQuery(con, query)
dados = fetch(rs, n = -1)
dados





# Listando uma tabela
dbListTables(con)
dbExistsTable(con,"mtcars")
dbExistsTable(con,"mtcars2")
dbListFields(con,"mtcars")

# Lendo o conteúdo da tabela
dbReadTable(con, "mtcars")

# Criando apenas a definição da tabela.
# Este comando copia somente a estrutura do dataset mtcars e suas colunas, sem os dados
dbWriteTable(con, "mtcars2", mtcars[0, ], row.names = TRUE)
dbListTables(con)
dbReadTable(con, "mtcars2")

# Executando consultas no banco de dados
query = "select row_names from mtcars"
rs = dbSendQuery(con, query)
dados = fetch(rs, n = -1)
dados
class(dados)

# Executando consultas no banco de dados
query = "select row_names from mtcars"
rs = dbSendQuery(con, query)
while (!dbHasCompleted(rs))
{
  dados = fetch(rs, n = 1)
  print(dados$row_names)
}

# Executando consultas no banco de dados
query = "select disp, hp from mtcars where disp > 160"
rs = dbSendQuery(con, query)
dados = fetch(rs, n = -1)
dados

# Executando consultas no banco de dados
query = "select row_names, avg(hp) from mtcars group by row_names"
rs = dbSendQuery(con, query)
dados = fetch(rs, n = -1)
dados

# Criando uma tabela a partir de um arquivo
dbWriteTable(con, "iris", "iris.csv", sep = ",", header = T)
dbListTables(con)
dbReadTable(con, "iris")

# Encerrando a conexão
dbDisconnect(con)

# Carregando dados no banco de dados
# http://dados.gov.br/dataset/indice-nacional-de-precos-ao-consumidor-amplo-15-ipca-15
# Criando driver e conexão ao banco de dados
drv = dbDriver("SQLite")
con = dbConnect(drv, dbname = "exemplo.db")

dbWriteTable(con,"indices", "Telco-Customer-Churn.csv",
             sep = "|", header = T)

dbRemoveTable(con, "indices")

dbWriteTable(con,"indices", "Telco-Customer-Churn.csv",
             sep = "|", header = T)

dbListTables(con)
dbReadTable(con, "indices")

df <- dbReadTable(con, "indices")
df
str(df)
sapply(df, class)

hist(df$setembro)
df_mean <- unlist(lapply(df[, c(4, 5, 6, 7, 8)], mean))
df_mean








