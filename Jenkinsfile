pipeline {
    agent any

    tools {
        maven 'Maven 3.9.9' // Ensure this matches the name you gave Maven in Global Tool Configuration
        jdk 'JDK 21'        // Ensure this matches the name you gave JDK 21 in Global Tool Configuration
    }

    environment {
        DEPLOY_DIR = 'C:\\Program Files\\Apache Software Foundation\\Tomcat 10.1\\webapps\\' // Tomcat webapps directory
        WAR_FILE = 'target\\java-maven-project.war'                                         // Name of your WAR file
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm // Pull the code from the repository
            }
        }

        stage('Build') {
            steps {
                bat 'mvn clean package' // Build the project and generate the WAR file
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Check if the WAR file exists
                    if (!fileExists(WAR_FILE)) {
                        error "WAR file ${WAR_FILE} does not exist!"
                    }

                    // Deploy the WAR file to Tomcat
                    bat """
                        echo Deploying WAR file...
                        copy /Y ${WAR_FILE} "${DEPLOY_DIR}"
                        echo Restarting Tomcat server...
                        net stop Tomcat10 // Stop the Tomcat service (update to your service name)
                        net start Tomcat10 // Start the Tomcat service
                    """
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed.'
        }

        success {
            echo 'Build and deployment successful!'
        }

        failure {
            echo 'Build or deployment failed. Check logs for details.'
        }
    }
}
