function Export-FactoryConfig {
    $Path = GetFactoryConfigPath

    # convert and write the global config file
    if ($global:PSImageFactoryConfig -ne $null) 
    {
        export-clixml $global:PSImageFactoryConfig $Path
    }
}
