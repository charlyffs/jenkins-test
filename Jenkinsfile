pipeline {
    agent any

    triggers {
        pollSCM('H/2 * * * *')
    }

    stages {
        stage('Test') {
            steps {
                echo 'Testing...'
                sh 'ls'
                sh '''
                docker run --rm \
                  -v $PWD:/app \
                  -w /app \
                  python:3.11-slim \
                  sh -c "ls && pip install -r requirements.txt && pytest"
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