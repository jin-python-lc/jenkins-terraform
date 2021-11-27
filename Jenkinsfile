def job_name = env.JOB_NAME

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
                echo "${job_name}"
            }
        }
        stage('Plan') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Branch') {
            steps {
                echo 'Deploying....'
            }
        }
        stage('Apply') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
