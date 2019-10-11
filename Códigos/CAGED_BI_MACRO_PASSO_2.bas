Attribute VB_Name = "CAGED_BI_MACRO_PASSO_2"
'TO DO
'Data registro: 26/09/2019
 '==Criar variável para atualizar anobase, que atualmente está fixo em 2019
 





Sub Transfere()
'
Application.ScreenUpdating = False
Dim wkc_DaVez As Workbook

' Transfere Macro
'

'

Estados = Array("Brasil", "Acre", "Amazonas", "Roraima", "Amapa", "Para", "Rondonia", "Tocantins", "Alagoas", "Bahia", "Ceara", "Maranhao", "Paraiba", "Pernambuco", "Piaui", "RioGrandedoNorte", "Sergipe", "EspiritoSanto", _
"MinasGerais", "RiodeJaneiro", "SaoPaulo", "Parana", "RioGrandedoSul", "SantaCatarina", "DistritoFederal", "Goias", "MatoGrossodoSul", "MatoGrosso")

NomeCorreto = Array("Brasil", "Acre", "Amazonas", "Roraima", "Amapá", "Pará", "Rondônia", "Tocantins", "Alagoas", "Bahia", "Ceará", "Maranhão", "Paraíba", "Pernambuco", "Piauí", "Rio Grande do Norte", "Sergipe", "Espirito Santo", _
"Minas Gerais", "Rio de Janeiro", "São Paulo", "Paraná", "Rio Grande do Sul", "Santa Catarina", "Distrito Federal", "Goiás", "Mato Grosso do Sul", "Mato Grosso")

MsgBox ("ATUALIZAR A VARIÁVEL MÊS DE REFEREÊNCIA E CRIAR PASTA DO MÊS!!")
'MesReferencia = "Janeiro"
'MesReferencia = "Fevereiro"
'MesReferencia = "Maio"
'MesReferencia = "Junho"
'MesReferencia = "Julho"
MesReferencia = "Agosto"




ANO = "2019"

tam = UBound(Estados) - LBound(Estados) + 1

For i = 0 To tam - 1

UF = Estados(i)

'PASTA_GERAL = "C:\Users\ricardo.ramos\OneDrive - Ministerio do Desenvolvimento da Industria e Comercio Exterior\R-projects\DAMPE-SEMPE\Dados\"
 PASTA_GERAL = "C:\Users\ricardo.ramos\OneDrive - Ministerio do Desenvolvimento da Industria e Comercio Exterior\Profissional\DAMPE_SEMPE\Dados\Caged\Resultados\"
' Utilizando os dados do Mes de referencia
planilha = UF & "\" & MesReferencia & "\" & UF & "-Mensal.xlsx"
wkc = PASTA_GERAL & "\" & planilha
 
Workbooks.Open (wkc)
Set wkc_DaVez = ActiveWorkbook

temp = "PDET_MPE\" & MesReferencia & "\MPE_PDET_" & MesReferencia & "_2019.xlsx" 'é a planilha que referente ao mês de edição em que serão inseridos os novos dados.

PlanilhaFull = PASTA_GERAL & "PDET_MPE\" & MesReferencia & "\MPE_PDET_" & MesReferencia & "_2019.xlsx" 'é a planilha que referente ao mês de edição em que serão inseridos os novos dados.

If i = 0 Then
Set PlanilhaDestino = Workbooks.Open(PlanilhaFull)

End If


    PlanilhaDestino.Activate
    ActiveWorkbook.Sheets(i + 3).Select
    
    ' Organiza Títulos
    NOME = UCase(NomeCorreto(i))
    Range("a1").Value = "UF:" & NOME & "-EVOLUÇÃO DO EMPREGO POR SETOR E SUBSETOR DE ATIVIDADE ECONÔMICA"
    Range("a2").Value = "MICRO E PEQUENAS EMPRESAS(MPE) X MÉDIAS E GRANDES EMPRESAS(MGE)"
    Range("a3").ClearContents
    Range("g3").ClearContents
    
    
    Range("a6").Value = NomeCorreto(i)
    
'======= HIPERLINK=========
'    ActiveSheet.Hyperlinks.Add Range("A1"), Address:="", SubAddress:="'" &nomelink ; Sheet2.Name &amp; "'!B2", TextToDisplay:="Click Here to Go to Sheet2, cell B2 of the same workbook
'
'    nomelink = NomeCorreto(i)
'locallink = nomelink & "!A1"
' locallink = "='" & nomelink & "'" & "!R26C1"
'
' =Brasil!$J$5
'sValue = ActiveSheet.Names(locallink).RefersTo
'ActiveWorkbook.Names.Add Name:=nomelink, RefersTo:="$A$1"
'
'    ActiveWorkbook.Names(nomelink).Comment = ""
'    Range("j1").Select
'    ActiveSheet.Hyperlinks.Add Anchor:=Selection, Address:="", SubAddress:= _
'        nomelink, TextToDisplay:="link2"
'
'
'    ActiveWorkbook.Names.Add Name:="lixolink", RefersToR1C1:= _
'        "='Edições Úteis'!R26C1"

'======= HIPERLINK=========
    
    
    'Dados das MGE
    Range("B8").Select
    buscarEm = UF & "-Mensal.xlsx]Sheet1'!C1:C4,"
    ActiveCell.FormulaR1C1 = _
            "=VLOOKUP(RC1,'[" & buscarEm & "3,FALSE)"
    
    'Dados das MPE
    Range("C8").Select
    buscarEm = UF & "-Mensal.xlsx]Sheet1'!C1:C4,"
    ActiveCell.FormulaR1C1 = _
            "=VLOOKUP(RC1,'[" & buscarEm & "4,FALSE)"
            
    Range("d8").Select
    ActiveCell.FormulaR1C1 = _
            "=VLOOKUP(RC1,'[" & buscarEm & "2,FALSE)"
    
    Range("B8:D8").Select
    Selection.Copy
    Range("B10:D22").Select
    ActiveWindow.SmallScroll Down:=8
    Range("B10:D22,B24:D24,B26:D26,B28:D30,B32:D38").Select
    Range("B32").Activate
    ActiveWindow.SmallScroll Down:=7
    Range("B10:D22,B24:D24,B26:D26,B28:D30,B32:D38,B40:D40,B42:D42").Select
    Range("B42").Activate
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    

    
    
    
    'Application.CutCopyMode = False
    
wkc_DaVez.Close

    
planilha = UF & "\" & MesReferencia & "\" & UF & "-Anual.xlsx"
wkc = PASTA_GERAL & "\" & planilha
 
Workbooks.Open (wkc)

Set wkc_DaVez = ActiveWorkbook
    
    
    'ThisWorkbook.Activate
    PlanilhaDestino.Activate
    
    
    ActiveWorkbook.Sheets(i + 3).Select
    
 'Dados das MGE
    Range("e8").Select
    buscarEm = UF & "-Anual.xlsx]Sheet1'!C1:C4,"
    ActiveCell.FormulaR1C1 = _
            "=VLOOKUP(RC1,'[" & buscarEm & "3,FALSE)"
    
    'Dados das MPE
    Range("f8").Select
    ActiveCell.FormulaR1C1 = _
            "=VLOOKUP(RC1,'[" & buscarEm & "4,FALSE)"
            
    Range("g8").Select
    ActiveCell.FormulaR1C1 = _
            "=VLOOKUP(RC1,'[" & buscarEm & "2,FALSE)"
    
    
    
    
    Range("E8:G8").Select
    Selection.Copy
    Range("E10").Select
    
    Range("E10:G22,E24:G24,E26:G26").Select
    Range("E26").Activate
    ActiveWindow.SmallScroll Down:=13
    Range("E10:G22,E24:G24,E26:G26,E28:G30,E32:G38,E40:G40").Select
    Range("E40").Activate
    ActiveWindow.SmallScroll Down:=4
    Range("E10:G22,E24:G24,E26:G26,E28:G30,E32:G38,E40:G40,E42:G42").Select
    Range("E42").Activate
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False

'Ajustes finais
'ThisWorkbook.Activate
PlanilhaDestino.Activate
ActiveWorkbook.Sheets(i + 3).Select

Range("B6").Select
    ActiveCell.FormulaR1C1 = _
        "=SUM(R[2]C,R[4]C,R[18]C,R[20]C,R[22]C,R[26]C,R[34]C,R[36]C)"
    Range("B6").Select
    Selection.Copy
    Range("B6,C6,D6,E6,F6,G6").Select
    Range("G6").Activate
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
 '********************************************************


Range("B6:G42").Select
    Selection.Copy
        Range("B6").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False


wkc_DaVez.Close
' wkc.Close Save:=False
'Ajustes finais
' Título da célula B4
Range("b4").Value = "Mês/Ano* (" & MesReferencia & "/" & ANO & ") - sem ajuste"



'Insercao de hiperlinks

'nomelink = NomeCorreto(i)
'locallink = "='" & nomelink & "'!R1C1"
'ActiveWorkbook.Names.Add Name:=nomelink, RefersToR1C1:="='Edições Úteis'!R26C1"
'    ActiveWorkbook.Names("lixolink").Comment = ""
'    Range("A25").Select
'    ActiveSheet.Hyperlinks.Add Anchor:=Selection, Address:="", SubAddress:= _
'        "lixolink", TextToDisplay:="link2"






Next i


' Separando as abas nas regiões
'=====================================================================================
' Região Norte
Set wkcDaVez = Workbooks.Add
'PastaGeral = "C:\Users\ricardo.ramos\OneDrive - Ministerio do Desenvolvimento da Industria e Comercio Exterior\R-projects\DAMPE-SEMPE\Dados\"
PastaGeral = "C:\Users\ricardo.ramos\OneDrive - Ministerio do Desenvolvimento da Industria e Comercio Exterior\Profissional\DAMPE_SEMPE\Dados\Caged\Resultados\"
PastaEspecifica = "REGIAO NORTE\" & MesReferencia
PASTA_DESTINO = PastaGeral & PastaEspecifica
arquivo = "REGIAO_NORTE_" & MesReferencia & ".xlsx"
NOME = PASTA_DESTINO & "\" & "REGIAO_NORTE_" & MesReferencia

wkcDaVez.Activate
    ChDir _
        PASTA_DESTINO
    ActiveWorkbook.SaveAs Filename:= _
        NOME _
        , FileFormat:=xlOpenXMLWorkbook, CreateBackup:=False

'ThisWorkbook.Activate
PlanilhaDestino.Activate
    Sheets(Array("CAGED", "Sumário", "Brasil", "Acre", "Amazonas", "Roraima", "Amapá", "Pará", "Rondônia", "Tocantins")).Copy Before:=Workbooks(arquivo).Sheets(1)

Sheets("Planilha1").Select
    ActiveWindow.SelectedSheets.Delete

'Excluindo planilha do Sumário
Sheets(2).Select
    ActiveWindow.SelectedSheets.Delete

Sheets(1).Select
Range("b12").Value = MesReferencia & " de " & ANO

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Insere aba Consolidadora da Região

Sheets(3).Copy After:=Sheets(2)
   
    Range("B6").Select
    ActiveCell.FormulaR1C1 = "=SUM('Acre:Tocantins'!RC)"
    
    
    Range("B6").Select
    Application.CutCopyMode = False
    Selection.Copy
    
    Range("B6,B8,B10,B10:B22,B24,B26,B28:B30,B32,B32:B38,B40,B42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    
    Range("C6,C8,C10,C10:C22,C24,C26,C28:C30,C32,C32:C38,C40,C42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    
    Range("D6,D8,D10,D10:D22,D24,D26,D28:D30,D32,D32:D38,D40,D42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    Range("E6,E8,E10,E10:E22,E24,E26,E28:E30,E32,E32:E38,E40,E42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    Range("F6,F8,F10,F10:F22,F24,F26,F28:F30,F32,F32:F38,F40,F42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    Range("G6,G8,G10,G10:G22,G24,G26,G28:G30,G32,G32:G38,G40,G42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False

    Sheets(3).Name = "Região Norte"

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


    

PastaEspecifica = "REGIOES_POR_MES\" & MesReferencia
PASTA_DESTINO = PastaGeral & PastaEspecifica
NOME = PASTA_DESTINO & "\" & "REGIAO_NORTE_" & MesReferencia
    
wkcDaVez.Activate
    ChDir _
        PASTA_DESTINO
    ActiveWorkbook.SaveAs Filename:= _
        NOME _
        , FileFormat:=xlOpenXMLWorkbook, CreateBackup:=False
    
wkcDaVez.Close SaveChanges:=True
    

'=====================================================================================

'=====================================================================================
' Região NORDESTE
Set wkcDaVez = Workbooks.Add
'PastaGeral = "C:\Users\ricardo.ramos\OneDrive - Ministerio do Desenvolvimento da Industria e Comercio Exterior\R-projects\DAMPE-SEMPE\Dados\"
PastaEspecifica = "REGIAO NORDESTE\" & MesReferencia
PASTA_DESTINO = PastaGeral & PastaEspecifica
arquivo = "REGIAO_NORDESTE_" & MesReferencia & ".xlsx"
NOME = PASTA_DESTINO & "\" & "REGIAO_NORDESTE_" & MesReferencia
 
wkcDaVez.Activate
    ChDir _
        PASTA_DESTINO
    ActiveWorkbook.SaveAs Filename:= _
        NOME _
        , FileFormat:=xlOpenXMLWorkbook, CreateBackup:=False

'ThisWorkbook.Activate
PlanilhaDestino.Activate
    Sheets(Array("CAGED", "Sumário", "Brasil", "Alagoas", "Bahia", "Ceará", "Maranhão", "Paraíba", "Pernambuco", "Piauí", "Rio_Grande_do_Norte", "Sergipe")).Copy Before:=Workbooks(arquivo).Sheets(1)

Sheets("Planilha1").Select
    ActiveWindow.SelectedSheets.Delete

'Excluindo planilha do Sumário
Sheets(2).Select
    ActiveWindow.SelectedSheets.Delete

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Insere aba Consolidadora da Região

Sheets(3).Copy After:=Sheets(2)
   
    Range("B6").Select
    ActiveCell.FormulaR1C1 = "=SUM('Alagoas:Sergipe'!RC)"
    
    
    Range("B6").Select
    Application.CutCopyMode = False
    Selection.Copy
    
    Range("B6,B8,B10,B10:B22,B24,B26,B28:B30,B32,B32:B38,B40,B42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    
    Range("C6,C8,C10,C10:C22,C24,C26,C28:C30,C32,C32:C38,C40,C42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    
    Range("D6,D8,D10,D10:D22,D24,D26,D28:D30,D32,D32:D38,D40,D42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    Range("E6,E8,E10,E10:E22,E24,E26,E28:E30,E32,E32:E38,E40,E42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    Range("F6,F8,F10,F10:F22,F24,F26,F28:F30,F32,F32:F38,F40,F42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    Range("G6,G8,G10,G10:G22,G24,G26,G28:G30,G32,G32:G38,G40,G42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False

    Sheets(3).Name = "Região Nordeste"

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''



Sheets(1).Select
Range("b12").Value = MesReferencia & " de " & ANO

PastaEspecifica = "REGIOES_POR_MES\" & MesReferencia
PASTA_DESTINO = PastaGeral & PastaEspecifica
NOME = PASTA_DESTINO & "\" & "REGIAO_NORDESTE_" & MesReferencia
    
wkcDaVez.Activate
    ChDir _
        PASTA_DESTINO
    ActiveWorkbook.SaveAs Filename:= _
        NOME _
        , FileFormat:=xlOpenXMLWorkbook, CreateBackup:=False
        
wkcDaVez.Close SaveChanges:=True
    
'=====================================================================================
'=====================================================================================
' Região SUDESTE
Set wkcDaVez = Workbooks.Add
'PastaGeral = "C:\Users\ricardo.ramos\OneDrive - Ministerio do Desenvolvimento da Industria e Comercio Exterior\R-projects\DAMPE-SEMPE\Dados\"
PastaEspecifica = "REGIAO SUDESTE\" & MesReferencia
PASTA_DESTINO = PastaGeral & PastaEspecifica
arquivo = "REGIAO_SUDESTE_" & MesReferencia & ".xlsx"
NOME = PASTA_DESTINO & "\" & "REGIAO_SUDESTE_" & MesReferencia

    
 wkcDaVez.Activate
    ChDir _
        PASTA_DESTINO
    ActiveWorkbook.SaveAs Filename:= _
        NOME _
        , FileFormat:=xlOpenXMLWorkbook, CreateBackup:=False
        
    
        
'ThisWorkbook.Activate
PlanilhaDestino.Activate
    Sheets(Array("CAGED", "Sumário", "Brasil", "Espírito_Santo", "Minas_Gerais", "Rio_de_Janeiro", "São_Paulo")).Copy Before:=Workbooks(arquivo).Sheets(1)
    
Sheets("Planilha1").Select
    ActiveWindow.SelectedSheets.Delete
    
'Excluindo planilha do Sumário
Sheets(2).Select
    ActiveWindow.SelectedSheets.Delete


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Insere aba Consolidadora da Região

Sheets(3).Copy After:=Sheets(2)
   
    Range("B6").Select
    ActiveCell.FormulaR1C1 = "=SUM('Espírito_Santo:São_Paulo'!RC)"
    
    
    Range("B6").Select
    Application.CutCopyMode = False
    Selection.Copy
    
    Range("B6,B8,B10,B10:B22,B24,B26,B28:B30,B32,B32:B38,B40,B42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    
    Range("C6,C8,C10,C10:C22,C24,C26,C28:C30,C32,C32:C38,C40,C42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    
    Range("D6,D8,D10,D10:D22,D24,D26,D28:D30,D32,D32:D38,D40,D42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    Range("E6,E8,E10,E10:E22,E24,E26,E28:E30,E32,E32:E38,E40,E42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    Range("F6,F8,F10,F10:F22,F24,F26,F28:F30,F32,F32:F38,F40,F42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    Range("G6,G8,G10,G10:G22,G24,G26,G28:G30,G32,G32:G38,G40,G42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False

    Sheets(3).Name = "Região Sudeste"

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''



Sheets(1).Select
Range("b12").Value = MesReferencia & " de " & ANO
    
PastaEspecifica = "REGIOES_POR_MES\" & MesReferencia
PASTA_DESTINO = PastaGeral & PastaEspecifica
NOME = PASTA_DESTINO & "\" & "REGIAO_SUDESTE_" & MesReferencia
    
wkcDaVez.Activate
    ChDir _
        PASTA_DESTINO
    ActiveWorkbook.SaveAs Filename:= _
        NOME _
        , FileFormat:=xlOpenXMLWorkbook, CreateBackup:=False
     
wkcDaVez.Close SaveChanges:=True
    
'=====================================================================================
'=====================================================================================
' Região SUL
Set wkcDaVez = Workbooks.Add
'PastaGeral = "C:\Users\ricardo.ramos\OneDrive - Ministerio do Desenvolvimento da Industria e Comercio Exterior\R-projects\DAMPE-SEMPE\Dados\"
PastaEspecifica = "REGIAO SUL\" & MesReferencia
PASTA_DESTINO = PastaGeral & PastaEspecifica
arquivo = "REGIAO_SUL_" & MesReferencia & ".xlsx"
NOME = PASTA_DESTINO & "\" & "REGIAO_SUL_" & MesReferencia

    
 wkcDaVez.Activate
    ChDir _
        PASTA_DESTINO
    ActiveWorkbook.SaveAs Filename:= _
        NOME _
        , FileFormat:=xlOpenXMLWorkbook, CreateBackup:=False
        
    
        
'ThisWorkbook.Activate
PlanilhaDestino.Activate
    Sheets(Array("CAGED", "Sumário", "Brasil", "Paraná", "Rio_Grande_do_Sul", "Santa_Catarina")).Copy Before:=Workbooks(arquivo).Sheets(1)
    
Sheets("Planilha1").Select
    ActiveWindow.SelectedSheets.Delete

'Excluindo planilha do Sumário
Sheets(2).Select
    ActiveWindow.SelectedSheets.Delete

Sheets(1).Select
Range("b12").Value = MesReferencia & " de " & ANO
    
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Insere aba Consolidadora da Região

Sheets(3).Copy After:=Sheets(2)
   
    Range("B6").Select
    ActiveCell.FormulaR1C1 = "=SUM('Paraná:Santa_Catarina'!RC)"
    
    
    Range("B6").Select
    Application.CutCopyMode = False
    Selection.Copy
    
    Range("B6,B8,B10,B10:B22,B24,B26,B28:B30,B32,B32:B38,B40,B42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    
    Range("C6,C8,C10,C10:C22,C24,C26,C28:C30,C32,C32:C38,C40,C42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    
    Range("D6,D8,D10,D10:D22,D24,D26,D28:D30,D32,D32:D38,D40,D42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    Range("E6,E8,E10,E10:E22,E24,E26,E28:E30,E32,E32:E38,E40,E42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    Range("F6,F8,F10,F10:F22,F24,F26,F28:F30,F32,F32:F38,F40,F42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    Range("G6,G8,G10,G10:G22,G24,G26,G28:G30,G32,G32:G38,G40,G42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False

    Sheets(3).Name = "Região Sul"

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    
PastaEspecifica = "REGIOES_POR_MES\" & MesReferencia
PASTA_DESTINO = PastaGeral & PastaEspecifica
NOME = PASTA_DESTINO & "\" & "REGIAO_SUL_" & MesReferencia
    
wkcDaVez.Activate
    ChDir _
        PASTA_DESTINO
    ActiveWorkbook.SaveAs Filename:= _
        NOME _
        , FileFormat:=xlOpenXMLWorkbook, CreateBackup:=False

wkcDaVez.Close SaveChanges:=True


' Região Centro Oeste

Set wkcDaVez = Workbooks.Add
'PastaGeral = "C:\Users\ricardo.ramos\OneDrive - Ministerio do Desenvolvimento da Industria e Comercio Exterior\R-projects\DAMPE-SEMPE\Dados\"
PastaEspecifica = "REGIAO CENTRO-OESTE\" & MesReferencia
PASTA_DESTINO = PastaGeral & PastaEspecifica
arquivo = "CENTRO_OESTE_" & MesReferencia & ".xlsx"
NOME = PASTA_DESTINO & "\" & "CENTRO_OESTE_" & MesReferencia

    
 wkcDaVez.Activate
    ChDir _
        PASTA_DESTINO
    ActiveWorkbook.SaveAs Filename:= _
        NOME _
        , FileFormat:=xlOpenXMLWorkbook, CreateBackup:=False
        
    
        
'ThisWorkbook.Activate
PlanilhaDestino.Activate
    Sheets(Array("CAGED", "Sumário", "Brasil", "Distrito_Federal", "Goiás", "Mato_Grosso_do_Sul", "Mato_Grosso")).Copy Before:=Workbooks(arquivo).Sheets(1)
    
Sheets("Planilha1").Select
    ActiveWindow.SelectedSheets.Delete

'Excluindo planilha do Sumário
Sheets(2).Select
    ActiveWindow.SelectedSheets.Delete
    
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Insere aba Consolidadora da Região

Sheets(3).Copy After:=Sheets(2)
   
    Range("B6").Select
    ActiveCell.FormulaR1C1 = "=SUM('Distrito_Federal:Mato_Grosso'!RC)"
    
    
    Range("B6").Select
    Application.CutCopyMode = False
    Selection.Copy
    
    Range("B6,B8,B10,B10:B22,B24,B26,B28:B30,B32,B32:B38,B40,B42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    
    Range("C6,C8,C10,C10:C22,C24,C26,C28:C30,C32,C32:C38,C40,C42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    
    Range("D6,D8,D10,D10:D22,D24,D26,D28:D30,D32,D32:D38,D40,D42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    Range("E6,E8,E10,E10:E22,E24,E26,E28:E30,E32,E32:E38,E40,E42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    Range("F6,F8,F10,F10:F22,F24,F26,F28:F30,F32,F32:F38,F40,F42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    
    Range("G6,G8,G10,G10:G22,G24,G26,G28:G30,G32,G32:G38,G40,G42").Select
    Selection.PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False

    Sheets(3).Name = "Região Centro Oeste"

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    

Sheets(1).Select
Range("b12").Value = MesReferencia & " de " & ANO
    
    
PastaEspecifica = "REGIOES_POR_MES\" & MesReferencia
PASTA_DESTINO = PastaGeral & PastaEspecifica
NOME = PASTA_DESTINO & "\" & "CENTRO_OESTE_" & MesReferencia
    
wkcDaVez.Activate
    ChDir _
        PASTA_DESTINO
    ActiveWorkbook.SaveAs Filename:= _
        NOME _
        , FileFormat:=xlOpenXMLWorkbook, CreateBackup:=False

wkcDaVez.Close SaveChanges:=True
    
         
    
    
MsgBox ("Necesita Atualizar links !!!")




   
    
End Sub


