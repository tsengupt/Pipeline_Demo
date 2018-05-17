<#
PARAM
(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String]$XmlPath,
    
     
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String]$XslPath,
     
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String]$HtmlOutput
)

$SourceFile = "H:\WS\TestXmlHtml.txt"
$HtmlOutput = "H:\WS\TestXmlHtml.html"

Get-Content $SourceFile | ConvertTo-Html | Out-File $HtmlOutput
#>

#$XmlPath = "H:\WS\Test.xml" 
#$XslPath = "H:\WS\TestTransform.xsl"
#$HtmlOutput = "H:\WS\TestXmlHtml.html"

#$XmlPath = "H:\WS\24-04-2018\testng-merge.xml" 
#$XmlPath = "H:\WS\24-04-2018\Report\final.xml" 
$XmlPath = "H:\WS\26-04-2018\Chart.xml" 

#$XmlPath = "H:\WS\final.xml" 
#$XslPath = "H:\WS\24-04-2018\testng-mergeTransform.xsl"
$XslPath = "H:\WS\26-04-2018\Chart.xsl"
$HtmlOutput = "H:\WS\26-04-2018\Chart.html"


try
{
    $XslPatht = New-Object System.Xml.Xsl.XslCompiledTransform
    $XslPatht.Load($XslPath)
    $XslPatht.Transform($XmlPath, $HtmlOutput)
     
    Write-Host "Generated output is on path: $HtmlOutput"
}
catch
{
    Write-Host $_.Exception -ForegroundColor Red
}
