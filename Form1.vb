Public Class Form1
  
  
    Private Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click

        If (System.IO.File.Exists("TerrariaOriginalBackup.exe")) Then 'sprawdza czy istnieje plik
            Process.Start("TerrariaOriginalBackup.exe") 'jeśli istnieje uruchom
        Else
            MsgBox("Nie znalazłem gry") 'jeśli nie istnieje pokaz komunikat
        End If

    End Sub



    Private Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click

        If (System.IO.File.Exists("Terrariapl.exe")) Then 'sprawdza czy istnieje plik
            Process.Start("Terrariapl.exe") 'jeśli istnieje uruchom
        Else
            MsgBox("Nie znalazłem gry") 'jeśli nie istnieje pokaz komunikat
        End If
    End Sub

    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub



    Private Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
        End
    End Sub

    Private Sub WyjdźToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles WyjdźToolStripMenuItem.Click
        End
    End Sub

    Private Sub SzukajAktualizcjiToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SzukajAktualizcjiToolStripMenuItem.Click
        If (System.IO.File.Exists("Aktualizator.exe")) Then 'sprawdza czy istnieje plik
            Process.Start("Aktualizator.exe") 'jeśli istnieje uruchom
            End
        Else
            MsgBox("Nie znalazłem Programu") 'jeśli nie istnieje pokaz komunikat
        End If
    End Sub

    Private Sub Button4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button4.Click
        If (System.IO.File.Exists("tconfig.exe")) Then 'sprawdza czy istnieje plik
            Process.Start("Tconfig.exe") 'jeśli istnieje uruchom
        Else
            MsgBox("Nie znalazłem gry") 'jeśli nie istnieje pokaz komunikat
        End If
    End Sub

    Private Sub Button5_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button5.Click
        If (System.IO.File.Exists("TehModApi.exe")) Then 'sprawdza czy istnieje plik
            Process.Start("TehModApi.exe") 'jeśli istnieje uruchom
        Else
            MsgBox("Nie znalazłem gry") 'jeśli nie istnieje pokaz komunikat
        End If
    End Sub
End Class
