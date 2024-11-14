pipeline {
    agent any

    environment {
        TOMCAT_USER = 'sagarika'       // Username for Tomcat manager
        TOMCAT_PASSWORD = 'Sagarika123'  // Password for Tomcat manager
        TOMCAT_URL = 'http://localhost:8082/manager'
        WAR_FILE = 'target/beststore.war'  // Path to the WAR file to deploy
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm  // Checkout the source code from SCM
            }
        }

        stage('Build') {
            steps {
                script {
                    echo 'Building the project using Maven'
                    bat 'mvn clean package'  // Run Maven to build the WAR file
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Check if the WAR file exists
                    if (fileExists(WAR_FILE)) {
                        echo "Deploying beststore.war to Tomcat"
                        
                        // Use `start` to run in the background on Windows instead of `nohup`
                        bat """
                        start curl -u ${TOMCAT_USER}:${TOMCAT_PASSWORD} -T ${WAR_FILE} ${TOMCAT_URL}/deploy?path=/beststore
                        """
                    } else {
                        error "WAR file target/beststore.war does not exist!"
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed.'
        }

        failure {
            echo 'Build or deployment failed. Check logs for details.'
        }
    }
}
