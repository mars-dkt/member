environment {
    productName = "mgmt"
    componentName = "coffeepot"
    // The branch name is filtered to remove invalid Docker tag characters
    imageTag = "${env.DOCKER_ARTIFACT_REGISTRY}/${productName}-${componentName}:${env.BRANCH_NAME.toLowerCase().replaceAll('[^a-z0-9\\.\\_\\-]', '-')}-${env.BUILD_NUMBER}"
}
node {
     stage('Clone repository') {
         checkout scm
     }
     stage('Build image') {
        echo "Building Docker image using Dockerfile with tag"
        sh "docker build --tag=asia-northeast3-docker.pkg.dev/dev-settlement-onepage-project/dev-onepage-kr-ar/quickstart-image:tag${env.BUILD_NUMBER} ."
     }
     stage('Push image') {
             withCredentials([string(credentialsId: 'gcp-key', variable: 'GOOGLE_CLOUD_KEY')]) {
                 writeFile file: 'key.json', text: "${GOOGLE_CLOUD_KEY}"
                 sh """
                     gcloud auth activate-service-account --key-file=key.json
                     gcloud auth configure-docker asia-northeast3-docker.pkg.dev --quiet
                     docker push asia-northeast3-docker.pkg.dev/dev-settlement-onepage-project/dev-onepage-kr-ar/quickstart-image:tag${env.BUILD_NUMBER}
                 """
             }
            sh "gcloud auth configure-docker asia-northeast3-docker.pkg.dev"
            sh "docker push asia-northeast3-docker.pkg.dev/dev-settlement-onepage-project/dev-onepage-kr-ar/quickstart-image:tag${env.BUILD_NUMBER}"
     }
}
