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
                    env.IMAGE_TAG = "uvicorn-app-test:${shortCommit}"
                    sh "docker build -t $IMAGE_TAG ."
                    echo "Built image with tag $IMAGE_TAG"
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                sh "docker run -d -p 8000:8000 $IMAGE_TAG"
            }
        }
    }
}