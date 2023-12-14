BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1').Replace('\Test\', '\Source\')
}
Describe "Remove-GhRepository Tests" {

    Context "Mandatory parameters" {
        It "Owner" {
            Get-Command Remove-GhRepository | Should -HaveParameter Owner -Mandatory -Type String
        }
        It "Repo" {
            Get-Command Remove-GhRepository | Should -HaveParameter Repo -Mandatory -Type String
        }
    }
    Context "Confirm correct URL" {
        BeforeAll {
            function Invoke-Gh ($endpoint, $Method) {}
            Mock Invoke-Gh -ParameterFilter {$endpoint} -MockWith {}
        }
        It "API call" {
            $owner = "Tyler"
            $repo = "MyOwn"
            Remove-GhRepository -Owner $owner -Repo $repo

            Should -Invoke -CommandName Invoke-Gh -Times 1 -ParameterFilter {$endpoint -eq 'repos/Tyler/MyOwn' -and $Method -eq "Delete" }
        }
    }
}