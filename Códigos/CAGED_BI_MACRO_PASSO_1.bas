Attribute VB_Name = "CAGED_BI_MACRO_PASSO_1"
Function ContainsText(Rng As Range, Text As String) As String
    'Rng �The range in which to search.
    'Text �The text for which to search.
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
'1)Inserir em uma mesma coluna o nome dos arquivos DP e FP que ser�o editados. A identifica��o DP E FP se dar� pelo nome e subsidiariamente por cor. Verde para DP e roxo para FP
' 2) Simplificar caminho para salvar os arquivos extra�dos do caged.
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


Set wkc_controle = Workbooks("Informa��es_DAMPE.xlsm").Sheets(3)  ' ATUALIZARRRRR
wkc_controle.Select


'CONSTANTES
'PASTA_GERAL = "C:\Users\ricardo.ramos\OneDrive - Ministerio do Desenvolvimento da Industria e Comercio Exterior\R-projects\DAMPE-SEMPE\Dados"
'PASTA_GERAL

' Econtra a qtdde de planilhas a editar
finalrow = Range("a2000").End(xlUp).Row

'EDITANDO DP e FP
MsgBox ("LEMBRAR DE CONVERTER OS ARQUIVOS NA EXTENS�O .xlsx")
 
For i = 7 To finalrow
 planilha = Range("a" & i).Value
 cond_1 = Range("c" & i).Value  ' Verifica comando para rodar script R de consolida��o dos dados
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
  Range("c" & i).Value = "N�O"
  Range("d" & i).Value = "SIM"
  Range("e" & i).Value = planilha & "_R"
'
' ElseIf cond_2 = "SIM" Then
'
'  Call ReshapeCaged(planilhaDaVez, TIPO, PASTA_DESTINO)
'  '' Alterando comandos de orienta��o.
'  Range("d" & i).Value = "SIM"
'  Range("b" & i).Value = "N�O"
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
' If (cond_1 = "N�O" And cond_2 = "SIM") Then
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
'  Range("I" & i).Value = "N�O"
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





MsgBox ("Passo 1 finalizado. Rodar Scrip R na sequ�ncia! Lembrar de atualizar as constantes do Script. ")











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
"02-Ind�stria de produtos minerais nao met�licos", _
"03-Ind�stria metal�rgica", "04-Ind�stria mec�nica", _
"05-Ind�stria do material el�trico e de comunica�oes", _
"06-Ind�stria do material de transporte", _
"07-Ind�stria da madeira e do mobili�rio", _
"08-Ind�stria do papel, papelao, editorial e gr�fica", _
"09-Ind. da borracha, fumo, couros, peles, similares, ind. diversas", _
"10-Ind. qu�mica de produtos farmac�uticos, veterin�rios, perfumaria,", _
"11-Ind�stria t�xtil do vestu�rio e artefatos de tecidos", _
"12-Ind�stria de cal�ados", _
"13-Ind�stria de produtos aliment�cios, bebidas e �lcool et�lico", _
"14-Servi�os industriais de utilidade p�blica", "15-Constru�ao civil", _
"16-Com�rcio varejista", "17-Com�rcio atacadista", _
"18-Institui�oes de cr�dito, seguros e capitaliza�ao", _
"19-Com. e administra�ao de im�veis, valores mobili�rios, serv. t�cnico...", _
"20-Transportes e comunica�oes", _
"21-Serv. de alojamento, alimenta�ao, repara�ao, manuten�ao, reda�ao, r...", _
"22-Servi�os m�dicos, odontol�gicos e veterin�rios", _
"23-Ensino", "24-Administra�ao p�blica direta e aut�rquica", _
"25-Agricultura, silvicultura, cria�ao de animais, extrativismo vegetal...")

'CONTRAPARTIDA_IBGE_SUBSETOR_DP_ORIGINAL_R = Array("Extrativamineral", "Industriadeprodutosmineraisnaometalicos", "Industriametal�rgica", "Ind�striamec�nica", "Ind�striadomaterialel�tricoedecomunica�oes", "Ind�striadomaterialdetransporte", "Ind�striadamadeiraedomobili�rio", "Ind�striadopapelpapelaoeditorialegr�fica", "Inddaborrachafumocourospelessimilaresinddiversas", "Indqu�micadeprodutosfarmac�uticosveterin�riosperfumaria", "Ind�striat�xtildovestu�rioeartefatosdetecidos", "Ind�striadecal�ados", "Ind�striadeprodutosaliment�ciosbebidase�lcoolet�lico", "Servi�osindustriaisdeutilidadep�blica", "Constru�aocivil", "Com�rciovarejista", "Com�rcioatacadista", "Institui�oesdecr�ditosegurosecapitaliza�ao", "Comeadministra�aodeim�veisvaloresmobiliariosservtecnico", "Transportesecomunicacoes", "Servdealojamentoalimenta�aorepara�aomanuten�aoredacaor", "Servicosmedicosodontologicoseveterinarios", "Ensino", "Administra�aopublicadiretaeautarquica", "Agriculturasilviculturacria�aodeanimaisextrativismovegetal")
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

IBGE_SUBSETOR_FP_ORIGINAL_25 = Array("Extrativa Mineral", "Prod. Mineral n�o Met�lico", "Ind�stria Metal�rgica", "Ind�stria Mec�nica", "El�trico e Comunic", "Material de Transporte", "Madeira e Mobili�rio", "Papel e Gr�f", "Borracha, Fumo, Couros", "Ind�stria Qu�mica", "Ind�stria T�xtil", "Ind�stria Cal�ados", "Alimentos e Bebidas", "Servi�o Utilidade P�blica", "Constru��o Civil", "Com�rcio Varejista", "Com�rcio Atacadista", "Institui��o Financeira", "Adm T�cnica Profissional", "Transporte e Comunica��es", "Aloj Comunic", "M�dicos Odontol�gicos Vet", "Ensino", "Administra��o P�blica", "Agricultura")
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
CONTRAPARTIDA_IBGE_SETOR_FP_ORIGINAL_R = Array("Extrativa mineral", "Ind�stria de transforma��o", "SIUP", "Constru��o Civil", "Com�rcio", "Servicos", "Administra��o P�blica", "Agropecu�ria")


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





UFFULL_SEMEDICAO = Array("11 - Rond�nia", "12 - Acre", "13 - Amazonas", "14 - Roraima", "15 - Para", "16 - Amapa", "17 - Tocantins", "21 - Maranh�o", "22 - Piaui", "23 - Cear�", "24 - Rio Grande do Norte", "25 - Para�ba", "26 - Pernambuco", "27 - Alagoas", "28 - Sergipe", "29 - Bahia", "31 - Minas Gerais", "32 - Esp�rito Santo", "33 - Rio de Janeiro", "35 - S�o Paulo", "41 - Paran�", "42 - Santa Catarina", "43 - Rio Grande do Sul", "50 - Mato Grosso do Sul", "51 - Mato Grosso", "52 - Goi�s", "53 - Distrito Federal")
'CONTRAPARTIDA_UFFULL_PUBLICA��O = Array("Rond�nia", "Acre", "Amazonas", "Roraima", "Par�", "Amap�", "Tocantins", "Maranh�o", "Piaui", "Cear�", "Rio Grande do Norte", "Para�ba", "Pernambuco", "Alagoas", "Sergipe", "Bahia", "Minas Gerais", "Esp�rito Santo", "Rio de Janeiro", "S�o Paulo", "Paran�", "Santa Catarina", "Rio Grande do Sul", "Mato Grosso do Sul", "Mato Grosso", "Goi�s", "Distrito Federal")
CONTRAPARTIDA_UFFULL_PUBLICA��O = Array("Rondonia", "Acre", "Amazonas", "Roraima", "Para", "Amapa", "Tocantins", "Maranhao", "Piaui", "Ceara", "RioGrandedoNorte", "Paraiba", "Pernambuco", "Alagoas", "Sergipe", "Bahia", "MinasGerais", "EspiritoSanto", "RiodeJaneiro", "SaoPaulo", "Parana", "SantaCatarina", "RioGrandedoSul", "MatoGrossodoSul", "MatoGrosso", "Goias", "DistritoFederal")

For i = 0 To 26
    OldName = UFFULL_SEMEDICAO(i)
    NewName = CONTRAPARTIDA_UFFULL_PUBLICA��O(i)
    Sheets(1).Select
    Range("A1").Select
        Cells.Replace What:=OldName, Replacement:=NewName, LookAt:=xlWhole, _
            SearchOrder:=xlByRows, MatchCase:=False, SearchFormat:=False, _
            ReplaceFormat:=False

Next i

Erase UFFULL_SEMEDICAO
Erase CONTRAPARTIDA_UFFULL_PUBLICA��O




'DADOS DP
IBGE_SETOR_DP_ORIGINAL_8 = Array("1 - Extrativa mineral", "2 - Ind�stria de transforma��o", "3 - Servi�os Industr de Utilidade P�blica", "4 - Constru��o Civil", "5 - Com�rcio", "6 - Servicos", "7 - Administra��o P�blica", "8 - Agropecu�ria, extr vegetal, ca�a e pesca")
CONTRAPARTIDA_IBGE_SETOR_DP_ORIGINAL_R = Array("Extrativa mineral", "Ind�stria de transforma��o", "SIUP", "Constru��o Civil", "Com�rcio", "Servicos", "Administra��o P�blica", "Agropecu�ria")

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





RgnNorte = "Regi�o Natural = Norte"
RgnNordeste = "Regi�o Natural = Nordeste"
RgnSudeste = "Regi�o Natural = Sudeste"
RgnSul = "Regi�o Natural = Sul"
RgnOeste = "Regi�o Natural = Centro-Oeste"



' Inserir colunas para os campos: REGIAO, ANO, MES, CLASS_SEBRAE
Columns("A:E").Select
Selection.Insert Shift:=xlToRight, CopyOrigin:=xlFormatFromLeftOrAbove

'Identifico as posi��es de cada string realtiva �s regi�es
finalrow = Range("F3000").End(xlUp).Row
Set dominio = Range("F1:F" & finalrow)


REGIOES_5 = Array("Regi�o Natural = Norte", "Regi�o Natural = Nordeste", "Regi�o Natural = Sudeste", "Regi�o Natural = Sul", "Regi�o Natural = Centro-Oeste")

For i = 0 To 4
 REGIAO = REGIOES_5(i)
 localizador = ContainsText(dominio, REGIAO)
 If i = 0 Then
  LinhaEsp = Right(localizador, 1) + 1 ' * � a linha onde se vai formar a chave de Subsetor.UF
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
        "=IF(AND(RC[1]=""DE 50 A 99"",RC[2]=""Ind�stria de transforma��o""),""MPE"",IF(AND(RC[1]=""DE 50 A 99"",RC[2]=""Constru��o Civil""),""MPE"",IF(AND(RC[1]=""DE 50 A 99"",RC[2]=""Extrativa mineral""),""MPE"",IF(RC[1]=""AT� 4"",""MPE"",IF(RC[1]=""DE 5 A 9"",""MPE"",IF(RC[1]=""DE 10 A 19"",""MPE"",IF(RC[1]=""DE 20 A 49"",""MPE"",""MGE"")))))))"

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
    
    



' Localizador da Regi�o Norte
 
 
 
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
'51 = xlOpenXMLWorkbook (without macro�s in 2007, .xlsx)
'52 = xlOpenXMLWorkbookMacroEnabled (with or without macro�s in 2007, .xlsm)
'50 = xlExcel12 (Excel Binary Workbook in 2007 with or without macro�s, .xlsb)
'56 = xlExcel8 (97-2003 format in Excel 2007, .xls)
 
 
' ChDir _
'        "C:\Users\ricardo.ramos\OneDrive - Ministerio do Desenvolvimento da Industria e Comercio Exterior\R-projects\DAMPE-SEMPE\Dados\Caged_FP\EDITADOS"
'    ActiveWorkbook.SaveAs Filename:= _
'        NOME _
'        , FileFormat:=xlCSV, CreateBackup:=False
'
    
  
  
  
  
 ActiveWorkbook.Close SaveChanges:=True
 



End Sub




