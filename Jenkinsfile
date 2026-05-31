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
        IMAGE_NAME = "docker pull piratehammad/react-nodejs-app:1.0"
    }

        stage('build app') {
            steps {
                script {
                    buildjar()        // ← from shared library
                }
            }
        }

        stage('build and push image') {
            steps {
                script {
                    
                    buildimage(env.IMAGE_NAME)    
                    dockerLogin()
                    dockerPush(env.IMAGE_NAME)
                }
            }
        }

        stage('deploy the app') {
            steps {
                script {
                    echo 'deploying the app'
                    def shellCmd = "bash ./server.sh"
                    
                    sshagent (['ec2-server-key']){
                        sh "scp server.sh ubuntu@<IP_ADDRESS>:/home/ubuntu/"
                        sh "scp docker-compose.yml ubuntu@<IP_ADDRESS>:/home/ubuntu/"
                        sh 'ssh -o StrictHostKeyChecking=no ubuntu@100.53.212.231  ${shellCmd} '
                    }
                }
            }
        }
    }