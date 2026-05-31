#!/usr/bin/env groovy
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
        IMAGE_NAME = "piratehammad/react-nodejs-app:1.0"
    }
    stages {
        stage('build app') {
            steps {
                script {
                    buildjar()                              // ✅ matches buildjar.groovy
                }
            }
        }
        stage('build and push image') {
            steps {
                script {
                    buildimage(env.IMAGE_NAME)              // ✅ matches buildimage.groovy
                    dockerLogin()                           // ✅ matches dockerLogin.groovy
                    dockerPush(env.IMAGE_NAME)              // ✅ matches dockerPush.groovy
                }
            }
        }
        stage('deploy the app') {
            steps {
                script {
                    echo 'deploying the app'
                    def shellCmd = "bash ./server.sh ${IMAGE_NAME}"
                    sshagent(['ec2-slave-key']) {
                        sh "scp -o StrictHostKeyChecking=no server.sh ubuntu@54.91.135.131:/home/ubuntu/"
                        sh "scp -o StrictHostKeyChecking=no docker-compose.yml ubuntu@54.91.135.131:/home/ubuntu/"
                        sh "ssh -o StrictHostKeyChecking=no ubuntu@54.91.135.131 ${shellCmd}"
                    }
                }
            }
        }
    }
}