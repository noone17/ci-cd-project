pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "noone1705/node-microservice:latest"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/YOUR_GITHUB_USERNAME/ci-cd-demo-app.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                sh 'npm test'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds',
                                                 usernameVariable: 'DOCKER_USER',
                                                 passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker stop ci-cd-app || true && docker rm ci-cd-app || true'
                sh 'docker run -d -p 3000:3000 --name ci-cd-app $DOCKER_IMAGE'
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}

