Attribute VB_Name = "CAGED_BI_MACRO_PASSO_1"
Function ContainsText(Rng As Range, Text As String) As String
    'Rng —The range in which to search.
    'Text —The text for which to search.
    Dim T As String
    Dim myCell As Range
    For Each myCell In Rng 'look in each cell
        If InStr(myCell.Text, Text) > 0 Then 'look in the string for the text
            If Len(T) = 0 Then 'if the text is found,add the address to my result
                T = myCell.Address(False, False)
            Else
                T = T & "," & myCell.Address(False, False)
            End If
        End If
    Next myCell
    ContainsText = T
End Function

'====== Potenciais Melhorias identificadas ==========
'1)Inserir em uma mesma coluna o nome dos arquivos DP e FP que serão editados. A identificação DP E FP se dará pelo nome e subsidiariamente por cor. Verde para DP e roxo para FP
' 2) Simplificar caminho para salvar os arquivos extraídos do caged.
'
'
'
'
'==================REFORMANTANDO PASSSO A PASSO==============

Sub GerenciaEdicoes()
' Melhorias identificadas
' 1) EDITAR TODAS AS PLANILHAS DP
' 2) SALVAR NA PASTA EDITADAS
Dim planilha As String
Dim planilhaDaVez As String
Dim TIPO As String
Dim PASTA_DESTINO As String
Dim NomePlanilha As String


Set wkc_controle = Workbooks("Informações_DAMPE.xlsm").Sheets(3)  ' ATUALIZARRRRR
wkc_controle.Select


'CONSTANTES
'PASTA_GERAL = "C:\Users\ricardo.ramos\OneDrive - Ministerio do Desenvolvimento da Industria e Comercio Exterior\R-projects\DAMPE-SEMPE\Dados"
'PASTA_GERAL

' Econtra a qtdde de planilhas a editar
finalrow = Range("a2000").End(xlUp).Row

'EDITANDO DP e FP
MsgBox ("LEMBRAR DE CONVERTER OS ARQUIVOS NA EXTENSÃO .xlsx")
 
For i = 7 To finalrow
 planilha = Range("a" & i).Value
 cond_1 = Range("c" & i).Value  ' Verifica comando para rodar script R de consolidação dos dados
 'cond_2 = Range("d" & i).Value
 
 'PASTA_ORIGEM = PASTA_GERAL & "\Caged_DP\ORIGINAIS"
 'PASTA_DESTINO = PASTA_GERAL & "\Caged_DP\EDITADOS"
 PASTA_ORIGEM = "C:\Users\ricardo.ramos\OneDrive - Ministerio do Desenvolvimento da Industria e Comercio Exterior\Profissional\DAMPE_SEMPE\Dados\Caged\FonteDadosOriginais"
 PASTA_DESTINO = "C:\Users\ricardo.ramos\OneDrive - Ministerio do Desenvolvimento da Industria e Comercio Exterior\Profissional\DAMPE_SEMPE\Dados\Caged\FonteDadosEditadas"
 
 NomePlanilha = planilha & ".xlsx"
 planilhaDaVez = PASTA_ORIGEM & "\" & NomePlanilha
  
 
 If (cond_1 = "SIM") Then
  'PASTA_ESPECIFICA = PASTA_GERAL & "\Caged_DP\EDITADOS"
 TIPO = Range("b" & i).Value
     
  
  Call ReshapeCaged(planilhaDaVez, TIPO, PASTA_DESTINO, planilha)
  ThisWorkbook.Sheets(3).Activate   ' ATUALIZARRRRR
  Range("c" & i).Value = "NÃO"
  Range("d" & i).Value = "SIM"
  Range("e" & i).Value = planilha & "_R"
'
' ElseIf cond_2 = "SIM" Then
'
'  Call ReshapeCaged(planilhaDaVez, TIPO, PASTA_DESTINO)
'  '' Alterando comandos de orientação.
'  Range("d" & i).Value = "SIM"
'  Range("b" & i).Value = "NÃO"
'
'  'Range("c" & i).Value = planilha & "_" & i & "_" & "_R"
'
'  Range("D" & i).Value = planilha & "_" & "R"
'
'
 End If



Next i

'finalrow = Range("f2000").End(xlUp).Row


''EDITANDO FP
'For i = 7 To finalrow
' planilha = Range("F" & i).Value
' cond_1 = Range("g" & i).Value
' cond_2 = Range("i" & i).Value
'
' PASTA_ORIGEM = PASTA_GERAL & "\Caged_FP\ORIGINAIS"
' PASTA_DESTINO = PASTA_GERAL & "\Caged_FP\EDITADOS"
'  TIPO = "FP"
' NOmeplanilha = planilha & ".xlsx"
'planilhaDaVez = PASTA_ORIGEM & "\" & NOmeplanilha
'
'
' If (cond_1 = "NÃO" And cond_2 = "SIM") Then
'  'PASTA_ESPECIFICA = PASTA_GERAL & "\Caged_DP\EDITADOS"
'
'
'
'  Call ReshapeCaged(planilhaDaVez, TIPO, PASTA_DESTINO)
'  ThisWorkbook.Sheets(2).Activate
'  Range("G" & i).Value = "SIM"
'  Range("H" & i).Value = planilha & "_R"
'
' ElseIf cond_2 = "SIM" Then
'
'  Call ReshapeCaged(planilhaDaVez, TIPO, PASTA_DESTINO)
'  Range("I" & i).Value = "NÃO"
'  Range("G" & i).Value = "SIM"
'
'  Range("c" & i).Value = planilha & "_" & i & "_" & "_R"
'
'
'
' End If
'
'
'
'Next i





MsgBox ("Passo 1 finalizado. Rodar Scrip R na sequência! Lembrar de atualizar as constantes do Script. ")











End Sub



Sub ReshapeCaged(wkc As String, TIPO As String, PASTA_DESTINO As String, NomePlanilha As String)
Application.ScreenUpdating = False

Dim REGIOES_4()
Dim REGIAO As String
Dim dominio As Range

Workbooks.Open (wkc)


Set wkc_DaVez = ActiveWorkbook
'wkc_1.Select




'***************ALINHAMENTO DE NOMENCLATURAS********************************

'DADOS COMUNS

IBGE_SUBSETOR_DP_ORIGINAL_25 = Array("01-Extrativa mineral", _
"02-Indústria de produtos minerais nao metálicos", _
"03-Indústria metalúrgica", "04-Indústria mecânica", _
"05-Indústria do material elétrico e de comunicaçoes", _
"06-Indústria do material de transporte", _
"07-Indústria da madeira e do mobiliário", _
"08-Indústria do papel, papelao, editorial e gráfica", _
"09-Ind. da borracha, fumo, couros, peles, similares, ind. diversas", _
"10-Ind. química de produtos farmacêuticos, veterinários, perfumaria,", _
"11-Indústria têxtil do vestuário e artefatos de tecidos", _
"12-Indústria de calçados", _
"13-Indústria de produtos alimentícios, bebidas e álcool etílico", _
"14-Serviços industriais de utilidade pública", "15-Construçao civil", _
"16-Comércio varejista", "17-Comércio atacadista", _
"18-Instituiçoes de crédito, seguros e capitalizaçao", _
"19-Com. e administraçao de imóveis, valores mobiliários, serv. técnico...", _
"20-Transportes e comunicaçoes", _
"21-Serv. de alojamento, alimentaçao, reparaçao, manutençao, redaçao, r...", _
"22-Serviços médicos, odontológicos e veterinários", _
"23-Ensino", "24-Administraçao pública direta e autárquica", _
"25-Agricultura, silvicultura, criaçao de animais, extrativismo vegetal...")

'CONTRAPARTIDA_IBGE_SUBSETOR_DP_ORIGINAL_R = Array("Extrativamineral", "Industriadeprodutosmineraisnaometalicos", "Industriametalúrgica", "Indústriamecânica", "Indústriadomaterialelétricoedecomunicaçoes", "Indústriadomaterialdetransporte", "Indústriadamadeiraedomobiliário", "Indústriadopapelpapelaoeditorialegráfica", "Inddaborrachafumocourospelessimilaresinddiversas", "Indquímicadeprodutosfarmacêuticosveterináriosperfumaria", "Indústriatêxtildovestuárioeartefatosdetecidos", "Indústriadecalçados", "Indústriadeprodutosalimentíciosbebidaseálcooletílico", "Serviçosindustriaisdeutilidadepública", "Construçaocivil", "Comérciovarejista", "Comércioatacadista", "Instituiçoesdecréditosegurosecapitalizaçao", "Comeadministraçaodeimóveisvaloresmobiliariosservtecnico", "Transportesecomunicacoes", "Servdealojamentoalimentaçaoreparaçaomanutençaoredacaor", "Servicosmedicosodontologicoseveterinarios", "Ensino", "Administraçaopublicadiretaeautarquica", "Agriculturasilviculturacriaçaodeanimaisextrativismovegetal")
'CONTRAPARTIDA_IBGE_SUBSETOR_DP_ORIGINAL_R = Array("Extrativamineral", "Industriademinerais", "Industriametalurgica", "Industriamecanica", "Industriaeletrico", "Industriatransporte", "Industriamadeirae", "Industriadopapel", "Indborracha", "Indquimica", "Industriatextil", "Industriadecalcados", "Industriadeprodutosalimenticiosbebidasealcooletilico", "Servicosindustpublica", "Construcaocivil", "Comerciovarejista", "Comercioatacadista", "Instituicoesdecredito", "Comeadministracaodeimoveis", "Transportesecomunicacoes", "Servdealojamento", "Servicosmedicos", "Ensino", "Administracaopublica", "Agriculturasilvicultura")
CONTRAPARTIDA_IBGE_SUBSETOR_DP_ORIGINAL_R = Array("Extrativamineral", "Industriaminerais", "Industriametalurgica", "Industriamecanica", "Industriaeletrico", "Industriatransporte", "Industriamadeirae", "Industriadopapel", "Indborracha", "Indquimica", "Industriatextil", "Industriadecalcados", "Industriabebidas", "Servicosindustpublica", "Construcaocivil", "Comerciovarejista", "Comercioatacadista", "Instituicoesdecredito", "Comeadministracaodeimoveis", "Transportesecomunicacoes", "Servdealojamento", "Servicosmedicos", "Ensino", "Administracaopublica", "Agriculturasilvicultura")

For i = 0 To 24
    OldName = IBGE_SUBSETOR_DP_ORIGINAL_25(i)
    NewName = CONTRAPARTIDA_IBGE_SUBSETOR_DP_ORIGINAL_R(i)
    Sheets(1).Select
    Range("A1").Select
        Cells.Replace What:=OldName, Replacement:=NewName, LookAt:=xlWhole, _
            SearchOrder:=xlByRows, MatchCase:=False, SearchFormat:=False, _
            ReplaceFormat:=False

Next i

Erase IBGE_SUBSETOR_DP_ORIGINAL_25
Erase CONTRAPARTIDA_IBGE_SUBSETOR_DP_ORIGINAL_R

IBGE_SUBSETOR_FP_ORIGINAL_25 = Array("Extrativa Mineral", "Prod. Mineral não Metálico", "Indústria Metalúrgica", "Indústria Mecânica", "Elétrico e Comunic", "Material de Transporte", "Madeira e Mobiliário", "Papel e Gráf", "Borracha, Fumo, Couros", "Indústria Química", "Indústria Têxtil", "Indústria Calçados", "Alimentos e Bebidas", "Serviço Utilidade Pública", "Construção Civil", "Comércio Varejista", "Comércio Atacadista", "Instituição Financeira", "Adm Técnica Profissional", "Transporte e Comunicações", "Aloj Comunic", "Médicos Odontológicos Vet", "Ensino", "Administração Pública", "Agricultura")
'CONTRAPARTIDA_IBGE_SUBSETOR_FP_ORIGINAL_R = Array("Extrativamineral", "Industriademinerais", "Industriametalurgica", "Industriamecanica", "Industriaeletrico", "Industriatransporte", "Industriamadeirae", "Industriadopapel", "Indborracha", "Indquimica", "Industriatextil", "Industriadecalcados", "Industriadeprodutosalimenticiosbebidasealcooletilico", "Servicosindustpublica", "Construcaocivil", "Comerciovarejista", "Comercioatacadista", "Instituicoesdecredito", "Comeadministracaodeimoveis", "Transportesecomunicacoes", "Servdealojamento", "Servicosmedicos", "Ensino", "Administracaopublica", "Agriculturasilvicultura")
CONTRAPARTIDA_IBGE_SUBSETOR_FP_ORIGINAL_R = Array("Extrativamineral", "Industriaminerais", "Industriametalurgica", "Industriamecanica", "Industriaeletrico", "Industriatransporte", "Industriamadeirae", "Industriadopapel", "Indborracha", "Indquimica", "Industriatextil", "Industriadecalcados", "Industriabebidas", "Servicosindustpublica", "Construcaocivil", "Comerciovarejista", "Comercioatacadista", "Instituicoesdecredito", "Comeadministracaodeimoveis", "Transportesecomunicacoes", "Servdealojamento", "Servicosmedicos", "Ensino", "Administracaopublica", "Agriculturasilvicultura")

For i = 0 To 24
    OldName = IBGE_SUBSETOR_FP_ORIGINAL_25(i)
    NewName = CONTRAPARTIDA_IBGE_SUBSETOR_FP_ORIGINAL_R(i)
    Sheets(1).Select
    Range("A1").Select
        Cells.Replace What:=OldName, Replacement:=NewName, LookAt:=xlWhole, _
            SearchOrder:=xlByRows, MatchCase:=False, SearchFormat:=False, _
            ReplaceFormat:=False

Next i

Erase IBGE_SUBSETOR_FP_ORIGINAL_25
Erase CONTRAPARTIDA_IBGE_SUBSETOR_FP_ORIGINAL_R





'DADOS FP
IBGE_SETOR_FP_ORIGINAL = Array("EXTR MINERAL", "INDUST TRANSF", "SERV IND UP", "CONSTR CIVIL", "COMERCIO", "SERVICOS", "ADM PUBLICA", "AGROPECUARIA")
'CONTRAPARTIDA_IBGE_SETOR_FP_ORIGINAL_R = Array("Extrativamineral", "Industria_transformacao", "SIUP", "ConstrucaoCivil", "Comecio", "Servicos", "AdministracaoPblica", "Agropecuaria")
CONTRAPARTIDA_IBGE_SETOR_FP_ORIGINAL_R = Array("Extrativa mineral", "Indústria de transformação", "SIUP", "Construção Civil", "Comércio", "Servicos", "Administração Pública", "Agropecuária")


For i = 0 To 7
    OldName = IBGE_SETOR_FP_ORIGINAL(i)
    NewName = CONTRAPARTIDA_IBGE_SETOR_FP_ORIGINAL_R(i)
    Sheets(1).Select
    Range("A1").Select
        Cells.Replace What:=OldName, Replacement:=NewName, LookAt:=xlWhole, _
            SearchOrder:=xlByRows, MatchCase:=False, SearchFormat:=False, _
            ReplaceFormat:=False

Next i

Erase IBGE_SETOR_FP_ORIGINAL
Erase CONTRAPARTIDA_IBGE_SETOR_FP_ORIGINAL_R





UFFULL_SEMEDICAO = Array("11 - Rondônia", "12 - Acre", "13 - Amazonas", "14 - Roraima", "15 - Para", "16 - Amapa", "17 - Tocantins", "21 - Maranhão", "22 - Piaui", "23 - Ceará", "24 - Rio Grande do Norte", "25 - Paraíba", "26 - Pernambuco", "27 - Alagoas", "28 - Sergipe", "29 - Bahia", "31 - Minas Gerais", "32 - Espírito Santo", "33 - Rio de Janeiro", "35 - São Paulo", "41 - Paraná", "42 - Santa Catarina", "43 - Rio Grande do Sul", "50 - Mato Grosso do Sul", "51 - Mato Grosso", "52 - Goiás", "53 - Distrito Federal")
'CONTRAPARTIDA_UFFULL_PUBLICAÇÃO = Array("Rondônia", "Acre", "Amazonas", "Roraima", "Pará", "Amapá", "Tocantins", "Maranhão", "Piaui", "Ceará", "Rio Grande do Norte", "Paraíba", "Pernambuco", "Alagoas", "Sergipe", "Bahia", "Minas Gerais", "Espírito Santo", "Rio de Janeiro", "São Paulo", "Paraná", "Santa Catarina", "Rio Grande do Sul", "Mato Grosso do Sul", "Mato Grosso", "Goiás", "Distrito Federal")
CONTRAPARTIDA_UFFULL_PUBLICAÇÃO = Array("Rondonia", "Acre", "Amazonas", "Roraima", "Para", "Amapa", "Tocantins", "Maranhao", "Piaui", "Ceara", "RioGrandedoNorte", "Paraiba", "Pernambuco", "Alagoas", "Sergipe", "Bahia", "MinasGerais", "EspiritoSanto", "RiodeJaneiro", "SaoPaulo", "Parana", "SantaCatarina", "RioGrandedoSul", "MatoGrossodoSul", "MatoGrosso", "Goias", "DistritoFederal")

For i = 0 To 26
    OldName = UFFULL_SEMEDICAO(i)
    NewName = CONTRAPARTIDA_UFFULL_PUBLICAÇÃO(i)
    Sheets(1).Select
    Range("A1").Select
        Cells.Replace What:=OldName, Replacement:=NewName, LookAt:=xlWhole, _
            SearchOrder:=xlByRows, MatchCase:=False, SearchFormat:=False, _
            ReplaceFormat:=False

Next i

Erase UFFULL_SEMEDICAO
Erase CONTRAPARTIDA_UFFULL_PUBLICAÇÃO




'DADOS DP
IBGE_SETOR_DP_ORIGINAL_8 = Array("1 - Extrativa mineral", "2 - Indústria de transformação", "3 - Serviços Industr de Utilidade Pública", "4 - Construção Civil", "5 - Comércio", "6 - Servicos", "7 - Administração Pública", "8 - Agropecuária, extr vegetal, caça e pesca")
CONTRAPARTIDA_IBGE_SETOR_DP_ORIGINAL_R = Array("Extrativa mineral", "Indústria de transformação", "SIUP", "Construção Civil", "Comércio", "Servicos", "Administração Pública", "Agropecuária")

For i = 0 To 7
    OldName = IBGE_SETOR_DP_ORIGINAL_8(i)
    NewName = CONTRAPARTIDA_IBGE_SETOR_DP_ORIGINAL_R(i)
    Sheets(1).Select
    Range("A1").Select
        Cells.Replace What:=OldName, Replacement:=NewName, LookAt:=xlWhole, _
            SearchOrder:=xlByRows, MatchCase:=False, SearchFormat:=False, _
            ReplaceFormat:=False
            
            
             

Next i

Erase IBGE_SETOR_DP_ORIGINAL_8
Erase CONTRAPARTIDA_IBGE_SETOR_DP_ORIGINAL_R



'***************FIM ALINHAMENTO DE NOMENCLATURAS********************************





RgnNorte = "Região Natural = Norte"
RgnNordeste = "Região Natural = Nordeste"
RgnSudeste = "Região Natural = Sudeste"
RgnSul = "Região Natural = Sul"
RgnOeste = "Região Natural = Centro-Oeste"



' Inserir colunas para os campos: REGIAO, ANO, MES, CLASS_SEBRAE
Columns("A:E").Select
Selection.Insert Shift:=xlToRight, CopyOrigin:=xlFormatFromLeftOrAbove

'Identifico as posições de cada string realtiva às regiões
finalrow = Range("F3000").End(xlUp).Row
Set dominio = Range("F1:F" & finalrow)


REGIOES_5 = Array("Região Natural = Norte", "Região Natural = Nordeste", "Região Natural = Sudeste", "Região Natural = Sul", "Região Natural = Centro-Oeste")

For i = 0 To 4
 REGIAO = REGIOES_5(i)
 localizador = ContainsText(dominio, REGIAO)
 If i = 0 Then
  LinhaEsp = Right(localizador, 1) + 1 ' * é a linha onde se vai formar a chave de Subsetor.UF
 End If
 If Len(localizador) = 2 Then
  Linha_localizador = Right(localizador, 1)
 ElseIf Len(localizador) = 3 Then
   Linha_localizador = Right(localizador, 2)
 Else
  Linha_localizador = Right(localizador, 3)
 
 End If

 
 novaPosicao = "a" & Linha_localizador + 4
 Range(localizador).Copy Destination:=Range(novaPosicao)
 
 
 If i > 0 Then
  deletRows = Linha_localizador & ":" & Linha_localizador + 3
  Rows(deletRows).Select
  Selection.Delete Shift:=xlUp
  
 
 End If
 If i = 4 Then
  finalrow = Range("F20000").End(xlUp).Row
  
  Data = Range("h" & finalrow)
  
   MES = UCase(MonthName(Month(Data)))
   ANO = Year(Data)
  
  deletRows = finalrow - 3 & ":" & Linha_localizador + 1000
  Rows(deletRows).Select
  Selection.Delete Shift:=xlUp
  ' COLETANDO DADOS DE MES E ANO
  
    
  
 End If
 
 
Next i
 


 ' Formando a chave SUBSETOR.UF
 
    Range("H2").Select
    ActiveCell.FormulaR1C1 = "=R[1]C &"".""&R[2]C"
    Range("H2").Select
    Selection.Copy
    Range("I2").Select
    Range(Selection, Selection.End(xlToRight)).Select
    ActiveSheet.Paste
    
   
    'ActiveWindow.SmallScroll ToRight:=-6
    Range("h2").Select
    Range(Selection, Selection.End(xlToRight)).Select
    
    
    Range(Selection, Selection.End(xlToRight)).Select
    Application.CutCopyMode = False
    Selection.Copy
    Range("h2").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
    Rows("3:4").Select
    Selection.Delete Shift:=xlUp
    Rows("1:1").Select
    Selection.Delete Shift:=xlUp
    Range("A1").Select
    ActiveCell.FormulaR1C1 = "REGIAO"
    Range("B1").Select
    ActiveCell.FormulaR1C1 = "ANO"
    Range("C1").Select
    ActiveCell.FormulaR1C1 = "MES"
    Range("C2").Value = MES
    finalrow = Range("I2000").End(xlUp).Row

'    Range("C2").Select
'    Selection.Copy
'    Range("C3:C" & finalrow).Select
'    ActiveSheet.Paste
'
'
'
'
'
    Range("B2").Value = ANO
    Range("B2").Select
    Selection.Copy
    Range("B3").Select
    Range("B3:B" & finalrow).Select
    ActiveSheet.Paste
'
    
    
    
    
    Range("D1").Select
    ActiveCell.FormulaR1C1 = "TIPO_DADO"
    'TIPO = MsgBox("QUAL O TIPO: DP OU FP")
    'Insere a string referenciada pela chamada da call
    Range("d2").Value = TIPO
    Range("d2").Select
    Selection.Copy
    Range("d3").Select
    Range("d3:d" & finalrow).Select
    ActiveSheet.Paste
    
    
    Range("C2").Select
    Selection.Copy
    Range("C3").Select
    Range("C3:C" & finalrow).Select
    ActiveSheet.Paste
    
    
    
    
    
    Range("e1").Select
    ActiveCell.FormulaR1C1 = "CLASS_SEBRAE"
    Range("f1").Select
    ActiveCell.FormulaR1C1 = "FAIXA_EMPREGO"
    Range("g1").Select
    ActiveCell.FormulaR1C1 = "SETOR_IBGE"
    
    
    Range("E2").Select
    ActiveCell.FormulaR1C1 = _
        "=IF(AND(RC[1]=""DE 50 A 99"",RC[2]=""Indústria de transformação""),""MPE"",IF(AND(RC[1]=""DE 50 A 99"",RC[2]=""Construção Civil""),""MPE"",IF(AND(RC[1]=""DE 50 A 99"",RC[2]=""Extrativa mineral""),""MPE"",IF(RC[1]=""ATÉ 4"",""MPE"",IF(RC[1]=""DE 5 A 9"",""MPE"",IF(RC[1]=""DE 10 A 19"",""MPE"",IF(RC[1]=""DE 20 A 49"",""MPE"",""MGE"")))))))"

    'finalrow = Range("I2000").End(xlUp).Row
    Selection.AutoFill Destination:=Range("e2" & ":e" & finalrow), Type:=xlFillDefault
 
    
'
'    Range("A5").Select
'    Range("A11").Select
'    Selection.End(xlDown).Select
    
    
    Columns("A:A").Select
    Range("A3").Activate
    Selection.SpecialCells(xlCellTypeBlanks).Select
    Selection.FormulaR1C1 = "=R[-1]C"


   Columns("F:F").Select
    Range("F3").Activate
    Selection.SpecialCells(xlCellTypeBlanks).Select
    Selection.FormulaR1C1 = "=R[-1]C"


   'AJUSTES FINAIS
 deletRows = finalrow + 1 & ":" & Linha_localizador + 1000
  Rows(deletRows).Select
  Selection.Delete Shift:=xlUp
  
  
   finalcol = Range("xfd3").End(xlToLeft).Column
   finalcol2 = Range("xad3").End(xlToRight).Column
   Range(Cells(1, finalcol + 1), Cells(1, finalcol2)).Select
   Range(Selection, Selection.End(xlToRight)).Select
    Selection.ClearContents
    
    



' Localizador da Região Norte
 
 
 
 'NOME = PASTA_DESTINO & "\" & "Caged" & "_" & MES & "_" & ANO & "_" & TIPO & "_" & "R" & ".csv"
 
 'nomeParte_1 = "Caged" & "_" & MES & "_" & ANO & "_" & TIPO & "_" & "R"
 nomeParte_1 = NomePlanilha & "_" & "R"
 
 NOME = PASTA_DESTINO & "\" & nomeParte_1
 
 
 ChDir _
        PASTA_DESTINO
    ActiveWorkbook.SaveAs Filename:= _
        NOME _
        , FileFormat:=xlCSV, CreateBackup:=False

 
 
' ChDir _
'        PASTA_DESTINO
'    ActiveWorkbook.SaveAs Filename:= _
'        NOME _
'        , FileFormat:=xlOpenXMLWorkbook, CreateBackup:=False


'These are the main file formats in Excel 2007:
'
'51 = xlOpenXMLWorkbook (without macro’s in 2007, .xlsx)
'52 = xlOpenXMLWorkbookMacroEnabled (with or without macro’s in 2007, .xlsm)
'50 = xlExcel12 (Excel Binary Workbook in 2007 with or without macro’s, .xlsb)
'56 = xlExcel8 (97-2003 format in Excel 2007, .xls)
 
 
' ChDir _
'        "C:\Users\ricardo.ramos\OneDrive - Ministerio do Desenvolvimento da Industria e Comercio Exterior\R-projects\DAMPE-SEMPE\Dados\Caged_FP\EDITADOS"
'    ActiveWorkbook.SaveAs Filename:= _
'        NOME _
'        , FileFormat:=xlCSV, CreateBackup:=False
'
    
  
  
  
  
 ActiveWorkbook.Close SaveChanges:=True
 



End Sub




