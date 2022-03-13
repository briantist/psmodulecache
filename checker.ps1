[CmdletBinding()]
[OutputType([bool])]
param(
    [Parameter(Mandatory)]
    [string[]]
    $Module
)

End {
    $specs = $Module.ForEach({
        $mod = $_
        $name, $ver = $mod.Split(':')
        $spec = if ($ver) {
            @{
                ModuleName = $name
                RequiredVersion = $ver
            }
        }
        else {
            $name
        }

        [Microsoft.PowerShell.Commands.ModuleSpecification]::new($spec)
    })

    $minfo = Get-Module -ListAvailable -FullyQualifiedName $specs

    $minfo.Count -eq $specs.Count
}
