def job_name = env.JOB_NAME.split('-')
def project_name = job_name[0]
def is_dryrun = job_name[-1] == 'dryrun'

parameters {
    string(name: 'REGION')
    string(name: 'TERRAFORM')
}

pipeline {
    agent any

    stages {
        stage('Params') {
            steps {
                echo 'Building..'
                echo "${params.REGION}"
                echo "${params.TERRAFORM}"
                echo "${job_name}"
            }
        }
        stage('Init') {
            steps {
                echo ' Initializing....'
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
                input message: ‘Approve Deploy?’, ok: ‘Yes’
            }
        }
        stage('Apply') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
