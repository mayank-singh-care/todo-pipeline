pipeline{
    agent any
    environment {
        PORT = "85"
        DOCKERHUB_CREDENTIAL_ID = "dockerhub"
        IMAGE_NAME = "mayank-singh-care/todo-pipeline"
        CONTAINER_NAME = "my server"
        GIT_REPO = "https://github.com/mayank-singh-care/todo-pipeline.git"
        GIT-BRANCH = "main"
    }
    satges {
        stage('Checkout') {
            steps {
                git branch: "${GIT_BRANCH}", url: "${GIT_REPO}"
            }
        }
        stage('Build and push Docker Image') {
            steps {
                script {
                    docker.withRegistry("https://registry.hub.docker.com","${DOCKER_CREDENTIAL_ID}") {
                        def app = docker.build("${IMAGE_NAME}:${env.BUILD_NUMBER}",".")
                        app.push()
                    }
                }
            }
        }
        stage('Deploy Docker Image') {
            steps {
                sh "docker stop ${CONTAINER_NAME} || true"
                sh "docker rm ${CONTAINER_NAME} || true"
                sh "docker pull ${IMAGE_NAME}:${env.BUILD_NUMBER}"
                sh "docker run -d --name ${CONTAINER_NAME} -P ${PORT}:80 ${IMAGE_NAME}:${env.BUILD_NUMBER}"
            }
        }
    }
}