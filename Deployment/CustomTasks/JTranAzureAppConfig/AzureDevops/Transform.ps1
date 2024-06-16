##############################################################
## Transforms a jtran transform source into json files that 
##   are pushed to an Azure App Configuration instance
##############################################################

echo '##############################################################'
echo '### JTranAzureAppConfig'
echo '###'
echo '###    Transforms a jtran transform source into json files that '
echo '###      are pushed to an Azure App Configuration instance'
echo '###'
echo '### Copyright 2024 - Jim Lightfoot - All Rights Reserved'
echo '###'
echo '##############################################################'
echo '....'
echo 'Starting Azure App Configuration deploy...'
echo '....'

echo 'Installing jtrancmd console app...'
dotnet tool install jtrancmd -g

echo '....'

$TaskPath     = 'C:\\Development\\Projects\\JTran.CICD\\Deployment\\CustomTasks\\JTranAzureAppConfig\\AzureDevops\\'
$TestPath     = $TaskPath + 'Test\\'
$Source       = $TestPath + 'blanksource.json'
$Transform    = $TestPath + 'config.jtran'
$Output       = $TestPath + 'output.json'
$ProjectPath  = $TestPath + 'project.json'
$ProjectPath2 = $TestPath + 'project2.json'

$ProjectFile  = '{'

$ProjectFile += '  "TransformPath":    "' + $Transform + '",'
$ProjectFile += '  "SourcePath":       "' + $Source    + '",'
$ProjectFile += '  "DestinationPath":  "' + $Output    + '",'
$ProjectFile += '  "Arguments":'
$ProjectFile += '  {'
$ProjectFile += '    "environment":    "' + $args[0] + '"'
$ProjectFile += '  }'

$ProjectFile += '}'

echo 'Write the project file...'
Set-Content -Path $ProjectPath -Value $ProjectFile

echo 'Transforming intermediate configuration manifest...'
jtrancmd -p $ProjectPath

$Transform   = $TaskPath + 'deployconfig.jtran'
$Source      = $TestPath + 'output.json'
$Output      = $TestPath

$ProjectFile  = '{'
$ProjectFile += '  "TransformPath":    "' + $Transform + '",'
$ProjectFile += '  "SourcePath":       "' + $Source    + '",'
$ProjectFile += '  "DestinationPath":  "' + $Output    + '",'
$ProjectFile += '  "SplitOutput":      true'
$ProjectFile += '}'

echo 'Write the 2nd project file...'
Set-Content -Path $ProjectPath2 -Value $ProjectFile

echo 'Transforming final configuration manifest...'
jtrancmd -p $ProjectPath2

echo '....'
echo '...Successful'

## -s C:\Development\Projects\JTran.CICD\Deployment\CustomTasks\JTranAzureAppConfig\AzureDevops\Test\blanksource.json -t C:\Development\Projects\JTran.CICD\Deployment\CustomTasks\JTranAzureAppConfig\AzureDevops\Test\config.jtran -o C:\Development\Projects\JTran.CICD\Deployment\CustomTasks\JTranAzureAppConfig\AzureDevops\Test\output.json
## -environment:dev

## .\deploy.ps1 dev