Attribute VB_Name = "Module2"

'FUNKCJE API U¯YWANE PRZEZ PROGRAM
'Czêœæ procedury zosta³a pobrana z Internetu-st¹d miejscami opisy w jêzyku angielskim
'-------------------------------------------------------------
'konwertuj d³ugie nazwy plików do postaci czytelnej dla DOS tj. 8.3.
Public Declare Function GetShortPathName Lib "kernel32" Alias "GetShortPathNameA" (ByVal lpszLongPath As String, ByVal lpszShortPath As String, ByVal cchBuffer As Long) As Long
'wyœwiet treœæ komunikatu o b³êdzie MCI
Public Declare Function mciGetErrorString Lib "winmm.dll" Alias "mciGetErrorStringA" (ByVal dwError As Long, ByVal lpstrBuffer As String, ByVal uLength As Long) As Long
'wyœlij polecenia do urz¹dzenia MCI - odtwarza min. dŸwiêk
Public Declare Function mciSendString Lib "winmm.dll" Alias "mciSendStringA" (ByVal lpstrCommand As String, ByVal lpstrReturnString As String, ByVal uReturnLength As Long, ByVal hwndCallback As Long) As Long
'-------------------------------------------------------------

Public mvarMP3File As String   'œcie¿ka do pliku mp3
Public AliasName As String     'przechowuje nazwê aliasu otwartego pliku
Public Result As String        'przechowuje wynik naszych dzia³añ

'struktura zawieraj¹ca dane pochodz¹ce z wnêtrza pliku mp3;
'struktura wype³niana jest informacjami w momencie wywo³ania
'procedury ReadMP3()
Public Type MP3Info
    Bitrate As Integer
    Frequency As Long
    Mode As String
    Emphasis As String
    MpegVersion As Integer
    MpegLayer As Integer
    Padding As String
    CRC As String
    Duration As Long
    CopyRight As String
    Original As String
    PrivateBit As String
    HasTag As Boolean
    Tag As String
    SongName As String
    Artist As String
    Album As String
    Year As String
    Comment As String
    Genre As Integer
    Track As String
    VBR As Boolean
    Frames As Integer
End Type

'struktura przechwytuje ró¿ne informacje z za³adowanego do
'pamiêci pliku mp3
Public GetMP3Info As MP3Info

Public Function BinToDec(BinValue As String) As Long
'procedura konwertuje wartoœæ binarn¹ na dziesiêtn¹
    BinToDec = 0
    For i = 1 To Len(BinValue)
        If Mid(BinValue, i, 1) = 1 Then
            BinToDec = BinToDec + 2 ^ (Len(BinValue) - i)
        End If
    Next i
    
End Function

Public Function ByteToBit(ByteArray) As String
'procedura konwertuje tablicê bajtów 4*1 do 4*8 bitów
    ByteToBit = ""
    For z = 1 To 4
        For i = 7 To 0 Step -1
            If Int(ByteArray(z) / (2 ^ i)) = 1 Then
                ByteToBit = ByteToBit & "1"
                ByteArray(z) = ByteArray(z) - (2 ^ i)
            Else
                If ByteToBit <> "" Then
                    ByteToBit = ByteToBit & "0"
                End If
            End If
        Next
    Next z
    
End Function

Public Function BinaryHeader(FileName As String, ReadTag As Boolean, ReadHeader As Boolean) As String
    
    Dim ByteArray(4) As Byte
    Dim XingH As String * 4
    Dim x As Byte

    FIO% = FreeFile
    Open FileName For Binary Access Read As FIO%
    N& = LOF(FIO%): If N& < 256 Then Close FIO%: Return 'ny
    If ReadHeader = False Then GoTo 5:   'if we only want to read the IDtag goto 5

    '''''start check startposition for header''''''''''''
    '''''if start position <>1 then id3v2 tag exists'''''
    For i = 1 To 5000            'check up to 5000 bytes for the header
        Get #FIO%, i, x
        If x = 255 Then             'header always start with 255 followed by 250 or 251
            Get #FIO%, i + 1, x
            If x > 249 And x < 252 Then
                Headstart = i       'set header start position
                Exit For
            End If
        End If
    Next i
    '''end check start position for header'''''''''''''

   'start check for XingHeader'''
    Get #1, Headstart + 36, XingH
    If XingH = "Xing" Then
        GetMP3Info.VBR = True
        For z = 1 To 4 '
            Get #1, Headstart + 43 + z, ByteArray(z)  'get framelength to array
        Next z
        Frames = BinToDec(ByteToBit(ByteArray))   'calculate # of frames
        GetMP3Info.Frames = Frames                'set frames
    Else
        GetMP3Info.VBR = False
    End If
    '''end check for XingHeader

    '''start extract the first 4 bytes (32 bits) to an array
    For z = 1 To 4 '
        Get #1, Headstart + z - 1, ByteArray(z)
    Next z
    '''stop extract the first 4 bytes (32 bits) to an array

5:
    If ReadTag = False Then GoTo 10     'if we dont want to read the tag goto 10
    ''''start id3 tag''''''''''''''''''''''''''''''''''''''''''''''''
    Dim Inbuf As String * 256
    Get #FIO%, (N& - 255), Inbuf:  Close FIO% 'ny
        p = InStr(1, Inbuf, "tag", 1)  'ny
        If p = 0 Then
            With GetMP3Info
                .HasTag = False
                .SongName = ""
                .Artist = ""
                .Album = ""
                .Year = ""
                .Comment = ""
                .Track = ""
                .Genre = 255
            End With
        Else
            With GetMP3Info
                .HasTag = True
                .SongName = RTrim(Mid$(Inbuf, p + 3, 30))
                .Artist = RTrim(Mid$(Inbuf, p + 33, 30))
                .Album = RTrim(Mid$(Inbuf, p + 63, 30))
                .Year = RTrim(Mid$(Inbuf, p + 93, 4))
                .Comment = RTrim(Mid$(Inbuf, p + 97, 29))
                .Track = RTrim(Mid$(Inbuf, p + 126, 1))
                .Genre = Asc(RTrim(Mid$(Inbuf, p + 127, 1)))
        End With
    End If

    ''''stop id3 tag''''''''''''''''''''''''''''''
10:
    Close FIO%
    BinaryHeader = ByteToBit(ByteArray)
End Function

'Public Function WriteTag(FileName As String, Songname As String, _
'Artist As String, Album As String, Year As String, Comment As String, Genre As Integer) As Long
'Tag = "TAG"
'Dim sn As String * 30
'Dim com As String * 30
'Dim art As String * 30
'Dim alb As String * 30
'Dim yr As String * 4
'Dim gr As String * 1
'sn = Songname
'com = Comment
'art = Artist
'alb = Album
'yr = Year
'gr = Chr(Genre)
'Open FileName For Binary Access Write As #1
'Seek #1, FileLen(FileName) - 127
'Put #1, , Tag
'Put #1, , sn
'Put #1, , art
'Put #1, , alb
'Put #1, , yr
'Put #1, , com
'Put #1, , gr
'Close #1
'End Function

 Function ReadMP3(FileName As String, ReadTag As Boolean, ReadHeader As Boolean) As MP3Info
    On Error GoTo Handler

    bin = BinaryHeader(FileName, ReadTag, ReadHeader)                     'extract all 32 bits

    If ReadHeader = False Then Exit Function

    Version1 = Array(25, 0, 2, 1)                         'Mpegversion table
    MpegVersion = Version1(BinToDec(Mid(bin, 12, 2)))    'get mpegversion from table
    layer = Array(0, 3, 2, 1)                           'layer table
    MpegLayer = layer(BinToDec(Mid(bin, 14, 2)))        'get layer from table
    SMode = Array("stereo", "joint stereo", "dual channel", "single channel") 'mode table
    Mode = SMode(BinToDec(Mid(bin, 25, 2)))              'get mode from table
    Emph = Array("no", "50/15", "reserved", "CCITT J 17") 'empasis table
    Emphasis = Emph(BinToDec(Mid(bin, 31, 2)))           'get empasis from table
    Select Case MpegVersion                                 'look for version to create right table
        Case 1                                                  'for version 1
            Freq = Array(44100, 48000, 32000)
        Case 2 Or 25                                            'for version 2 or 2.5
            Freq = Array(22050, 24000, 16000)
        Case Else
            Frequency = 0
            Exit Function
    End Select

    Frequency = Freq(BinToDec(Mid(bin, 21, 2)))             'look for frequency in table

    If GetMP3Info.VBR = True Then                           'check if variable bitrate
        temp = Array(, 12, 144, 144)                        'define to calculate correct bitrate
        Bitrate = (FileLen(FileName) * Frequency) / (Int(GetMP3Info.Frames)) / 1000 / temp(MpegLayer)
    Else                                                 'if not variable bitrate

        Dim LayerVersion As String
        LayerVersion = MpegVersion & MpegLayer          'combine version and layer to string
        Select Case Val(LayerVersion)                        'look for the right bitrate table
            Case 11                                              'Version 1, Layer 1
                Brate = Array(0, 32, 64, 96, 128, 160, 192, 224, 256, 288, 320, 352, 384, 416, 448)
            Case 12                                              'V1 L1
                Brate = Array(0, 32, 48, 56, 64, 80, 96, 112, 128, 160, 192, 224, 256, 320, 384)
            Case 13                                               'V1 L3
                Brate = Array(0, 32, 40, 48, 56, 64, 80, 96, 112, 128, 160, 192, 224, 256, 320)
            Case 21 Or 251                                         'V2 L1 and 'V2.5 L1
                Brate = Array(0, 32, 48, 56, 64, 80, 96, 112, 128, 144, 160, 176, 192, 224, 256)
            Case 22 Or 252 Or 23 Or 253                            ''V2 L2 and 'V2.5 L2 etc...
                Brate = Array(0, 8, 16, 24, 32, 40, 48, 56, 64, 80, 96, 112, 128, 144, 160)
            Case Else                                               'if variable bitrate
                Bitrate = 1                                             'e.g. for Variable bitrate
                Exit Function
        End Select
        Bitrate = Brate(BinToDec(Mid(bin, 17, 4)))
    End If

    NoYes = Array("no", "yes")
    Original = NoYes(Mid(bin, 30, 1))                       'Set original bit
    CopyRight = NoYes(Mid(bin, 29, 1))                      'Set copyright bit
    Padding = NoYes(Mid(bin, 23, 1))                        'get padding bit
    PrivateBit = NoYes(Mid(bin, 24, 1))
    YesNo = Array("yes", "no")                              'CRC table
    CRC = YesNo(Mid(bin, 16, 1))                            'Get CRC
    ms = (FileLen(FileName) * 8) / Bitrate                  'calculate duration
    Duration = Int(ms / 1000)

    With GetMP3Info                                          'set values
        .Bitrate = Bitrate                                  '
        .CRC = CRC
        .Duration = Duration
        .Emphasis = Emphasis
        .Frequency = Frequency
        .Mode = Mode
        .MpegLayer = MpegLayer
        .MpegVersion = MpegVersion
        .Padding = Padding
        .Original = Original
        .CopyRight = CopyRight
        .PrivateBit = PrivateBit
    End With
Exit Function

Handler:
    If Err = 63 Then
        Resume Next
    Else
        Resume Next
    End If
End Function

Public Function LoadMP3File(ByVal hWnd As Long, Optional file As String) As Boolean
    
    Dim cmdToDo As String * 255, dwReturn As Long, ret As String * 128
    Dim tmp As String * 255, lenShort As Long, ShortPathAndFile As String
    Dim sError As String
    Const WS_CHILD = &H40000000
    On Error GoTo Handler

    'Determine if the user passed in the file or they set the property first.
    If (mvarMP3File = "") And (file = "") Then
        Exit Function
    ElseIf (mvarMP3File = "") Or (file <> "") Then
        mvarMP3File = file
    ElseIf (mvarMP3File <> "") Or (file = "") Then
        file = mvarMP3File
    End If

    DoEvents

Again:
    AliasName = "mpeg" & GetRandomNumber(1000, 1) 'Make a alias name

    'Open the MPEG.
    lenShort = GetShortPathName(file, tmp, 255) 'Get short path name.
    ShortPathAndFile = Left$(tmp, lenShort) 'cut short path from buffer
    'Get command string
    cmdToDo = "open " & ShortPathAndFile & " type MPEGVideo" & " Alias " & AliasName & " parent " & hWnd & " Style " & WS_CHILD
    dwReturn = mciSendString(cmdToDo, 0&, 0&, 0&) 'Send command string.

    'sprawdzamy czy wszystko OK
    If Not dwReturn = 0 Then
        'coœ nie tak :(
        Call mciGetErrorString(dwReturn, ret, 128)   'Get the error
        Err.Description = Trim$(ret): Err.Number = dwReturn
        GoTo Handler
    Else
        'wszystko OK :)
        Dim LbFramesPerSecond As Variant, LbTotalFrames As Variant, LbTotalTime As Variant

        Call ReadMP3(file, True, True)

        'Raise event
        LoadMP3File = True
    End If
    Exit Function

Handler:
    LoadMP3File = False

End Function

Public Function PlayMP3(Optional from_where As String = "0", Optional to_where As String = "") As Boolean
    
    Dim cmdToDo As String * 128
    Dim dwReturn As Long
    Dim ret As String * 128

    If from_where = vbNullString Then from_where = 0
    If to_where = vbNullString Then to_where = GetTotalframes(AliasName)

    cmdToDo = "play " & AliasName & " from " & from_where & " to " & to_where
    dwReturn = mciSendString(cmdToDo, 0&, 0&, 0&) 'odtwarzaj

    If Not dwReturn = 0 Then 'coœ nie tak :(
        Call mciGetErrorString(dwReturn, ret, 128)  'pobierz komunikat b³êdu
        PlayMP3 = False
        Exit Function
    End If

    'OK :)
    PlayMP3 = True
    
End Function

Public Sub StopMP3()

'zatrzymaj odtwarzanie mp3 i zamknij otwarte urz¹dzenie audio
    Dim dwReturn As Long
    Dim ret As String * 128

    dwReturn = mciSendString("Stop " & AliasName, 0&, 0&, 0&) 'zatrzymaj
    dwReturn = mciSendString("Close " & AliasName, 0&, 0&, 0&) 'zamknij urz¹dzenie

    'If Not dwReturn = 0 Then  'coœ nie tak :(
    '    Call mciGetErrorString(dwReturn, ret, 128)  'pobierz komunikat b³êdu
    '    Exit Sub
    'End If
    
End Sub

Public Sub PauseMP3()

'w³¹czamy pauzê
    Dim dwReturn As Long, ret As String * 128

    dwReturn = mciSendString("Pause " & AliasName, 0&, 0&, 0&) 'pauza

    If Not dwReturn = 0 Then  'coœ jest nie tak
        Call mciGetErrorString(dwReturn, ret, 128)
        Exit Sub
    End If
    
End Sub

Public Sub ResumeMP3()

'przywracamy odtwarzanie pliku MP3
    Dim dwReturn As Long
    Dim ret As String * 128

    dwReturn = mciSendString("Resume " & AliasName, 0&, 0&, 0&) 'przywróæ

    If Not dwReturn = 0 Then  'coœ nie tak :(
        Call mciGetErrorString(dwReturn, ret, 128)  'pobierz komunikat b³êdu
        Exit Sub
    End If
    
End Sub

Public Function GetRandomNumber(Upper As Integer, Lower As Integer) As Long


    Randomize
    GetRandomNumber = CLng(Int((Upper - Lower + 1) * Rnd + Lower))

End Function

Public Function GetTotalframes(AliasName As String) As Long
    
    Dim dwReturn As Long
    Dim Total As String * 128

    dwReturn = mciSendString("set " & AliasName & " time format frames", Total, 128, 0&)
    dwReturn = mciSendString("status " & AliasName & " length", Total, 128, 0&)

    If Not dwReturn = 0 Then  'coœ jest nie tak
        GetTotalframes = -1
        Exit Function
    End If

    'wszystko jest OK
    GetTotalframes = Val(Total)
    
End Function



