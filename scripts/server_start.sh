#!/usr/bin/env bash
cd /home/ec2-user/server

# Move the WAR file to Tomcat's webapps directory and restart Tomcat
sudo cp beststore.war /usr/local/tomcat/webapps/

# Start the Tomcat server
sudo systemctl start tomcat
