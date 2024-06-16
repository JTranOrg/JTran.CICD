##############################################################
## Transforms a jtran transform source into a json (or multiple) destination
##############################################################

echo '##############################################################'
echo '### JTranTransform'
echo '###'
echo '###    Transforms a jtran transform source into a json (or '
echo '###      multiple) destination(s)'
echo '###'
echo '### Copyright (c) June 2024 - Jim Lightfoot - All Rights Reserved'
echo '###'
echo '##############################################################'
echo '....'
echo 'Starting JTran transformation...'
echo '....'

echo 'Installing jtrancmd console app...'
dotnet tool install jtrancmd -g

echo '....'

[string]$InputSourcePath       = Get-VstsInput -Name InputSourcePath
[string]$TransformPath         = Get-VstsInput -Name TransformPath
[string]$OutputDestinationPath = Get-VstsInput -Name OutputDestinationPath
[string]$IncludePath           = Get-VstsInput -Name IncludePath  
[string]$DocumentPath          = Get-VstsInput -Name DocumentPath
[bool]$MultipleOutput          = Get-VstsInput -Name MultipleOutput -AsBool
[string]$TransformParameters   = Get-VstsInput -Name TransformParameters 
[string]$ArgumentsProviderPath = Get-VstsInput -Name ArgumentsProviderPath 
[string]$ArgumentsClass        = Get-VstsInput -Name ArgumentsClass 

#[string]$InputSourcePath       = $args[0]
#[string]$TransformPath         = $args[1]
#[string]$OutputDestinationPath = $args[2]
#[string]$IncludePath           = $args[3]
#[string]$DocumentPath          = $args[4]
#[bool]$MultipleOutput          = $args[5]
#[string]$TransformParameters   = $args[6] 
#[string]$ArgumentsPath         = $args[7] 
#[string]$ArgumentsClass        = $args[8] 

[string]$sMultipleOutput       = if($MultipleOutput) {'true'} else {'false'}
[string]$ArgumentsProvider     = if($ArgumentsProviderPath -ne '') {$ArgumentsProviderPath + '::' + $ArgumentsClass} else {''} 

echo '....'
echo 'Transforming input file(s)...'
[string]$CommandLine = 'jtrancmd -t ' + $TransformPath + ' -s ' + $InputSourcePath + ' -o ' + $OutputDestinationPath + ' -m ' + $sMultipleOutput

        $CommandLine = if($IncludePath -ne '')         {$CommandLine + ' -i '  + '"' + $IncludePath + '"'}        else {$CommandLine} 
        $CommandLine = if($DocumentPath -ne '')        {$CommandLine + ' -d '  + '"' + $DocumentPath + '"'}       else {$CommandLine} 
        $CommandLine = if($ArgumentsProvider -ne '')   {$CommandLine + ' -a '  + '"' + $ArgumentsProvider+ '"'}   else {$CommandLine} 
        $CommandLine = if($TransformParameters -ne '') {$CommandLine + ' -tp ' + '"' + $TransformParameters+ '"'} else {$CommandLine} 

Invoke-Expression $CommandLine

echo '....'
echo '...Successful'

## .\Transform.ps1 C:\Development\Projects\JTranOrg\JTran.CICD\Deployment\CustomTasks\JTranTransform\AzureDevOps\Test\blanksource.json C:\Development\Projects\JTranOrg\JTran.CICD\Deployment\CustomTasks\JTranTransform\AzureDevOps\Test\config.jtran C:\Development\Testing\JTran\JTranTransform\output.json C:\Development\Testing\JTran\JTranTransform C:\Development\Testing\JTran\JTranTransform false "-environment 'prod'" "C:\Development\Projects\JTranOrg\JTran\Tests\TestArgumentsProvider\bin\Debug\net8.0\TestArgumentsProvider.dll" TestArgumentsProvider.MyArgs