#!/user/bin/env groovy
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
                    buildimage()
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
