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

    stages {
        stage("Params") {
            steps {
                echo "Params"
                echo "${params.REGION}"
                echo "${params.TERRAFORM}"
                echo "${job_name}"
            }
        }
        stage("Init") {
            steps {
                echo "Init"
                script{
                    backend_config_path = "./config/poc/${params.REGION}.backend"
                    tfvars_path = "./config/${params.REGION}.tfvars"
                    sh( "cd src/; terraform init -backend-config=${backend_config_path}" )
                }
            }
        }
        // terraform plan
        stage("Plan") {
            steps {
                echo "Plan"
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
                    echo "Deploying...."
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
                echo "${is_apply}"
            }
        }
    }
}
