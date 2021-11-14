parameters {
    string(name: 'REGION')
    string(name: 'TERRAFORM')
}

pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                echo "${params.REGION}"
                echo "${params.TERRAFORM}"
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
