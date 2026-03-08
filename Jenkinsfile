#!/usr/bin/env groovy
@Library('jenkins-shared-library') 
def  gv
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
                script{
                    buildjar()
                }
            }
        }
        stage("buildimage") {
            steps {
                script{
                    buildimage 'piratehammad/demo-app:jma-3.0'
                }
            }
        }
        stage("deployapp") {
            steps {
                script{
                    gv.deployapp()
                }
            }
        }
    }
}
