#INCLUDE 'protheus.ch'
#INCLUDE 'topconn.ch'

//author: @webtristinho 16/08/2021

User Function RELTST2()
	Private oReport := Nil
	Private oSecCab := Nil
	Private cPerg:= Padr("RELTST2",10)
    Pergunte(cPerg,.F.)
	ReportDef()
	oReport:PrintDialog()
Return

Static Function ReportDef()
	oReport := TReport():New("Relatório Ped. Venda","Relatório Ped. Venda",cPerg,{|oReport| PrintReport(oReport)},"Relatório Ped. Venda")
	oReport:SetLandscape(.T.)
	oSecCab := TRSection():New( oReport , "Relatório Ped. Venda", {"QRY"} )
	TRCell():New( oSecCab, "SC9_FILIAL"    , "QRY")
	TRCell():New( oSecCab, "C9_PEDIDO"    , "QRY")
	TRCell():New( oSecCab, "C9_ITEM"    , "QRY")
	TRCell():New( oSecCab, "C9_CLIENTE"    , "QRY")
	TRCell():New( oSecCab, "C9_LOJA"    , "QRY")
	TRCell():New( oSecCab, "C9_PRODUTO"    , "QRY")
	TRCell():New( oSecCab, "C9_QTDLIB"    , "QRY")
	TRCell():New( oSecCab, "STATUS_PEDIDO"    , "QRY")
Return

Static Function PrintReport(oReport)

oSecCab:BeginQuery()

BeginSql alias 'SC9'

SELECT 
 
C9_FILIAL FILIAL,
C9_PEDIDO PEDIDO,
C9_ITEM ITEM,
C9_CLIENTE CLIENTE,
C9_LOJA LOJA,
C9_PRODUTO PRODUTO,
C9_QTDLIB QUANTIDADE,
 
    case 
 
  when c9.C9_BLEST = '02' and c9.C9_BLCRED = '  ' then 'BLOQ_ESTOQUE'
  when c9.C9_BLEST = '02' and c9.C9_BLCRED = '01' then 'BLOQ_CRÉDITO'
  when c9.C9_BLCRED = '09' then 'FINANCEIRO_REJEITADO'
  when c9.C9_BLEST = '  ' and c9.C9_BLCRED = '  ' and c9.C9_CARGA = '      ' then 'MONTAGEM_CARGA'
  when c9.C9_BLEST = '  ' and c9.C9_BLCRED = '  ' then 'PEDIDO_SEM_CARGA' 
  when c9.C9_CARGA != '      'and c9.C9_BLWMS = '01' then 'EXPEDICAO' 
  when c9.C9_CARGA != '      ' and c9.C9_BLWMS = '05' then 'FATURAMENTO' 
 
else 'N/A'
  end as STATUS_PEDIDO
 
From SC9200 c9
WHERE C9_PEDIDO >= %exp:MV_PAR01%
AND C9_PEDIDO <= %exp:MV_PAR02%
and c9.D_E_L_E_T_ != '*'

EndSql
	oSecCab:EndQuery()
	oSecCab:Print()
Return
