!/usr/bin/env groovy
library identifier: 'jenkins-shared-libraries-nana@master', retriever: modernSCM(
    [
        $class: 'GitSCMSource',
        remote: 'https://github.com/import-Hammad/jenkins-shared-libraries-nana.git',
        credentialsId: 'github-credentials'
    ]
)

pipeline {
    agent any
    tools {
        maven "maven-3.92"
    }
    environment {
        IMAGE_NAME = "piratehammad/react-nodejs-app:1.0"  // Bug 1 fixed
    }
    stages {                                               // Bug 2 fixed

        stage('build app') {
            steps {
                script {
                    buildjar()                             // Bug 3 fixed
                }
            }
        }

        stage('build and push image') {
            steps {
                script {
                    buildimage(env.IMAGE_NAME)             // Bug 4 fixed
                    dockerLogin()
                    dockerPush(env.IMAGE_NAME)
                }
            }
        }

        stage('deploy the app') {
            steps {
                script {
                    echo 'deploying the app'
                    def dockerCMD = "docker-compose -f docker-compose.yml up -d"
                    sshagent(['ec2-server-key']) {
                        sh "scp -o StrictHostKeyChecking=no docker-compose.yml ubuntu@54.91.135.131:/home/ubuntu/"
                        sh "ssh -o StrictHostKeyChecking=no ubuntu@54.91.135.131 ${dockerCMD}"  // Bug 5 fixed
                    }
                }
            }
        }

    }
}