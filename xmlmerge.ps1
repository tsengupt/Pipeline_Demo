Param(
  [string]$ReportPath
)

#$path = "H:\WS\24-04-2018\Report\final.xml"
$path = $ReportPath + "\final.xml"
if (Test-Path $path)
{
    Remove-Item $path
}

#$htmlpath = "H:\WS\24-04-2018\Report\FinalXml.htm"
$htmlpath = $ReportPath + "\FinalXml.htm"
if (Test-Path $htmlpath)
{
    Remove-Item $htmlpath
}

#$xmlReportPath = "H:\WS\24-04-2018\Report" 

$files = get-childitem $ReportPath -recurse -Include "*.xml" | foreach-object {$_.Fullname}

$finalXml = "<suite name='AIG_DEMO'>"
foreach ($file in $files) {
    [xml]$xml = Get-Content $file 
    
    $finalXml += Select-Xml -Xml $xml -XPath "//suite/test"   
    #$finalXml += $xml.InnerXml
}
$finalXml += "</suite>"
#$finalXml | ConvertTo-Html > $htmlpath
([xml]$finalXml).Save($path)

######Count "PASS", "FAIL", "SKIP" Test Cases#####

[xml]$data = Get-Content $path
 $rows = $data.selectnodes("/suite/class/test-method")
 $rows | ConvertTo-Html -Property name,finished-at,started-at,status > $htmlpath
 write-host $rows.Count
 Write-host "completed"
 $passCount = 0;
 $failCount = 0;
 $skipCount = 0;
 $totalCount = $rows.Count;
 foreach($row in $rows){
    if($row.status -eq "PASS"){
        $passCount = $passCount + 1;
    }
    elseif($row.status -eq "FAIL"){
        $failCount = $failCount + 1;
    }
    else{
        $skipCount = $skipCount + 1;
    }
 }
 Write-host "totalCount: $totalCount"
 Write-host "passCount: $passCount"
 Write-host "failCount: $failCount"
 Write-host "skipCount: $skipCount"
#Get-Content $path | ConvertTo-Html > $htmlpath

######Append test results counts in final xml#####
##################################################
$Doc = New-Object System.Xml.XmlDocument  
$xmlContent = Get-Content $path
$Doc.LoadXml($xmlContent)
$Root = $Doc.DocumentELement 
$Root.SetAttribute("TotalCount","$totalCount")  
$Root.SetAttribute("PassCount","$passCount")
$Root.SetAttribute("FailCount","$failCount")
$Root.SetAttribute("SkipCount","$skipCount")
$Doc.Save($path)