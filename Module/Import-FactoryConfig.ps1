function Import-FactoryConfig {

    $configPath = GetFactoryConfigPath

    # update the global config file variable if it's new, or has been updated since last import
    if ($global:PSImageFactoryConfig -eq $null -or
        $global:PSImageFactoryConfig_LastUpdateTime -eq $null -or
        $global:PSImageFactoryConfig_LastUpdateTime -ne (Get-ChildItem($configPath)).LastWriteTime) 
    {
        # clear out the globals
        $global:PSImageFactoryConfig = $null;
        $global:PSImageFactoryConfig_LastUpdateTime = $null
        
        # import the file
        if ($configPath.ToLower().EndsWith(".xml"))
        { $global:PSImageFactoryConfig = [xml](Get-Content -Path (Resolve-Path $configPath)).Configuration }
        else
        { throw [System.ArgumentException] "PS Image Factory Configuration file format not recognized" }

        $global:PSImageFactoryConfig_LastUpdateTime = (Get-ChildItem($configPath)).LastWriteTime
        Write-Host "Factory Config Loaded."
    }

    #initialize factory classes
    $code = [string](Get-Content $PSScriptRoot\ImageFactoryVmClass.cs);
    Add-Type -TypeDefinition $code
    
}
