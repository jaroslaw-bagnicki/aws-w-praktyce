. $PSScriptRoot/Deploy-CFTemplate.ps1

awsume.ps1 jbagnicki

Deploy-CFTemplate `
    -Project website `
    -Stage dev `
    -Region eu-central-1 `
    -Component single-template `
    -Stack website `
    -Template website `
    -Parameters website