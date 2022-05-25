pipeline {
    agent any
    environment {
        registry = "kerenkay/DattoExercise"
        registryCredential = 'docker_hub'
    }
    options {
        buildDiscarder(logRotator(numToKeepStr: '20', daysToKeepStr: '5' ))
    }
    stages {
        stage('Pull Code') {
            steps {
                script {
                    sh 'echo pull code'
                    sh 'git clone https://github.com/kerenkay/DattoExercise.git'
                }
            }
        }
        stage('run tests') {
            steps {
                script {
                    sh 'echo run tests'
	                sh 'python -m ./microservice/test/test_service.py'
                }
            }
        }
        stage('build and push image') {
            steps {
                script {
                    sh 'build and push image to hub'
                    sh 'build -t exercise/keren-img .'
                    sh 'echo $docker_hub_PSW | docke login -u $docker_hub_USR --password-stdin'
                    sh 'docker push exercise/keren-img'
                }
            }
        }
        stage('deploy image') {
            steps {
                script {
                    sh 'build docker image'
                    sh 'kubectl apply -f deployment.yaml'
                }
            }
        }
    }
}
