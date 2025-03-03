
pipeline{
    agent any

    environment{
        DOCKER_REGISTRY='errolcostabir'
        IMAGE_NAME='todo-application-image'
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
                script{
                    docker.withRegistry("https://index.docker.io/v1/",'docker-hub-credentials'){
                        sh "docker build -t ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest ."
                    }
                }
            }
        }
        stage('Push Docker Image'){
            steps{
                script{
                    docker.withRegistry("https://index.docker.io/v1/",'docker-hub-credentials'){
                        sh "docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest"
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