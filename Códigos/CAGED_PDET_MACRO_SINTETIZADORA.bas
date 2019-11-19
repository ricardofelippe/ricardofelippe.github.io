Attribute VB_Name = "CAGED_PDET_MACRO_SINTETIZADORA"
' Cria��o: 05/09/2019
'Objetivo: Organizar dados para as diversas abas e criar respectivos gr�ficos.
' Particularidades: Necessita do arquivo fonte criado via script R

Sub Consolida_Dados()
Attribute Consolida_Dados.VB_ProcData.VB_Invoke_Func = " \n14"
'
' Consolida_Dados Macro
'

Application.ScreenUpdating = False

ThisWorkbook.Activate

Sheets(i + 1).Activate



NOME_ENTIDADES = Array("Brasil", "Regi�o Norte", "Regi�o Nordeste", "Regi�o Sudeste", "Regi�o Sul", "Regi�o Centro Oeste", "Rond�nia", "Acre", "Amazonas", "Roraima", "Par�", "Amap�", "Tocantins", "Maranh�o", "Piau�", "Cear�", "Rio Grande do Norte", "Para�ba", "Pernambuco", "Alagoas", "Sergipe", "Bahia", "Minas Gerais", "Esp�rito Santo", "Rio de Janeiro", "S�o Paulo", "Paran�", "Santa Catarina", "Rio Grande do Sul", "Mato Grosso do Sul", "Mato Grosso", "Goi�s", "Distrito Federal")

MsgBox ("ATUALIZAR A VARI�VEL M�S DE REFERE�NCIA E CRIAR PASTA DO M�S!!")
'MesReferencia = "Janeiro"
'MesReferencia = "Fevereiro"
'MesReferencia = "Maio"
'MesReferencia = "Junho"
'MesReferencia = "Julho"
'MesReferencia = "Agosto"
'MesReferencia = "Outubro"
MesReferencia = "Setembro"

ANO = "2019"




For i = 1 To 33
    




    'Brasil
    Windows("Compilado.xlsx").Activate
    Sheets(i).Activate
    Range("B2:G2").Select
    Selection.Copy
    'Windows("MPE_PDET_Agosto_2019.xlsm").Activate
    ThisWorkbook.Sheets(i + 1).Activate ' ATUALIZARRRRR
    
    
    

    'Sheets(i + 1).Activate

    Range("B6").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
    
    
    ' Organiza T�tulos
    NOME = UCase(NOME_ENTIDADES(i - 1))
    Range("a1").Value = "UF:" & NOME & "-EVOLU��O DO EMPREGO POR SETOR E SUBSETOR DE ATIVIDADE ECON�MICA"
    Range("a2").Value = "MICRO E PEQUENAS EMPRESAS(MPE) X M�DIAS E GRANDES EMPRESAS(MGE)"
    Range("a3").ClearContents
    Range("g3").ClearContents
    
    Range("b4").Value = "M�s/Ano* (" & MesReferencia & "/" & ANO & ") - sem ajuste"

    
    
    Range("a6").Value = NOME_ENTIDADES(i - 1)


    'Extrativa
    Windows("Compilado.xlsx").Activate
    Sheets(i).Activate
    Range("B3:G3").Select
    Selection.Copy
    ThisWorkbook.Sheets(i + 1).Activate ' ATUALIZARRRRR

'    Windows("MPE_PDET_Agosto_2019.xlsm").Activate
'    Sheets(i + 1).Activate

    Range("B8").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False

    'Industria
    Windows("Compilado.xlsx").Activate
    Sheets(i).Activate
    Range("B4:G16").Select
    Selection.Copy
    ThisWorkbook.Sheets(i + 1).Activate ' ATUALIZARRRRR

'    Windows("MPE_PDET_Agosto_2019.xlsm").Activate
'    Sheets(i + 1).Activate

    Range("B10").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False

   'SIUP
    Windows("Compilado.xlsx").Activate
    Sheets(i).Activate
    Range("B17:g17").Select
    Selection.Copy
'    Windows("MPE_PDET_Agosto_2019.xlsm").Activate
'    Sheets(i + 1).Activate
    ThisWorkbook.Sheets(i + 1).Activate ' ATUALIZARRRRR


    Range("B24").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False

'Constru��o
    Windows("Compilado.xlsx").Activate
    Sheets(i).Activate
    Range("B18:g18").Select
    Selection.Copy
    ThisWorkbook.Sheets(i + 1).Activate ' ATUALIZARRRRR

'    Windows("MPE_PDET_Agosto_2019.xlsm").Activate
'    Sheets(i + 1).Activate

    Range("B26").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False



'Com�rcio
    Windows("Compilado.xlsx").Activate
    Sheets(i).Activate
    Range("B19:g21").Select
    Selection.Copy
'    Windows("MPE_PDET_Agosto_2019.xlsm").Activate
'    Sheets(i + 1).Activate
ThisWorkbook.Sheets(i + 1).Activate ' ATUALIZARRRRR


    Range("B28").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False


'Servi�os
    Windows("Compilado.xlsx").Activate
    Sheets(i).Activate
    Range("B22:g28").Select
    Selection.Copy
'    Windows("MPE_PDET_Agosto_2019.xlsm").Activate
'    Sheets(i + 1).Activate
ThisWorkbook.Sheets(i + 1).Activate ' ATUALIZARRRRR


    Range("B32").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False


'Adm
 Windows("Compilado.xlsx").Activate
    Sheets(i).Activate
    Range("B29:g29").Select
    Selection.Copy
'    Windows("MPE_PDET_Agosto_2019.xlsm").Activate
'    Sheets(i + 1).Activate
ThisWorkbook.Sheets(i + 1).Activate ' ATUALIZARRRRR

    Range("B40").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False


'Adm
 Windows("Compilado.xlsx").Activate
    Sheets(i).Activate
    Range("B30:g30").Select
    Selection.Copy
'    Windows("MPE_PDET_Agosto_2019.xlsm").Activate
'    Sheets(i + 1).Activate
ThisWorkbook.Sheets(i + 1).Activate ' ATUALIZARRRRR

    Range("B42").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False

    'Windows("MPE_PDET_Agosto_2019.xlsm").Activate
    ThisWorkbook.Activate ' ATUALIZARRRRR




 



'    'Dados para gr�ficos 02
'
'ActiveCell.FormulaR1C1 = "SIUP"
'    Range("I28").Select
'    ActiveCell.FormulaR1C1 = "Servi�os"
'    Range("I29").Select
'    ActiveCell.FormulaR1C1 = "Ind�stria de Transforma��o"
'    Range("I30").Select
'    ActiveCell.FormulaR1C1 = "Extrativa Mineral"
'    Range("I31").Select
'    ActiveCell.FormulaR1C1 = "Constru��o"
'    Range("I32").Select
'    ActiveCell.FormulaR1C1 = "Com�rcio"
'    Range("I33").Select
'    ActiveCell.FormulaR1C1 = "Agropecu�ria"
'
'    Range("J26").Select
'    ActiveCell.FormulaR1C1 = "MGE"
'    Range("K26").Select
'    ActiveCell.FormulaR1C1 = "MPE"
'    Range("O33").Select
'    ActiveCell.FormulaR1C1 = ""
'    Range("P24").Select
'    Range("J27").Select
'    ActiveCell.FormulaR1C1 = "=R[-3]C[-6]"
'    Range("J28").Select
'    ActiveCell.FormulaR1C1 = "=R[4]C[-6]"
'    Range("J29").Select
'    ActiveCell.FormulaR1C1 = "=R[-19]C[-6]"
'    Range("J30").Select
'    ActiveCell.FormulaR1C1 = "=R[-22]C[-6]"
'    Range("J31").Select
'    ActiveCell.FormulaR1C1 = "=R[-5]C[-6]"
'    Range("J32").Select
'    ActiveCell.FormulaR1C1 = "=R[-4]C[-6]"
'    Range("J33").Select
'    ActiveCell.FormulaR1C1 = "=R[9]C[-6]"
'    Range("J27").Select
'    ActiveCell.FormulaR1C1 = "=R[-3]C[-8]"
'    Range("J28").Select
'    ActiveCell.FormulaR1C1 = "=R[4]C[-8]"
'    Range("J29").Select
'    ActiveCell.FormulaR1C1 = "=R[-19]C[-8]"
'    Range("J30").Select
'    ActiveCell.FormulaR1C1 = "=R[-22]C[-8]"
'    Range("J31").Select
'    ActiveCell.FormulaR1C1 = "=R[-5]C[-8]"
'    Range("J32").Select
'    ActiveCell.FormulaR1C1 = "=R[-4]C[-8]"
'    Range("J33").Select
'    ActiveCell.FormulaR1C1 = "=R[9]C[-8]"
'    Range("K27").Select
'    Range("K27").Select
'    ActiveCell.FormulaR1C1 = "=R[-3]C[71]"
'    Range("K27").Select
'    ActiveCell.FormulaR1C1 = "=R[-3]C[-8]"
'    Range("K28").Select
'    ActiveCell.FormulaR1C1 = "=R[4]C[-8]"
'    Range("K29").Select
'    ActiveCell.FormulaR1C1 = "=R[-19]C[-8]"
'    Range("K30").Select
'    ActiveCell.FormulaR1C1 = "=R[-22]C[-8]"
'    Range("K31").Select
'    ActiveCell.FormulaR1C1 = "=R[-5]C[-8]"
'    Range("K32").Select
'    ActiveCell.FormulaR1C1 = "=R[-4]C[-8]"
'    Range("K33").Select
'    ActiveCell.FormulaR1C1 = "=R[9]C[-8]"
'    Range("K27:K33").Select
'    Selection.AutoFill Destination:=Range("K27:N33"), Type:=xlFillDefault
'    Range("K27:N33").Select
'    Range("L27:L33").Select
'    Selection.ClearContents
'    Range("M26").Select
'    ActiveCell.FormulaR1C1 = "MGE"
'    Range("N26").Select
'    ActiveCell.FormulaR1C1 = "MPE"
'
'    Range("i10").Select
'    ActiveSheet.Shapes.AddChart2(216, xlBarClustered).Select
'
'    dados = "'" & NOME_ENTIDADES(i - 1) & "'" & "!$j$26:$k$33"
''    "PASTA_ORIGEM & "\" & NomePlanilha
''    "'Regi�o Norte'!$M$26:$N$33"
''
'
'    ActiveChart.SetSourceData Source:=Range(dados)
'
'
'
'dados = "=" & "'" & NOME_ENTIDADES(i - 1) & "'" & "!$I$27:$I$33"
' ActiveChart.Axes(xlCategory).Select
'    ActiveChart.FullSeriesCollection(1).XValues = dados
'
'ActiveSheet.ChartObjects("Gr�fico 1").Activate
'    ActiveChart.Axes(xlCategory).Select
'    ActiveChart.ChartArea.Select
'    ActiveChart.Axes(xlCategory).Select
'    ActiveChart.ChartArea.Select
'    ActiveChart.Axes(xlCategory).Select
'
'    Selection.TickLabelPosition = xlLow
'    Application.CommandBars("Format Object").Visible = False
'    ActiveChart.SetElement (msoElementDataLabelOutSideEnd)
'    ActiveChart.SetElement (msoElementPrimaryValueGridLinesNone)
'    ActiveChart.SetElement (msoElementPrimaryCategoryGridLinesMajor)
'    Range("P32").Select
'    ActiveSheet.ChartObjects("Gr�fico 1").Activate
'   ActiveChart.Axes(xlValue).Select
'    Selection.Delete
'    ActiveSheet.ChartObjects("Gr�fico 1").Activate
'    ActiveChart.ChartTitle.Select
'   Selection.Delete
'    ActiveSheet.ChartObjects("Gr�fico 1").Activate
'    ActiveSheet.Shapes("Gr�fico 1").IncrementTop -129.75
'    ActiveSheet.ChartObjects("Gr�fico 1").Activate
'    ActiveChart.Axes(xlCategory).Select
''    Selection.Format.TextFrame2.TextRange.Font.Bold = msoTrue
'    ActiveWorkbook.Save
'
'
'ActiveSheet.Shapes("Gr�fico 1").IncrementLeft 212.25
'    ActiveSheet.Shapes("Gr�fico 1").IncrementTop 427.5
'    ActiveSheet.Shapes("Gr�fico 1").ScaleWidth 1.3770833333, msoFalse, _
'        msoScaleFromTopLeft
'    ActiveSheet.Shapes("Gr�fico 1").ScaleHeight 1.2361111111, msoFalse, _
'        msoScaleFromTopLeft
'
'dados = NOME_ENTIDADES(i - 1) & "!$i$4:$j$7"
'
'Range("I4:J7").Select
'    ActiveSheet.Shapes.AddChart2(201, xlColumnClustered).Select
'   ' ActiveChart.SetSourceData Source:=Range(dados)
'    ActiveSheet.Shapes("Gr�fico 2").IncrementLeft 60
'    ActiveSheet.Shapes("Gr�fico 2").IncrementTop 45
'    ActiveChart.ChartTitle.Select
'    Selection.Delete
'    ActiveSheet.ChartObjects("Gr�fico 2").Activate
'    ActiveChart.PlotArea.Select
'    ActiveChart.Axes(xlValue).MajorGridlines.Select
'    Selection.Delete
'    ActiveChart.SetElement (msoElementDataLabelOutSideEnd)
'    Range("N8").Select
'
'
'  ActiveSheet.ChartObjects("Gr�fico 2").Activate
'    ActiveChart.PlotArea.Select
'    Selection.Left = 50.919
'    Selection.Top = 10
'    ActiveChart.ChartArea.Select
'
'
'
'    ActiveSheet.Shapes("Gr�fico 2").IncrementLeft 82.5
'    ActiveSheet.Shapes("Gr�fico 2").IncrementTop 11.5
'    ActiveSheet.Shapes("Gr�fico 2").ScaleWidth 1.2333333333, msoFalse, _
'        msoScaleFromTopLeft
'    ActiveSheet.Shapes("Gr�fico 2").ScaleHeight 1.0885418489, msoFalse, _
'        msoScaleFromTopLeft
'
'
'ActiveSheet.ChartObjects("Gr�fico 2").Activate
'    ActiveChart.PlotArea.Select
'    ActiveChart.Axes(xlCategory).Select
'    ActiveChart.Axes(xlCategory).Select
'    Selection.TickLabelPosition = xlLow

Next i


'

' Ajustes

    
    'ActiveWorkbook.Save
    
    MsgBox ("Dados gerados. Usar ""Salvar como"" para a identifica��o da planilha.")
    
    'Windows("MPE_PDET_Agosto_2019.xlsm").Activate
    ThisWorkbook.Activate ' ATUALIZARRRRR

     
   End Sub
