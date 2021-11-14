parameters {
    string( name: 'REGION')
}

pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                echo '${params.REGION}'
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
