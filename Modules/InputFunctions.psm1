function GetInputKey {    
    $key = "NoKey"
    # wait for a key to be available:
    if ([Console]::KeyAvailable)
    {
        # read the key, and consume it so it won't
        # be echoed to the console:
        $keyInfo = [Console]::ReadKey($true)
        $key = $keyInfo.Key        
    }
    return $key
}
Export-ModuleMember GetInputKey