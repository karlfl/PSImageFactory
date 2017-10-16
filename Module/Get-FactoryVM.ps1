function Get-FactoryVM
{
    param (
        [Parameter(Position = 0)][string]$FriendlyName = $null
    )
  
    Import-FactoryConfig
    $factoryImagePath = GetFactoryImagesPath;
    [PSImageFactory.ImageFactoryVm[]]$factoryImages = $null;
    
    if (Test-Path $factoryImagePath) 
    {
        $factoryImages = [PSImageFactory.ImageFactoryVm[]](Get-Content -Raw -Path $factoryImagePath)
    }

    if ($factoryImages -ne $null -and
        $FriendlyName -ne "")
    {
        $factoryImages | Where-Object { $_.FriendlyName -eq $FriendlyName }
    }
    else 
    {
        $factoryImages;  
    }
    
}