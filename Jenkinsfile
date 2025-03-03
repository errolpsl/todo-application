
pipeline{
    agent any

    environment{
        DOCKER_REGISTRY='errolcostabir'
        IMAGE_NAME='todo-application-image'
        DOCKER_REPO='todo-application'
    }

    stages{
        stage('Clone Repository'){
            steps{
                git url: 'https://github.com/errolpsl/todo-application.git', branch: 'master'
            }
        }
        stage('Build with Maven'){
            steps{
                sh 'mvn clean package -DskipTests'
            }
        }
        stage('Build Docker Image'){
            steps{
                sh "docker build -t ${IMAGE_NAME}:latest ."
                sh "docker tag ${IMAGE_NAME}:latest ${DOCKER_REGISTRY}/${DOCKER_REPO}:latest"
            }
        }
        stage('Push Docker Image'){
            steps{
                script{
                    docker.withRegistry("https://index.docker.io/v1/",'docker-hub-credentials'){
                        sh "docker push ${DOCKER_REGISTRY}/${DOCKER_REPO}:latest"
                    }
                }
            }
        }
        stage('Deploy with Docker'){
            steps{
                sh 'docker compose up -d'
            }
        }
        stage('clean workspace'){
            steps{
                sh 'rm -rf'
            }
        }
    }
}