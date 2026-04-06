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