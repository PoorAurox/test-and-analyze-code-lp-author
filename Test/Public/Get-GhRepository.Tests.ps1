BeforeAll {
    . 'C:\Users\gamers\Documents\Tyler\GHCICD\test-and-analyze-code-lp-author\Source\Private\Invoke-Gh.ps1'
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1').Replace('\Test\', '\Source\')
}
Describe "Get-GhRepository Tests" {
    BeforeAll {
        Mock Invoke-Gh ($endpoint) {}
    }
    Context "Mandatory parameters" {
        It "Owner" {
            Get-Command Get-GhRepository | Should -HaveParameter Owner -Mandatory -Type String
        }
        It "Repo" {
            Get-Command Get-GhRepository | Should -HaveParameter Repo -Mandatory -Type String
        }
    }
    Context "Confirm correct URL" {
        It "API call" {
            $owner = "Tyler"
            $repo = "MyOwn"
            Get-GhRepository -Owner $owner -Repo $repo

            Should -Invoke -CommandName Invoke-Gh -Times 1 -ParameterFilter {$endpoint -eq 'repos/Tyler/MyOwn' }
        }
    }
}