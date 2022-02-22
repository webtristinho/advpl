#Include "PROTHEUS.CH" 

//ALTERAR BUDGET
//WEBTRISTINHO 10/02/2022

user function MT120BRW
AADD( aRotina, { 'Alterar Budget', 'U_DOMALTC7()', 6, 0 })
return

User Function DOMALTC7()

Static oDlg
Static oButton1
Static oCheckBox1
Static lCheckBox1 := .F.
Static oGet1
Static dGet1 := SC7->C7_XBUDGET
Static oSay1

dGet1 := SC7->C7_XBUDGET

  DEFINE MSDIALOG oDlg TITLE "Budget" FROM 000, 000  TO 100, 200 COLORS 0, 16777215 PIXEL

    @ 014, 018 MSGET oGet1 VAR dGet1 SIZE 060, 010 OF oDlg COLORS 0, 16777215 PIXEL
    @ 035, 030 BUTTON oButton1 PROMPT "Confirmar" SIZE 037, 012 ACTION AltData() OF oDlg PIXEL
    @ 004, 004 SAY oSay1 PROMPT "Budget" SIZE 093, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 026, 024 CHECKBOX oCheckBox1 VAR lCheckBox1 PROMPT "Pedido Inteiro" SIZE 048, 008 OF oDlg COLORS 0, 16777215 PIXEL
    
  ACTIVATE MSDIALOG oDlg

Return

Static Function AltData()
	
	Local cNumPed := ""
	Local _cFilPed := ""
	Local aAreaSC7 := {}

	cNumPed := SC7->C7_NUM
	_cFilPed := SC7->C7_FILIAL

	If lCheckBox1
		
		aAreaSC7 := GetArea("SC7")
		
		SC7->(DbSetOrder(1))
		SC7->(DbGoTop())
		If SC7->(DbSeek(_cFilPed+cNumPed))
			While SC7->(!Eof()) .And. SC7->C7_NUM == cNumPed
				If RecLock("SC7",.F.)
					SC7->C7_XBUDGET := dGet1
					SC7->(MsUnlock())
					oDlg:End()
				EndIf
				SC7->(DbSkip())
			EndDo
			FWAlertSuccess("Budget alterado com sucesso!")
			oDlg:End()
		EndIf
		
		RestArea(aAreaSC7)
	
	Else

		If RecLock("SC7",.F.)
			SC7->C7_XBUDGET := dGet1
			SC7->(MsUnlock())
			FWAlertSuccess("Budget alterado com sucesso!")
			oDlg:End()
		EndIf
		
	EndIf

Return
