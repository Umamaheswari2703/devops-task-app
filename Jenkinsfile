pipeline {

    agent any

    environment {

        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')

        DOCKERHUB_REPO = 'umamaheswaris/devops-task-app'

        DOCKER_IMAGE_TAG = 'latest'
    }

    tools {

        maven 'mymaven'
    }

    stages {

        stage('Checkout') {

            steps {

                echo 'Checking out source code...'

                git(
                    url: 'https://github.com/Umamaheswari2703/devops-task-app.git',
                    branch: 'main'
                )
            }
        }


        stage('Maven Build') {

            steps {

                echo 'Building application using Maven...'

                sh 'mvn clean package'
            }
        }


        stage('Run Tests') {

            steps {

                echo 'Running unit tests...'

                sh 'mvn test'
            }
        }


        stage('Build Docker Image') {

            steps {

                echo 'Building Docker image...'

                sh '''
                    docker build \
                    -t $DOCKERHUB_REPO:$DOCKER_IMAGE_TAG .
                '''
            }
        }


        stage('DockerHub Login') {

            steps {

                echo 'Logging into DockerHub...'

                sh '''
                    echo $DOCKERHUB_CREDENTIALS_PSW | \
                    docker login \
                    -u $DOCKERHUB_CREDENTIALS_USR \
                    --password-stdin
                '''
            }
        }


        stage('Push Docker Image') {

            steps {

                echo 'Pushing image to DockerHub...'

                sh '''
                    docker push \
                    $DOCKERHUB_REPO:$DOCKER_IMAGE_TAG
                '''
            }
        }


      stage('Deploy to Kubernetes') {
    steps {
        echo 'Deploying application to Kubernetes...'

        sh '''
            kubectl apply -f k8s/deployment.yaml
            kubectl apply -f k8s/service.yaml
        '''
    }
}


    post {

        success {

            echo '======================================'
            echo 'PIPELINE COMPLETED SUCCESSFULLY'
            echo '======================================'
        }

        failure {

            echo '======================================'
            echo 'PIPELINE FAILED'
            echo '======================================'
        }
    }
}
