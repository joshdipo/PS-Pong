class GameObject {
    # Properties
    [int]$FrameWidth
    [int]$FrameHeight
    [int]$width
    [int]$height
    $colour = @(60, 255, 50)
    [int]$x
    [int]$y

    # Constructor
    GameObject ([int]$FrameWidth, [int]$FrameHeight, [int]$width, [int]$height, [int]$x, [int]$y) {
        if ((($width + $x) -gt $FrameWidth) -or (($height + $y) -gt $FrameHeight) -or ($x -lt 1) -or ($y -lt 1)) { throw "GameObject is out of bounds!" }
        if ($width -lt 1 -or $height -lt 1) { throw "GameObject is too small!" }
        $this.FrameWidth = $FrameWidth
        $this.FrameHeight = $FrameHeight
        $this.width = $width
        $this.height = $height
        $this.x = $x
        $this.y = $y
    }

    # Methods
    [System.Array]GetFrameData() {
        $GameObjectFrameData = [System.Array]::CreateInstance([object], $this.width * $this.height * 3)
        $iter = 0
        for ($i = $this.x; $i -lt ($this.width + $this.x); $i++) {
            for ($j = $this.y; $j -lt ($this.height + $this.y); $j++) {
                $coordinateArrayIndexes = GetArrayIndexFromCoord -FrameWidth $this.FrameWidth -FrameHeight $this.FrameHeight -x $i -y $j
                $l = 0
                foreach ($index in $coordinateArrayIndexes) {
                    $GameObjectFrameData[$iter] = @{index = $index; value = $this.colour[$l]}
                    $iter++; $l++
                }
            }
        }
        return $GameObjectFrameData
    }
    [void]SetCoords([int]$x, [int]$y) {
        if (
            ($x + $this.width -gt $this.FrameWidth) -or ($y + $this.height -gt $this.FrameHeight) -or # Out of bounds: right, bottom
            ($x -lt 1) -or ($y -lt 1) # Out of bounds: left, top
        ) { Write-Warning "Cant set GameObject out of bounds!" } 
        else {
            $this.x = $x
            $this.y = $y
        }
    }
    [int[]]GetCoords() {
        return @($this.x, $this.y)
    }
    [void]Move([int]$x, [int]$y) {
        $this.x += $x
        $this.y += $y
    }
}