region = env.REGION

pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                echo region
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
