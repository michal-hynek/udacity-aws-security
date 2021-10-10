#!/bin/bash
AWS_PROFILE=udacity
REGION=us-east-1

aws cloudformation delete-stack --stack-name c3-app --region $REGION --profile $AWS_PROFILE
aws cloudformation delete-stack --stack-name c3-s3 --region $REGION --profile $AWS_PROFILE
aws cloudformation delete-stack --stack-name c3-vpc --region $REGION --profile $AWS_PROFILE
