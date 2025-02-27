pipeline{
    agent any

    environment{
        DOCKER_HUB_CREDENTIALS=credentials('docker-hub-credentials')
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
                sh 'docker build -t ${DOCKER_HUB_CREDENTIALS_USR}/todo-application-image:latest .'
            }
        }
        stage('Push Docker Image'){
            steps{
                sh 'echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u DOCKER_HUB_CREDENTIALS_USR --password-stdin'
                sh 'docker push ${DOCKER_HUB_CREDENTIALS_USR}/todo-application-image:latest'
            }
        }
        stage('Deploy with Docker'){
            steps{
                sh 'docker compose up -d'
            }
        }
        stage('clean workspace'){
            steps{
                cleanWs()
            }
        }
    }
}
