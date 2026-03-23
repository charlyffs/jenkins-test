pipeline {
    agent {
        docker {
            image 'python:3.11-slim'
            args '-v /var/run/docker.sock:/var/run/docker.sock -e HOME=/tmp'
        }
    }

    triggers {
        pollSCM('H/2 * * * *')
    }

    stages {
        stage('Test') {
            steps {
                sh '''
                  ls
                  pip install -r requirements.txt && python3 -m pytest
                '''
            }
        }
        stage('Build') {
            steps {
                echo 'Building...'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
            }
        }
    }
}