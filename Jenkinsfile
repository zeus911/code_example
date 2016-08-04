node {

   // Mark the code checkout 'stage'....
   stage 'Checkout'

   // Checkout code from repository
   checkout scm

   // Get the maven tool.
   // ** NOTE: This 'M3' maven tool must be configured
   // **       in the global configuration.
   def mvnHome = tool 'M3'

   // Mark the code build 'stage'....
   stage 'Build'
   // Run the maven build
   sh "cd trunk;${mvnHome}/bin/mvn clean install -s /tmp/settings.xml"
   //sh ">/home/mvn_error.txt;find  ./    -name pom.xml   | grep -v 'v6_batch/trunk/pom.xml' | grep -v v6_batch/trunk/batch-core/pom.xml  |grep -v  -E '\./pom.xml'|  xargs -I {}  sh  -c 'path_dir=`dirname {}`&& cd $path_dir && { ${mvnHome}/bin/mvn clean install clean package ; echo $? >./return_val.txt ; }  | tee ./output.txt  ;return_val=`cat ./return_val.txt` ;  if [ "$return_val" -ne 0 ];then ( cat ./output.txt  >>/home/mvn_error.txt)  ;else  cp  ./target/*.war   /home/  ;fi' ;" 


    sh "scp trunk/target/*.war     wujunrong@192.168.38.10:/home/wujunrong"
}
