#find tomcat
var=$(sudo find / -name "version.sh")
if [[ -z "$var" ]];then
sudo mkdir /home/ec2-user/apache

#download tomcat
sudo yum install java



#downloading tomcat
wget http://apachemirror.wuchna.com/tomcat/tomcat-8/v8.5.49/bin/apache-tomcat-8.5.49.tar.gz



#unzipping tar file 
tar -xvzf apache-tomcat-8.5.49.tar.gz

#delete tar file
rm -rf apache-tomcat-8.5.49.tar.gz




#changing the port for tomcat
sudo sed -i "s/port="8080"/port="8765"/" apache-tomcat-8.5.49/conf/server.xml


#tomcat-users
 sed -i 's\</tomcat-users>\<!-- -->\g' apache-tomcat-8.5.49/conf/tomcat-users.xml
 echo '<role rolename="manager-gui" />' >> apache-tomcat-8.5.49/conf/tomcat-users.xml
 echo '<user username="admin" password="admin" roles="manager-gui" />' >> apache-tomcat-8.5.49/conf/tomcat-users.xml
 echo '<role rolename="manager-script" />' >> apache-tomcat-8.5.49/conf/tomcat-users.xml
 echo '<user username="script" password="script" roles="manager-script" />' >> apache-tomcat-8.5.49/conf/tomcat-users.xml
 echo '</tomcat-users>' >> apache-tomcat-8.5.49/conf/tomcat-users.xml


#setting valve in comments

sudo sed -i 's/<Valve /<!-- <Valve /' apache-tomcat-8.5.49/webapps/manager/META-INF/context.xml

sudo sed -i 's\:1" />\:1" /> -->\g' apache-tomcat-8.5.49/webapps/manager/META-INF/context.xml

#copy to apache dir
sudo cp -avr $WORKSPACE/apache-tomcat-8.5.49 /home/ec2-user/apache

sudo rm -rf $WORKSPACE/apache-tomcat-8.5.49/



#running tomcat
sudo /home/ec2-user/apache/apache-tomcat-8.5.49/bin/./startup.sh




sudo cp /$WORKSPACE/target/*.war /home/ec2-user/apache/apache-tomcat-8.5.49/webapps/

fi