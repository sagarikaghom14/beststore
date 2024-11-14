pipeline {
    agent any

    tools {
        maven 'Maven 3.9.9' // Ensure this matches the name you gave Maven in Global Tool Configuration
    }

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

                        // Deploy the WAR file to Tomcat using HTTP request
                        def deployResponse = httpRequest(
                            acceptType: 'APPLICATION_JSON',
                            contentType: 'APPLICATION_FORM',
                            url: "${TOMCAT_URL}/deploy",
                            authentication: 'tomcat-credentials',  // Jenkins credentials (configured in Jenkins)
                            body: [
                                'path'  : '/beststore',
                                'war'   : file(WAR_FILE)
                            ],
                            httpMode: 'POST'
                        )

                        echo "Deployment response: ${deployResponse}"
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
