function Add-FactoryVM {
    param (
        [Parameter(Mandatory = $true)][string]$FriendlyName,
        [string]$ISOFile,
        [string]$ProductKey,
        [string]$SKUEdition,
        [bool]$desktop = $false,
        [bool]$is32bit = $false,
        [switch]$Generation2,
        [bool] $GenericSysprep = $false,
        [string] $FactoryPath = "."
     #	Start-ImageFactory -FriendlyName "Server 2016 DataCenter GUI - Gen 2" 
     #        -ISOFile $2016Image -ProductKey $Windows2016Key -SKUEdition "ServerDataCenter" -Generation2; 
    )
    Import-FactoryConfig
    [PSImageFactory.ImageFactoryVm[]]$factoryImages = Get-FactoryVM

    # prevent duplicate friendly names
    if (($factoryImages | Where-Object {$_.FriendlyName -eq $FriendlyName}) -ne $null)
    {
        Write-Host "Image Name already exists"
        return;
    }

    $vmImage = new-object PSImageFactory.ImageFactoryVm;
    $vmImage.FriendlyName = $FriendlyName;
    $vmImage.IsoFile = $ISOFile;
    $vmImage.SkuEdition = $SKUEdition;
    $vmImage.Desktop = $desktop;
    $vmImage.Is32Bit= $is32bit;
    $vmImage.Generation2 = $Generation2;
    $vmImage.GenericSysprep = $GenericSysprep;
    $factoryImages  += ,$vmImage;

    #persist the changes.
    $path = GetFactoryImagesPath;
    export-clixml $factoryImages $path
    
}