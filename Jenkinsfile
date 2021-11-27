def job_name = env.JOB_NAME.split('-')
def project_name = job_name[0]
def is_dryrun = job_name[-1] == 'dryrun'
def is_apply = ''

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
                timeout(unit: 'MINUTES', time: 1){
                    echo 'Deploying....'
                    script{
                        is_apply =  input message: 'Please enter the username',
                                        parameters: [string(defaultValue: '',
                                            description: '',
                                            name: 'Username')]
                    }
                }
            }
        }
        stage('Apply') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
