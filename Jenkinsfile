#!/usr/bin/env groovy
library identifier: 'jenkins-shared-lib@master', retriever: modernSCM(
    [$class: 'GitSCMSource',
    remote: 'https://github.com/import-Hammad/jenkins-shared-libraries-nana.git',
    credentialsId: 'github-credentials'])

def gv

pipeline {
    agent any
    tools {
        maven 'maven-3.92'
    }
    stages {
        stage("init") {
            steps {
                script {
                    gv = load "script.groovy"
                }
            }
        }
        stage("buildjar") {
            steps {
                script {
                    buildjar()
                }
            }
        }
        stage("build and push image") {
            steps {
                script {
                    buildimage 'piratehammad/demo-app:jma-3.0'
                    dockerLogin()
                    dockerPush('piratehammad/demo-app:jma-3.0')
                }
            }
        }
        stage("deployapp") {
            steps {
                script {
                    gv.deployapp()
                }
            }
        }
    }
}