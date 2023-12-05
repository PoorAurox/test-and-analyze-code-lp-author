Describe {
    BeforeAll {
        . $PSCommandPath.Replace('.Tests.ps1', '.ps1').Replace('/Test/', '/Source/')
    }
    Context {
        It "Mandatory parameters" {
            Get-GhRepository | Should -Mandatory
        }
    }
}