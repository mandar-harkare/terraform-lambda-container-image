# Deploy Lambda from Iamge created from Dockerfile

### Prequisite
- Terraform
- AWS CLI

## Steps
- Login to AWS CLI

<del>
- Have environment variables ready AWS_ACCOUNT & AWS_REGION
- Create the ECR first
    ```
    aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com
    aws ecr create-repository --region ${AWS_REGION} --repository-name mh-test --image-scanning-configuration scanOnPush=true --image-tag-mutability MUTABLE
    ```
    - Note repositoryUri from the output
- Tag your image to match your repository name
    - Build new image from Dockerfile with tag
        ```
        docker build -t ${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/mh-test:latest .
        ```
        Or tag existing image
        ```
        docker tag  mh-test:latest ${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/mh-test:latest
        ```
    ```
    docker push ${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/mh-test:latest
    ```

</del>

- Above steps are depricated as are handled in terraform itself
- Create ECR & Image from Dockerfile, push it to the ECR and deploy the Lmabda from the ECR Image
    ```
    terraform init
    terraform plan -var "aws_account=$AWS_ACCOUNT"
    terraform apply -var "aws_account=$AWS_ACCOUNT"

    ```