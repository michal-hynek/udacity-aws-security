#!/bin/bash
source .env

# deploy s3 buckets
aws cloudformation deploy --region $REGION --stack-name c3-s3 --template-file ./c3-s3.yml --profile $AWS_PROFILE
# deploy vpc
aws cloudformation deploy --region $REGION --stack-name c3-vpc --template-file ./c3-vpc.yml --profile $AWS_PROFILE
# deploy application resources
aws cloudformation deploy --region $REGION --stack-name c3-app --template-file ./c3-app.yml --parameter-overrides KeyPair=$EC2_KEY_PAIR --capabilities CAPABILITY_IAM --profile $AWS_PROFILE

# load the outputs from the created stacks
source .outputs

# upload files
aws s3 cp ./free_recipe.txt s3://$FREE_RECIPES_S3_BUCKET/ --region $REGION
aws s3 cp ./secret_recipe.txt s3://$SECRET_RECIPES_S3_BUCKET/ --region $REGION

# test the application
curl -s $ALB_DNS/free_recipe
if [ $? -eq 0 ]; then
    echo "SUCCESS!!!"
else
    echo "Couldn't contact the website"
    return 1
fi

# print the variables
echo "Load Balancer IP: $ALB_DNS"
echo "Application Server IP: $APP_EC2_IP"
echo "Attack Server IP: $ATTACK_EC2_IP"
echo "Free Recipes S3 Bucket: $FREE_RECIPES_S3_BUCKET"
echo "Secret Recipes S3 Bucket: $SECRET_RECIPES_S3_BUCKET"

return 0