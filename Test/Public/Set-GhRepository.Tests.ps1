BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1').Replace('\Test\', '\Source\')
}
Describe "Set-GhRepository Tests" {

    Context "Parameters" {
        It "Owner Mandatory" {
            Get-Command Set-GhRepository | Should -HaveParameter Owner -Mandatory -Type String
        }
        It "Repo Mandatory" {
            Get-Command Set-GhRepository | Should -HaveParameter Repo -Mandatory -Type String
        }
        It "Name Optional" {
            Get-Command Set-GhRepository | Should -HaveParameter Name -Type String
        }
        It "Description Optional" {
            Get-Command Set-GhRepository | Should -HaveParameter Description -Type String
        }
        It "Private Optional" {
            Get-Command Set-GhRepository | Should -HaveParameter Private -Type Bool
        }
        It "DefaultBranch Optional" {
            Get-Command Set-GhRepository | Should -HaveParameter DefaultBranch -Type String
        }

    }
    Context "Confirm correct URL" {
        BeforeAll {
            function Invoke-Gh ($endpoint, $Method, $Body) {}
            Mock Invoke-Gh -MockWith {}
        }
        It "API call" {
            $owner = "Tyler"
            $repo = "MyOwn"
            Set-GhRepository -Owner $owner -Repo $repo

            Should -Invoke -CommandName Invoke-Gh -Times 1 -ParameterFilter {$endpoint -eq "repos/$owner/$repo" -and $Method -eq "Patch"}
        }
        It "API call body" {
            $owner = "Tyler"
            $repo = "MyOwn"
            Set-GhRepository -Owner $owner -Repo $repo

            Should -Invoke -CommandName Invoke-Gh -Times 1 -ParameterFilter {($body.psobject.Properties.Name -match "^[a-z_]+$").Count -eq $body.psobject.Properties.Name.Count}
        }
    }
}