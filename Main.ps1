######################
# Unload all Modules #
######################
Write-Host "Unloading Modules..."
Get-Module -Name FrameFunctions | Remove-Module -Force; Start-Sleep -Seconds 0.1
Get-Module -Name InputFunctions | Remove-Module -Force; Start-Sleep -Seconds 0.1
Write-Host "Modules Unloaded!" -ForegroundColor Green; Start-Sleep -Seconds 0.1

Write-Host "Unloading Classes..."
Get-Module -Name GameObjects | Remove-Module -Force; Start-Sleep -Seconds 0.1
Write-Host "Classes Unloaded!" -ForegroundColor Green; Start-Sleep -Seconds 0.1


#####################
# Importing Modules #
#####################
Write-Host "Importing Modules..."
Import-Module .\Modules\FrameFunctions.psm1 -Force; Start-Sleep -Seconds 0.1
Import-Module .\Modules\InputFunctions.psm1 -Force; Start-Sleep -Seconds 0.1
Write-Host "Modules Imported!" -ForegroundColor Green; Start-Sleep -Seconds 0.1

##################
# Import Classes #
##################
Write-Host "Importing Classes..."
Import-Module .\Assets\GameObjects.ps1 -Force; Start-Sleep -Seconds 0.1
Write-Host "Classes Imported!" -ForegroundColor Green; Start-Sleep -Seconds 0.1

############################
# Generate Tempplate Frame #
############################
Write-Host "Generating Template Frame..."
$width = 60
$height = 30
$TemplateFrame = CreateFrameTemplate -width $width -height $height
Write-Host "Template Frame Generated!" -ForegroundColor Green


#####################################
# Create Main and Background Frames #
#####################################
$MainFrameData = CreateDummyFrameData -width $width -height $height -value @(0, 0, 0)
$BackgroundFrameData = CreateDummyFrameData -width $width -height $height -value @(0, 0, 0)
#OutputFrame -TemplateFrame $TemplateFrame -FrameData $WhiteFrameData


#################
# Create Assets #
#################
$myBall = [Ball]::new(2, 2, 10, 10)



#region old loops
# do {
#     Measure-Command{
#     Clear-Host -Force
#     $inputKey = GetInputKey
#     switch ($inputKey) {
#         UpArrow { $WhiteFrameData = CreateDummyFrameData -width $width -height $height -value @(100, 200, 100) }
#         DownArrow { $WhiteFrameData = CreateDummyFrameData -width $width -height $height -value @(200, 100, 100) }
#         LeftArrow { $WhiteFrameData = CreateDummyFrameData -width $width -height $height -value @(100, 100, 200) }
#         RightArrow { $WhiteFrameData = CreateDummyFrameData -width $width -height $height -value @(200, 200, 100) }
#         Default { $WhiteFrameData = CreateDummyFrameData -width $width -height $height -value @(50, 50, 50) }
#     }


    
#     OutputFrame -TemplateFrame $TemplateFrame -FrameData $WhiteFrameData
#     } | select TotalMilliseconds
#     start-sleep -Milliseconds 1
# } while ($true)


# do {
#     $inputKey = GetInputKey
#     if ($inputKey -ne "NoKey") {
#         measure-command {
#         Clear-Host -Force
#         switch ($inputKey) {
#             UpArrow { $WhiteFrameData = CreateDummyFrameData -width $width -height $height -value @(100, 200, 100) }
#             DownArrow { $WhiteFrameData = CreateDummyFrameData -width $width -height $height -value @(200, 100, 100) }
#             LeftArrow { $WhiteFrameData = CreateDummyFrameData -width $width -height $height -value @(100, 100, 200) }
#             RightArrow { $WhiteFrameData = CreateDummyFrameData -width $width -height $height -value @(200, 200, 100) }
#             Default { $WhiteFrameData = CreateDummyFrameData -width $width -height $height -value @(50, 50, 50) }
#         }
#         OutputFrame -TemplateFrame $TemplateFrame -FrameData $WhiteFrameData
#         start-sleep -Milliseconds 1
#         $WhiteFrameData = CreateDummyFrameData -width $width -height $height -value @(50, 50, 50)
#         } | select TotalMilliseconds
#     }
# } while ($true)
#endregion


#region MainLoop
$LastOutputTime = Get-Date | select -ExpandProperty Ticks
do {
    $DeltaTime = (Get-Date | select -ExpandProperty Ticks) - $LastOutputTime
    Clear-Host
    #Write-Host $DeltaTime


    ##################
    # Input handling #
    ##################
    $inputKey = GetInputKey
    switch ($inputKey) {
        UpArrow { $myBall.Move(0, -1) | Out-Null }
        DownArrow { $myBall.Move(0, 1) | Out-Null }
        LeftArrow { $myBall.Move(-1, 0) | Out-Null }
        RightArrow { $myBall.Move(1, 0) | Out-Null }
        Default {  }
    }










    ###########################
    # Compose Main Frame Data #
    ###########################
    $myBallFrameData = $myBall.GetFrameData($width, $height)
    $currentFrameData = $BackgroundFrameData.Clone()
    foreach ($subPixel in $myBallFrameData) {
        $currentFrameData[$subPixel.index] = $subPixel.value
    }

    ###############################
    # Output Main Frame to Screen #
    ###############################
    OutputFrame -TemplateFrame $TemplateFrame -FrameData $currentFrameData


    $LastOutputTime = Get-Date | select -ExpandProperty Ticks
    Start-Sleep -Seconds 0.001
} while ($true)
#endregion