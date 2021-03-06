
'  Copyright 2011 Prof K.Sridharan
'  This file is part of SAP2
'
'    SAP2 is free software: you can redistribute it and/or modify
'    it under the terms of the GNU General Public License as published by
'    the Free Software Foundation, either version 3 of the License, or
'    (at your option) any later version.
'
'    SAP2 is distributed in the hope that it will be useful,
'    but WITHOUT ANY WARRANTY; without even the implied warranty of
'    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'    GNU General Public License for more details.
'
'   You should have received a copy of the GNU General Public License
'    along with SAP2.  If not, see <http://www.gnu.org/licenses/>.


VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form frmGridNode 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Nodal Data"
   ClientHeight    =   5880
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7395
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5880
   ScaleWidth      =   7395
   ShowInTaskbar   =   0   'False
   Begin VB.CommandButton Command1 
      Caption         =   "&Cancel"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   2280
      TabIndex        =   5
      Top             =   5280
      Width           =   1095
   End
   Begin VB.Frame frmDPC 
      Caption         =   "Enter the Node Details "
      BeginProperty Font 
         Name            =   "Comic Sans MS"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4575
      Left            =   360
      TabIndex        =   2
      Top             =   360
      Width           =   6615
      Begin VB.ComboBox Combo1 
         Height          =   315
         Left            =   2520
         TabIndex        =   4
         Top             =   960
         Visible         =   0   'False
         Width           =   1650
      End
      Begin VB.TextBox Text2 
         Height          =   195
         Left            =   1080
         TabIndex        =   3
         Top             =   600
         Visible         =   0   'False
         Width           =   855
      End
      Begin MSFlexGridLib.MSFlexGrid MSFlexGrid1 
         Height          =   3735
         Left            =   480
         TabIndex        =   0
         Top             =   480
         Width           =   5850
         _ExtentX        =   10319
         _ExtentY        =   6588
         _Version        =   393216
         Cols            =   5
         RowHeightMin    =   410
         WordWrap        =   -1  'True
         AllowUserResizing=   3
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "&OK"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3600
      TabIndex        =   1
      Top             =   5280
      Width           =   1095
   End
End
Attribute VB_Name = "frmGridNode"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Const TOTALCOLUMNS = 5  'Zero based
Private Sub cmdOK_Click()
Dim ii As Integer
Dim jj As Integer

 For ii = 1 To NNMAX Step 1
     For jj = 1 To 4 Step 1
        If IsEmpty(MSFlexGrid1.TextMatrix(ii, jj)) Then
         MsgBox "Data is not Complete, Please Check It !!"
         Exit Sub
        End If
     Next
 Next
 
 For ii = 1 To NNMAX Step 1
        If MSFlexGrid1.TextMatrix(ii, 2) = "" Then
         MsgBox "Data is not Complete, Please Check It !!"
         Exit Sub
        End If
 Next

 
 
 
For ii = 1 To NNMAX
   NNO(ii) = MSFlexGrid1.TextMatrix(ii, 1)
   NUSP(NNO(ii)) = MSFlexGrid1.TextMatrix(ii, 3)
   NDSP(NNO(ii)) = MSFlexGrid1.TextMatrix(ii, 4)
Next

 Me.Hide
 frmTranMainB.Enabled = True
 frmTranMainB.SetFocus
 frmTranMainB.cmdCont.Enabled = True
End Sub
Sub cmdOK_GotFocus()
   If Text2.Visible = True Then
       MSFlexGrid1 = Text2
       Text2.Visible = False
   ElseIf Combo1.Visible = True Then
       MSFlexGrid1 = Combo1
       Combo1.Visible = False
   End If
End Sub
Private Sub Combo1_Click()
      MSFlexGrid1 = Combo1
      Combo1.Visible = False
     If Combo1.Text = "Ordinary" Then
       NTYPE(MSFlexGrid1.Row) = 1
     ElseIf Combo1.Text = "Combining Junction" Then
       NTYPE(MSFlexGrid1.Row) = 2
     ElseIf Combo1.Text = "Dividing Junction" Then
       NTYPE(MSFlexGrid1.Row) = 3
     ElseIf Combo1.Text = "Delivery Reservoir" Then
       NTYPE(MSFlexGrid1.Row) = 4
     ElseIf Combo1.Text = "Source Reservoir" Then
       NTYPE(MSFlexGrid1.Row) = 5
     ElseIf Combo1.Text = "Condenser" Then
       frmMes.Show
       NTYPE(MSFlexGrid1.Row) = 6
     ElseIf Combo1.Text = "Obstruction" Then
       NTYPE(MSFlexGrid1.Row) = 7
     ElseIf Combo1.Text = "Pump with Sump" Then
       NTYPE(MSFlexGrid1.Row) = 8
     ElseIf Combo1.Text = "Online Booster" Then
       NTYPE(MSFlexGrid1.Row) = 9
     End If
       TYPEN(MSFlexGrid1.Row) = Combo1.Text
End Sub

Private Sub Command1_Click()
 MSFlexGrid1.Rows = NN + 1
 NNMAX = NN
 frmTranMainB.txtNoNodes.Text = NN
 Me.Hide
 frmTranMainB.Enabled = True
 frmTranMainB.SetFocus
 frmTranMainB.cmdCont.Enabled = True
End Sub

Private Sub Form_Load()
   Dim myArray As Variant
   Dim iCount As Integer
    Left = 20
    Top = 30
    Combo1.AddItem "Ordinary"
    Combo1.AddItem "Combining Junction"
    Combo1.AddItem "Dividing Junction"
    Combo1.AddItem "Delivery Reservoir"
    Combo1.AddItem "Source Reservoir"
    Combo1.AddItem "Condenser"
    Combo1.AddItem "Obstruction"
    Combo1.AddItem "Pump with Sump"
    Combo1.AddItem "Online Booster"

    MSFlexGrid1.Rows = NNMAX + 1
    myArray = Array("Sl. No.", "Node No.", "Type of Node", "No. of U/S Pipes", "No. of D/S Pipes")
  
   MSFlexGrid1.Cols = TOTALCOLUMNS  'Non-zero based
   MSFlexGrid1.FixedRows = 1
   MSFlexGrid1.FixedCols = 1
   MSFlexGrid1.FocusRect = flexFocusNone
   
   'add headings to grid
   MSFlexGrid1.Row = 0
   For iCount = 0 To TOTALCOLUMNS - 1 'Zero based
      MSFlexGrid1.ColWidth(iCount) = 950
      MSFlexGrid1.Col = iCount
      MSFlexGrid1.Text = myArray(iCount)
   Next iCount
  
   MSFlexGrid1.ColWidth(2) = 1650
   
  If NNMAX > 0 And Not OpenFile = "" Then
   For ii = 1 To MSFlexGrid1.Rows - 1
      MSFlexGrid1.TextMatrix(ii, 1) = NNO(ii)
      MSFlexGrid1.TextMatrix(ii, 2) = TYPEN(NNO(ii))
      MSFlexGrid1.TextMatrix(ii, 3) = NUSP(NNO(ii))
      MSFlexGrid1.TextMatrix(ii, 4) = NDSP(NNO(ii))
   Next
  End If

   'highlight 1st row
   HighLightGridRow (1)
  
End Sub
Private Sub HighLightGridRow(iRow As Integer)
   MSFlexGrid1.Col = 1
   MSFlexGrid1.Row = iRow
   MSFlexGrid1.ColSel = TOTALCOLUMNS - 1 'Zero Based
   MSFlexGrid1.RowSel = iRow
End Sub
Sub MSFlexGrid1_KeyPress(KeyAscii As Integer)
   If MSFlexGrid1.Col = 2 Then
     MSHFlexGridEdit MSFlexGrid1, Combo1, KeyAscii
     Combo1.Visible = True
   Else
     MSHFlexGridEdit MSFlexGrid1, Text2, KeyAscii
     Text2.Visible = True
   End If
End Sub
Sub MsFlexGrid1_DblClick()
  If MSFlexGrid1.Col = 2 Then
     MSHFlexGridEdit MSFlexGrid1, Combo1, 32
     Combo1.Visible = True
  Else
     MSHFlexGridEdit MSFlexGrid1, Text2, 32
     Text2.Visible = True
  End If
End Sub
Sub MSHFlexGridEdit(MSHFlexGrid As Control, _
Edt As Control, KeyAscii As Integer)

' Use the character that was typed.

   Select Case KeyAscii
   ' A space means edit the current text.
   Case 0 To 32
      Edt = MSHFlexGrid1
      Edt.SelStart = 1000
   ' Anything else means replace the current text.
   Case Else
      Edt = Chr(KeyAscii)
      Edt.SelStart = 1
      End Select
   ' Show Edt at the right place.
   
   If Not Edt = Combo1 Then
   Edt.Move MSHFlexGrid.Left + MSHFlexGrid.CellLeft, _
      MSHFlexGrid.Top + MSHFlexGrid.CellTop, _
      MSHFlexGrid.CellWidth - 8, _
      MSHFlexGrid.CellHeight - 8
   Else
   Edt.Move MSHFlexGrid.Left + MSHFlexGrid.CellLeft, _
      MSHFlexGrid.Top + MSHFlexGrid.CellTop
   End If
      
      Edt.Visible = True
      ' And make it work.
   Edt.SetFocus
   End Sub
Sub text2_KeyDown(KeyCode As Integer, _
Shift As Integer)
   EditKeyCode MSFlexGrid1, Text2, KeyCode, Shift
End Sub
Sub EditKeyCode(MSHFlexGrid As Control, Edt As _
Control, KeyCode As Integer, Shift As Integer)

   ' Standard edit control processing.
   Select Case KeyCode

   Case 27   ' ESC: hide, return focus to MSHFlexGrid.
      Edt.Visible = False
      MSFlexGrid1.SetFocus

   Case 13   ' ENTER return focus to MSHFlexGrid.
      MSFlexGrid1.SetFocus

   Case 37      ' Left
      MSFlexGrid1.SetFocus
      DoEvents
      If MSFlexGrid1.Col > MSFlexGrid1.FixedCols Then
         MSFlexGrid1.Col = MSFlexGrid1.Col - 1
      End If

   Case 38      ' Up.
      MSFlexGrid1.SetFocus
      DoEvents
      If MSFlexGrid1.Row > MSFlexGrid1.FixedRows Then
         MSFlexGrid1.Row = MSFlexGrid1.Row - 1
      End If
      
   Case 39      ' Right
      MSFlexGrid1.SetFocus
      DoEvents
      If MSFlexGrid1.Col < MSFlexGrid1.Cols - 1 Then
         MSFlexGrid1.Col = MSFlexGrid1.Col + 1
      End If
   
   Case 40      ' Down.
      MSFlexGrid1.SetFocus
      DoEvents
      If MSFlexGrid1.Row < MSFlexGrid1.Rows - 1 Then
         MSFlexGrid1.Row = MSFlexGrid1.Row + 1
      End If
   End Select
End Sub

Sub MSFlexGrid1_GotFocus()
   If Text2.Visible = False And Combo1.Visible = False Then
   Exit Sub
   ElseIf Text2.Visible = True Then
     MSFlexGrid1 = Text2
     Text2.Visible = False
   ElseIf Combo1.Visible = True Then
     MSFlexGrid1 = Combo1
     Combo1.Visible = False
   End If
   'MSFlexGrid1.Sort = 1
End Sub
Sub MSFlexGrid1_LeaveCell()
   
   If Text2.Visible = False And Combo1.Visible = False Then
   Exit Sub
   ElseIf Text2.Visible = True Then
     MSFlexGrid1 = Text2
     Text2.Visible = False
   ElseIf Combo1.Visible = True Then
     MSFlexGrid1 = Combo1
     Combo1.Visible = False
   End If
End Sub
Sub LeaveCell()
   If MSFlexGrid1.Col = 3 Then
     MSFlexGrid1 = Text2
     Text2.Visible = False
     NoNode = MSFlexGrid1.TextMatrix(MSFlexGrid1.Row, 1)
     NUSP(NoNode) = Val(MSFlexGrid1)
    If NUSP(NoNode) > 0 Then
      frmGridUS.Show
      TYPEROW = MSFlexGrid1.TextMatrix(MSFlexGrid1.Row, 0)
      Me.Enabled = False
    End If
   End If
   
   If MSFlexGrid1.Col = 4 Then
     MSFlexGrid1 = Text2
     Text2.Visible = False
     NoNode = MSFlexGrid1.TextMatrix(MSFlexGrid1.Row, 1)
     NDSP(NoNode) = Val(MSFlexGrid1)
    If NDSP(NoNode) > 0 Then
     frmGridDS.Show
     Me.Enabled = False
    End If
   End If
End Sub
Private Sub text2_KeyPress(KeyAscii As Integer)
' Delete returns to get rid of beep.
   If KeyAscii = Asc(vbCr) Then KeyAscii = 0
End Sub
Private Sub Form_Activate()
MSFlexGrid1.Rows = NNMAX + 1
   For i = 1 To MSFlexGrid1.Rows - 1
       MSFlexGrid1.TextMatrix(i, 0) = i
   Next
End Sub
Private Sub Text2_KeyUp(KeyCode As Integer, Shift As Integer)
LeaveCell
End Sub


