function CreateFrameTemplate {
    param(
        $width,
        $height
    )

    $framestring = ""

    $i = 0
    for ($h = 0; $h -lt $height; $h++) {
        for ($w = 0; $w -lt $width; $w++) {
            $val0 = $i
            $val1 = $i + 1
            $val2 = $i + 2
            $framestring += "``e[38;2;{$val0};{$val1};{$val2}m█``e[``e[38;2;{$val0};{$val1};{$val2}m█``e["
            $i = $i + 3
        }
        if ($h -ne $height - 1) {
            $framestring += "``n"
        }
    }
    return $framestring
}
function OutputFrame {
    param(
        $TemplateFrame,
        $FrameData
    )
    $Frame = $TemplateFrame -f $FrameData
    $Frame = Invoke-Expression "`"$Frame`""
    Write-Host $Frame
}
function CreateDummyFrameData {
    param (
        [int]$width,
        [int]$height,
        $value
    )
    $FrameData = [System.Array]::CreateInstance([object], $width * $height * 3)
    $iter = 0
    $ArrayLength = $width * $height
    for ($i = 0; $i -lt $ArrayLength; $i++) {
        foreach ($val in $value) {
            $FrameData[$iter] = $val
            $iter++
        }
    }
    return $FrameData
}
function GetArrayIndexFromCoord {
    param (
        [int]$FrameWidth,
        [int]$FrameHeight,
        [int]$x,
        [int]$y
    )
    $arrayRowLength = [int]$FrameWidth * 3
    $arrayLength = ($width * 3) * $FrameHeight

    $arrayIndex = ($arrayRowLength * ($y - 1)) + (($x - 1) * 3)
    
    if ($arrayIndex + 2 -gt $arrayLength) {
        throw "Coordinates out of bounds"
    }
    return $arrayIndex .. ($arrayIndex + 2)
}
Export-ModuleMember CreateFrameTemplate, OutputFrame, CreateDummyFrameData, GetArrayIndexFromCoord