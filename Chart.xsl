<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 

    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 

           xmlns:xs="http://www.w3.org/2001/XMLSchema">
  
  <xsl:template match="/">
  
    <html>
    <div>
    <div>
    <head>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {

        var data = google.visualization.arrayToDataTable([
          ['Task', 'Test Result for suite'],
          ['Total Passed Test Count::<xsl:value-of select="suite/@PassCount" />', <xsl:value-of select="suite/@PassCount" />],
          ['Total Failed Test Count::<xsl:value-of select="suite/@FailCount" />', <xsl:value-of select="suite/@FailCount" />],
          ['Total Skipped Test Count::<xsl:value-of select="suite/@SkipCount" />', <xsl:value-of select="suite/@SkipCount" />]
        ]);

        var options = {
          title: 'Test Result for suite',
          pieHole: 0.4
          //is3D: true
        };

        //var chart = new google.visualization.PieChart(document.getElementById('piechart'));
        //var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
        var chart = new google.visualization.PieChart(document.getElementById('donutchart'));

        chart.draw(data, options);
      }
    </script>
  </head>
  </div>
  <div>
    <body title="suite">
      <table border="1" width="1100">
      <tbody>
      <tr>
      <td>
      <div>  
        <br>
        <label for="TotalCount">Total Test Count::</label>
        <xsl:value-of select="suite/@TotalCount" />
        </br>
        <br>
        <label for="PassCount">Total Passed Test Count::</label>
        <xsl:value-of select="suite/@PassCount" />
        </br>
        <br>
        <label for="FailCount">Total Failed Test Count::</label>
        <xsl:value-of select="suite/@FailCount" />
        </br>
        <br>
        <label for="SkipCount">Total Skipped Test Count::</label>
        <xsl:value-of select="suite/@SkipCount" />
        </br>
      </div>  
      </td>
      <td>
        <!--<div id="piechart" style="width: 900px; height: 500px;"></div>-->
        <!--<div id="piechart_3d" style="width: 900px; height: 500px;"></div>-->
      <div id="donutchart" style="width: 900px; height: 500px;"></div>
      </td>
      </tr>
      </tbody>
      </table>
      <div>
        <xsl:for-each select="suite">
          <p>
          <table border="1" width="1100">
            <thead>
              <tr bgcolor="#9acd32">
                <td>Testmethod Name</td>
                <td>Finished at</td>
                <td>Started at</td>
                <td>status</td>
              </tr>
            </thead>
            <tbody>
            
              <xsl:for-each select="class">
                <!--<xsl:value-of select="position()" />-->
                <!--<xsl:variable name="testCount" select="position()" />-->
                <!--testCount:  <xsl:value-of select="$testCount" />-->
                
                <xsl:for-each select="test-method">
                  <!--<xsl:if test="position( )=1">-->
                    <tr>
                      <td>
                        <xsl:for-each select="@name">
                          <xsl:value-of select="." />
                        </xsl:for-each>
                      </td>
                      <td>
                        <xsl:for-each select="@finished-at">
                          <xsl:value-of select="." />
                        </xsl:for-each>
                      </td>
                      <td>
                        <xsl:for-each select="@started-at">
                          <xsl:value-of select="." />
                        </xsl:for-each>
                      </td>
                      <td>
                        <xsl:for-each select="@status">
                          <xsl:value-of select="." />

                        </xsl:for-each>
                      </td>
                    </tr>
                  <!--</xsl:if>-->
                </xsl:for-each>
                
              </xsl:for-each>
                
            </tbody>
          </table>
          </p>
        </xsl:for-each>
      </div>

      </body>
    </div>
    </div>
    </html>
    
  </xsl:template>
  
</xsl:stylesheet> 