function Initialize-FactoryRoot
{
    param ([string] $Path = ".")

    if (test-path "$Path\.PSImageFactory")
    {
        throw [System.ArgumentException] "Current directory already initialized for PS Image Factory"
    }

    New-Item -Path $Path -Name ".PSImageFactory" -ItemType "Directory" | Out-Null
    New-Item -Path $Path -Name "Base" -ItemType "Directory" | Out-Null
    New-Item -Path $Path -Name "ISOs" -ItemType "Directory" | Out-Null
    New-Item -Path $Path -Name "Resources" -ItemType "Directory" | Out-Null
    New-Item -Path $Path -Name "Shared" -ItemType "Directory" | Out-Null
    
    Copy-Item "$PSScriptRoot\FactoryConfig.xml" "$Path\.PSImageFactory\"

    #update factoryconfig.json with current values...
    Import-FactoryConfig 
    $PSImageFactoryConfig.Base.Folder.FactoryRoot = (Get-Item $Path).FullName;
    $PSImageFactoryConfig.Base.Folder.BaseRoot = (Get-Item "$Path\Base").FullName;
    $PSImageFactoryConfig.Base.Folder.IsoRoot = (Get-Item "$Path\ISOs").FullName;
    $PSImageFactoryConfig.Base.Folder.ResourceRoot = (Get-Item "$Path\Resources").FullName;
    $PSImageFactoryConfig.Base.Folder.ShareRoot = (Get-Item "$Path\Shared").FullName;
    Export-FactoryConfig
    
    Write-Host "`nFolder initialized and ready for creating factory images.`n" -Foreground Green

    Write-Host "To modify the defaults review the settings in the .PSImageFactory\FactoryConfig.xml file."
    Write-Host "To begin managing factory images review the Add-FactoryVM and Get-FactoryVM commandlets.`n`n"
    
}