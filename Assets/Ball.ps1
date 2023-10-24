class Ball {
    # Properties
    [int]$width
    [int]$height
    $colour = @(60, 255, 50)
    [int]$x
    [int]$y

    # Constructor
    Ball ([int]$width, [int]$height, [int]$x, [int]$y) {
        $this.width = $width
        $this.height = $height
        $this.x = $x
        $this.y = $y
    }

    # Methods
    [System.Array]GetFrameData([int]$FrameWidth, [int]$FrameHeight) {
        $BallFrameData = [System.Array]::CreateInstance([object], $this.width * $this.height * 3)
        $iter = 0
        for ($i = $this.x; $i -lt ($this.width + $this.x); $i++) {
            for ($j = $this.y; $j -lt ($this.height + $this.y); $j++) {
                $coordinateArrayIndexes = GetArrayIndexFromCoord -FrameWidth $FrameWidth -FrameHeight $FrameHeight -x $i -y $j
                $l = 0
                foreach ($index in $coordinateArrayIndexes) {
                    $BallFrameData[$iter] = @{index = $index; value = $this.colour[$l]}
                    $iter++; $l++
                }
            }
        }
        return $BallFrameData
    }
    [void]SetCoords([int]$x, [int]$y) {
        $this.x = $x
        $this.y = $y
    }
    [int[]]GetCoords() {
        return @($this.x, $this.y)
    }
    [void]Move([int]$x, [int]$y) {
        $this.x += $x
        $this.y += $y
    }
}