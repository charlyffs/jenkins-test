pipeline {
    agent any

    triggers {
        pollSCM('H/2 * * * *')
    }

    stages {
        stage('Test') {

            agent {
                docker {
                    image 'python:3.11-slim'
                    args '-e HOME=/tmp'
                }
            }

            steps {
                echo 'Testing...'
                sh 'pip install -r requirements.txt && python3 -m pytest'
            }
        }
        stage('Build') {
            steps {
                echo 'Building...'
                script {
                    def shortCommit = env.GIT_COMMIT.take(7)
                    def imageTag = "my-image:${shortCommit}"
                    sh 'docker build -t ${imageTag} .'
                    echo 'Built image with tag ${imageTag}'
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                sh 'docker run -d -p 8000:8000 ${imageTag}'
            }
        }
    }
}