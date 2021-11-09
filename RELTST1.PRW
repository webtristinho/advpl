#INCLUDE 'protheus.ch'
#INCLUDE 'topconn.ch'

//author: @webtristinho

User Function RELTST1()
	Private oReport := Nil
	Private oSecCab := Nil
	Private cPerg:= Padr("123456789",10)
    Pergunte(cPerg,.F.)
	ReportDef()
	oReport:PrintDialog()
Return

Static Function ReportDef()
	oReport := TReport():New("Relatório Financeiro","Relatório Financeiro",cPerg,{|oReport| PrintReport(oReport)},"Relatório Financeiro")
	oReport:SetLandscape(.T.)
	oSecCab := TRSection():New( oReport , "Relatório Financeiro", {"QRY"} )
	TRCell():New( oSecCab, "DEBITO"    , "QRY")
	TRCell():New( oSecCab, "CT2_CCC"    , "QRY")
	TRCell():New( oSecCab, "CT2_CCD"    , "QRY")
	TRCell():New( oSecCab, "CT2_DEBITO"    , "QRY")
	TRCell():New( oSecCab, "CT2_CREDIT"    , "QRY")
	TRCell():New( oSecCab, "CT2_AT02DB"    , "QRY")
	TRCell():New( oSecCab, "CT2_AT03DB"    , "QRY")
	TRCell():New( oSecCab, "E2_NOMFOR"    , "QRY")
	TRCell():New( oSecCab, "NOME_FORN_A2"    , "QRY")
	TRCell():New( oSecCab, "CT2_AT01DB"    , "QRY")
	TRCell():New( oSecCab, "TIPO"    , "QRY")
	TRCell():New( oSecCab, "GR_CONTA"    , "QRY")
	TRCell():New( oSecCab, "CT2_DEBITO"    , "QRY")
	TRCell():New( oSecCab, "DESC_CONTA"    , "QRY")
	TRCell():New( oSecCab, "CT2_HIST"    , "QRY")
	TRCell():New( oSecCab, "GERENCIA"    , "QRY")
	TRCell():New( oSecCab, "CT2_CCD"    , "QRY")
	TRCell():New( oSecCab, "DESC_CC"    , "QRY")
	TRCell():New( oSecCab, "E2_EMISSAO"    , "QRY")
	TRCell():New( oSecCab, "CT2_DATA"    , "QRY")
	TRCell():New( oSecCab, "E2_VENCREA"    , "QRY")
	TRCell():New( oSecCab, "E2_BAIXA"    , "QRY")
	TRCell():New( oSecCab, "DT_REAL"    , "QRY")
	TRCell():New( oSecCab, "E2_PARCELA"    , "QRY")
	TRCell():New( oSecCab, "RATEIO"    , "QRY")
	TRCell():New( oSecCab, "RATEIO_PERC"    , "QRY")
	TRCell():New( oSecCab, "CT2_VALOR"    , "QRY")
	TRCell():New( oSecCab, "E2_VALOR"    , "QRY")
	TRCell():New( oSecCab, "VR_REAL"    , "QRY")
Return

Static Function PrintReport(oReport)

oSecCab:BeginQuery()

BeginSql alias 'CT2'

SELECT *
FROM(
SELECT
'DEBITO' DEBITO,
CT2_CCC,
CT2_CCD,
CT2_DEBITO,
CT2_CREDIT,
CT2_AT02DB,
CT2_AT03DB,
E2_NOMFOR,
isnull((select A2_NOME From SA2200 where D_E_L_E_T_ !='*' and A2_COD =  CT2_AT02DB and A2_LOJA = CT2_AT03DB ), ' ') NOME_FORN_A2,
CT2_AT01DB,

case 
when CT2_DEBITO IN ('41117101','41117102','41117200','41117201','41117204','41117205','41117206','41117207','41117208','41117210','41117250','41117251','41117254','41117212') THEN 'Labor'
when CT2_DEBITO IN ('41116101','41116102','41116103','41116104','41116105','41116107','41116109','41116110','41116201','41117100','41116115','41116202','41116206','41116207','41116208','41116209','41116210','41116213','41116401','41116404','41116406','41116407','41116408','41116409','41116410','41116411','41116413','41116414','41116415','41116417','41116419','41116420','41116421','41116422','41116423','41116424','41116425','41116427','41116429','41116430','41116433','41117209','41117211','41117301','41117302','41117304','41117305') Then 'Overhead'
when CT2_DEBITO IN ('41116116','41116402','41116403','41116405','41116409','41116418','41116426','41116434','41116435','41116436','41116437','41116438','41116441','41117999') Then 'Não controlável'
when CT2_DEBITO IN ('41116428','41116104','41116424','41116433') Then 'Não produto'
when CT2_DEBITO IN ('41116110','41116112','41116210','41116412') Then 'Produto'
when CT2_DEBITO IN ('41116202','41116408') Then 'Estrutura'
else 'Classificar'
end TIPO,

case
when CT2_DEBITO IN ('41117101','41117200','41117204','41117205','41117207','41117208','41117210','41117250','41117251','41117254','41117212') THEN 'Salários'
when CT2_DEBITO IN ('41117102') THEN 'Horas Extras'
when CT2_DEBITO IN ('41117206') THEN '13º Salário'
when CT2_DEBITO IN ('41117201') THEN 'Férias'
when CT2_DEBITO IN ('41116406') THEN 'Comunicação'
when CT2_DEBITO IN ('41116407','41116207','41116208') THEN 'Carros da empresa'
when CT2_DEBITO IN ('41116414') THEN 'Educação de Funcionários'
when CT2_DEBITO IN ('41116412','41116115','41116417','41116112') THEN 'Frete'
when CT2_DEBITO IN ('41116410') THEN 'Combustível'
when CT2_DEBITO IN ('41116422') THEN 'Seguro de automóvel'
when CT2_DEBITO IN ('41116420') THEN 'Material de manutenção'
when CT2_DEBITO IN ('41116423') THEN 'Serviços adquiridos'
when CT2_DEBITO IN ('41116201','41117100','41116213','41116401','41116411') THEN 'Serviços contratados'
when CT2_DEBITO IN ('41116415','41116425') THEN 'Pedágios'
when CT2_DEBITO IN ('41116101','41116102','41116103','41116105') THEN 'Ferramentas'
when CT2_DEBITO IN ('41116421') THEN 'Despesas de viagem'
when CT2_DEBITO IN ('41117301') THEN 'Plano de saúde'
when CT2_DEBITO IN ('41116429','41117305') THEN 'Alimentação'
when CT2_DEBITO IN ('41117302','41117304') THEN 'Vale transporte'
when CT2_DEBITO IN ('41116107','41116109','41117209','41117211') THEN 'Gratificações/Premiações'
when CT2_DEBITO IN ('41116206','41116209','41116404','41116413','41116419','41116104','41116430') THEN 'Outros'
when CT2_DEBITO IN ('41116116','41116402','41116403','41116405','41116409','41116418','41116426','41116434','41116435','41116436','41116437','41116438','41116441','41117999','41116427') THEN 'Não controlável'
when CT2_DEBITO IN ('41116424','41116433') THEN 'Não produto'
when CT2_DEBITO IN ('41116428') THEN 'Contencioso'
when CT2_DEBITO IN ('41116110') THEN 'Comissao'
when CT2_DEBITO IN ('41116202','41116210') THEN 'Impostos'
when CT2_DEBITO IN ('41116408') THEN 'Manutenção'
else 'A Classificar'
end GR_CONTA, 

isnull((select CT1_DESC01 From CT1200 where D_E_L_E_T_ !='*' and CT1_CONTA = CT2_DEBITO ), ' ') DESCR_CONTA,
CT2_HIST,

case
when CT2_CCD IN ('5900','5950','5590') THEN 'CORPORATIVO'
when CT2_CCD IN ('5060','5080','5250','5020','5040','4005','5090','5030','5050','5015','5100','5670','5110','5600','5400','2400','4001','5610','4004') THEN 'GERENCIA ADM'
when CT2_CCD IN ('5200','2100','2015','2320','2300','2050','1520','1550','5500','2220','5540','5730','5650','5620','1521','1551','2260','2280') THEN 'GERENCIA INDL'
when CT2_CCD IN ('8117','8115','8107','8301','8215','8213','8209','8395','8315','8313','8309','6030','8101','4705','4899','4617','8802','4619','4629','4621','4615','4609','4605','4603','4299','8015','7015','4599','8605','8207','8105','8303','8010','6010','7005','4399','8005','5700','6399','6299','8799','8399','8599','6305','6302','6303','6304','6301','7020','7050','8601','8613','8800','4699','4799','4792','8611','8803','8805','8809','8810','8821','8823','8831','8837','8848','8862','8201','8203','8205','8401','8603','8801','5710','4803','4805','8815','6201','6205','6207','6209','6211','8807','8820','8840','8843','4305','4310','4311','4312','4313','4315','4506','4505','4508','4510','4512','4508','4516','4521','4532','4304','4314','4504','4507','4526','4527','4528','4531','4533','4534','4535','4536','4601','4607','4611','4613','4690','4700','4701','4703','4707','4709','4713','4715','4791','4911','4915','4991','4993','4999','6101','6200','6203','7070','8100') THEN 'GERENCIA COML'
when CT2_CCD IN ('5010','5350','8999','8961','8963','8973','8965') THEN 'DIRETORIA'
else 'A Classificar'
end GERENCIA,

isnull((select CTT_DESC01 From CTT200 where D_E_L_E_T_ !='*' and CTT_CUSTO = CT2_CCD ), ' ') DESCR_CC,
E2_EMISSAO,
CT2_DATA,
E2_VENCREA,
E2_BAIXA,
convert(date, CASE WHEN E2_VENCREA IS NULL THEN CT2_DATA ELSE E2_VENCREA END, 102) DT_REAL,
E2_PARCELA,

isnull((select distinct D1_RATEIO 
		From SD1200
		where D_E_L_E_T_ !='*' 
		and D1_FORNECE=  CT2_AT02DB
		and D1_DOC = CT2_AT01DB ), ' ') RATEIO,

isnull((select distinct DE_PERC 
		From SDE200
		where D_E_L_E_T_ !='*' 
		and DE_FORNECE =  CT2_AT02DB
		and DE_LOJA = CT2_AT03DB
		and DE_CC =  CT2_CCD
		and DE_DOC = CT2_AT01DB ), ' ') RATEIO_PERC,
	

CT2_VALOR,
E2_VALOR,

		CASE WHEN isnull((select distinct DE_PERC 
						  From SDE200
						  where D_E_L_E_T_ !='*' 
						  and DE_FORNECE =  CT2_AT02DB
						  and DE_CC =  CT2_CCD
						  and DE_DOC = CT2_AT01DB ), ' ') > 0 THEN  isnull((select distinct DE_PERC 
																					From SDE200
																					where D_E_L_E_T_ !='*' 
																					and DE_FORNECE =  CT2_AT02DB
																					and DE_CC =  CT2_CCD
																					and DE_DOC = CT2_AT01DB ), ' ') /100 * E2_VALOR 
			 WHEN E2_PARCELA != '  ' AND 
			 isnull((select distinct DE_PERC 
						  From SDE200
						  where D_E_L_E_T_ !='*' 
						  and DE_FORNECE =  CT2_AT02DB
						  and DE_CC =  CT2_CCD
						  and DE_DOC = CT2_AT01DB ), ' ') = '0'  THEN E2_VALOR


			 WHEN E2_PARCELA = '  ' AND 
			 isnull((select distinct DE_PERC 
						  From SDE200
						  where D_E_L_E_T_ !='*' 
						  and DE_FORNECE =  CT2_AT02DB
						  and DE_CC =  CT2_CCD
						  and DE_DOC = CT2_AT01DB ), ' ') = '0'  THEN CT2_VALOR

			 ELSE CT2_VALOR
			 END VR_REAL

FROM CT2200 CT2
LEFT JOIN SE2200 E2 on E2_NUM = CT2_AT01DB and E2_LOJA = CT2_AT03DB and E2_FORNECE = CT2_AT02DB and E2.D_E_L_E_T_ !='*' WHERE CT2.D_E_L_E_T_ <> '*') as x

WHERE x.E2_VENCREA >= %exp:MV_PAR01%
AND x.E2_VENCREA <= %exp:MV_PAR02%
AND x.CT2_CCD >= %exp:MV_PAR03%
AND x.CT2_CCD <= %exp:MV_PAR04%
AND x.CT2_DEBITO >= %exp:MV_PAR05%
AND x.CT2_DEBITO <= %exp:MV_PAR06%
AND x.CT2_DATA >= %exp:MV_PAR07%
AND x.CT2_DATA <= %exp:MV_PAR08%
AND x.DT_REAL >= %exp:MV_PAR09%
AND x.DT_REAL <= %exp:MV_PAR10%
AND CT2_CCD <> ' '

EndSql
	oSecCab:EndQuery()
	oSecCab:Print()
Return
