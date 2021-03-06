def job_name = env.JOB_NAME.split("-")
def project_name = job_name[0]
def is_dryrun = job_name[-1] == "dryrun"
def is_apply = ""
def backend_config_path = ""
def tfvars_path = ""

parameters {
    string(name: "REGION")
    string(name: "TERRAFORM")
    
}

pipeline {
    agent any
    options {
        ansiColor('xterm')
    }

    stages {
        stage("Params") {
            steps {
                echo "Params"
                echo "${params.REGION}"
                echo "${params.TERRAFORM}"
                echo "${job_name}"
                script {
                    backend_config_path = "./config/poc/${params.REGION}.backend"
                    tfvars_path = "./config/poc/${params.REGION}.tfvars"
                }
            }
        }
        stage("Init") {
            steps {
                withCredentials(
                [[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-credential',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]
                ) {
                sh ("cd src/; terraform init -backend-config=${backend_config_path}")
                }
            }
        }
        // terraform plan
        stage("Plan") {
            steps {
                echo "Plan"
                sh("cd src/;terraform plan -var-file=${tfvars_path}")
            }
        }
        // デプロイするしないの分岐
        stage("Branch") {
            when {
                not {
                    // dryrunジョブならデプロイしない
                    equals(expected: true, actual: is_dryrun)
                }
            }
            steps {
                timeout(unit: "MINUTES", time: 5) {
                    echo "Branch"
                    script{
                        // デプロイするならapplyと入力
                        is_apply =  input message: "apply or not",
                                            parameters: [string(defaultValue: "",
                                            description: "",
                                            name: "enter 'apply' to deploy")]
                    }
                }
            }
        }
        stage("Apply") {
            when {
                expression {
                    // 入力値がapplyかチェック
                    return is_apply == "apply"
                }
            }
            steps {
                echo "Apply"
                //sh("cd src/; terraform apply -var-file=${tfvars_path}")
            }
        }
    }
}
