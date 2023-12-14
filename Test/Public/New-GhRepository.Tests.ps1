BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1').Replace('\Test\', '\Source\')
}
Describe "New-GhRepository Tests" {

    Context "Mandatory parameters" {
        It "Owner" {
            Get-Command New-GhRepository | Should -HaveParameter Name -Mandatory -Type String
        }
        It "Repo" {
            Get-Command New-GhRepository | Should -HaveParameter Description -Type String
        }
        It "Private" {
            Get-Command New-GhRepository | Should -HaveParameter Private -Type Bool
        }
    }
    Context "Confirm correct URL" {
        BeforeAll {
            function Invoke-Gh ($endpoint, $body, $Method) {}
            Mock Invoke-Gh -MockWith {}
        }
        It "API call" {
            $Name = "TestTest"
            New-GhRepository -Name $Name

            Should -Invoke -CommandName Invoke-Gh -Times 1 -ParameterFilter {$endpoint -eq 'user/repos'}
        }
        It "Post call" {
            $Name = "TestTest"
            New-GhRepository -Name $Name

            Should -Invoke -CommandName Invoke-Gh -Times 1 -ParameterFilter {$Method -eq "Post"}
        }
        It "API call" {
            $Name = "TestTest"
            New-GhRepository -Name $Name

            Should -Invoke -CommandName Invoke-Gh -Times 1 -ParameterFilter {$body.Name -eq $Name}
        }
    }
}