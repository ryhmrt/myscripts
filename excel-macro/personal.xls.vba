'
' 選択領域の行毎にセルを横に結合する
'
Sub セル横結合()
    Application.ScreenUpdating = False
    Application.DisplayAlerts = False
    Dim TopRow As Integer, LeftCol As Integer, BottomRow As Integer, RightCol As Integer
    Dim i As Integer
    TopRow = Selection.Row
    LeftCol = Selection.Column
    BottomRow = Selection.Row + Selection.Rows.Count - 1
    RightCol = Selection.Column + Selection.Columns.Count - 1
    For i = TopRow To BottomRow
        Range(Cells(i, LeftCol), Cells(i, RightCol)).Merge
    Next
    Application.DisplayAlerts = True
    Application.ScreenUpdating = True
End Sub

'
' 選択領域のセルを結合する
'
Sub セル結合()
    Application.DisplayAlerts = False
    Selection.Merge
    Application.DisplayAlerts = True
End Sub

'
' 選択領域のセルの結合を解除する
'
Sub セル結合解除()
    Application.DisplayAlerts = False
    Selection.UnMerge
    Application.DisplayAlerts = True
End Sub

'
' 選択領域中の同じ値のセルを縦に結合する
'
Sub 同値セル結合()
    Application.ScreenUpdating = False
    Application.DisplayAlerts = False
    Dim r As Integer '最終行番号
    Dim c As Integer '列番号
    Dim i As Integer
    Dim j As Integer
    r = Selection.Row + Selection.Rows.Count - 1
    c = Selection.Column
    j = Selection.Row
    For i = Selection.Row + 1 To r
        If Cells(i, c).Value = Cells(j, c).Value Then
            Range(Cells(j, c), Cells(i, c)).Merge
        Else
            j = i
        End If
    Next
    Application.DisplayAlerts = True
    Application.ScreenUpdating = True
End Sub

'
' 選択領域中の空白セルを上のセルと結合する
'
Sub 空白セル結合()
    Application.ScreenUpdating = False
    Application.DisplayAlerts = False
    Dim r As Integer '最終行番号
    Dim c As Integer '列番号
    Dim i As Integer
    Dim j As Integer
    r = Selection.Row + Selection.Rows.Count - 1
    c = Selection.Column
    j = Selection.Row
    For i = Selection.Row + 1 To r
        If Cells(i, c) = "" Then
            Range(Cells(j, c), Cells(i, c)).Merge
        Else
            j = i
        End If
    Next
    Application.DisplayAlerts = True
    Application.ScreenUpdating = True
End Sub

'
' 条件付き書式を使って行毎に色を変える
'
Sub 行毎に色を変える()
    Application.ScreenUpdating = False
    Selection.FormatConditions.Delete
    Selection.FormatConditions.Add Type:=xlExpression, Formula1:= _
        "=MOD(ROW(),2)=1"
    Selection.FormatConditions(1).Interior.ColorIndex = 34
    Application.ScreenUpdating = True
End Sub

'
' 条件付き書式を使って行毎に色を変える（色反転版）
'
Sub 行毎に色を変える_逆バージョン()
    Application.ScreenUpdating = False
    Selection.FormatConditions.Delete
    Selection.FormatConditions.Add Type:=xlExpression, Formula1:= _
        "=MOD(ROW(),2)=0"
    Selection.FormatConditions(1).Interior.ColorIndex = 34
    Application.ScreenUpdating = True
End Sub

'
' 条件付き書式の設定をクリアする
'
Sub 条件付書式クリア()
    Selection.FormatConditions.Delete
End Sub
