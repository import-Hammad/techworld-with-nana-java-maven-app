#!/usr/bin/env groovy
library identifier: 'jenkins-shared-lib@master', retriever: modernSCM(
    [$class: 'GitSCMSource',
    remote: 'https://github.com/import-Hammad/jenkins-shared-libraries-nana.git',
    credentialsId: 'github-credentials']
)

pipeline {
    agent any
    tools {
        maven 'maven-3.92'
    }
    environment {
        IMAGE_NAME = 'piratehammad/react-nodejs-app:1.0'
    }
    stages {
        stage('build app') {
            steps {
                echo 'building application jar...'
                buildjar()
            }
        }
        stage('build image') {
            steps {
                script {
                    echo 'building the docker image...'
                    buildimage(env.IMAGE_NAME)
                    dockerLogin()
                    dockerPush(env.IMAGE_NAME)
                }
            }
        }
        stage("deploy") {
            steps {
                script {
                    echo 'deploying docker image to EC2...'
                    def dockerComposeCmd = "docker compose -f docker-compose.yml up -d"
                    sshagent(['ec2-server-key']) {
                        sh "scp -o StrictHostKeyChecking=no docker-compose.yml ubuntu@100.27.226.149:/home/ubuntu/"
                        sh "ssh -o StrictHostKeyChecking=no ubuntu@100.27.226.149 ${dockerComposeCmd}"
                    }
                }
            }
        }
    }
}
