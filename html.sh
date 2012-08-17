#!/bin/bash


for stl in $(ls *.stl)
do
    echo ${stl}
    html="$(basename ${stl} '.stl').html"
    cat<<EOF>${html}
<html>
 <head>
  <meta http-equiv="content-type" content="text/html" />
  <script src="HTML/javascripts/Three.js"><!--  --></script>
  <script src="HTML/javascripts/plane.js">><!--  --></script>
  <script src="HTML/javascripts/thingiview.js">><!--  --></script>
  <script>
       window.onload = function() {
         thingiurlbase = "HTML/javascripts";
         thingiview = new Thingiview("viewer");
         thingiview.setObjectColor('#C0D8F0');
         thingiview.setBackgroundColor('#90A0A0');
         thingiview.setCameraView('top');
         thingiview.initScene();
         thingiview.loadSTL("${stl}");
       }
  </script>
 </head>
 <body bgcolor="#000">
   <div id="viewer" style="width:700px;height:700px"></div>
 </body>
</html>
EOF
    ls -l ${html}
done
