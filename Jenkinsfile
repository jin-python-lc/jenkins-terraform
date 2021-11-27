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
                echo 'Params'
                echo "${params.REGION}"
                echo "${params.TERRAFORM}"
                echo "${job_name}"
            }
        }
        stage('Init') {
            steps {
                echo 'Init'
            }
        }
        stage('Plan') {
            steps {
                echo 'Plan'
            }
        }
        stage('Branch') {
            when {
                not {
                    equals(expected: true, actual: is_dryrun)
                }
            }
            steps {
                timeout(unit: 'MINUTES', time: 1) {
                    echo 'Deploying....'
                    /* script{
                        is_apply =  input message: 'apply or not',
                                        parameters: [string(defaultValue: '',
                                            description: '',
                                            name: 'enter "apply" to apply')]
                    } */
                    input message: 'apply or not'
                }
            }
        }
        stage('Apply') {
            /* when {
                expression {
                    return is_apply == 'apply'
                }
            } */
            steps {
                echo 'Apply......'
                echo "${is_apply}"
            }
        }
    }
}
