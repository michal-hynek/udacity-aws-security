#!/bin/bash
source .outputs

echo "Load Balancer IP: $ALB_DNS"
echo "Application Server IP: $APP_EC2_IP"
echo "Attack Server IP: $ATTACK_EC2_IP"
echo "Free Recipes S3 Bucket: $FREE_RECIPES_S3_BUCKET"
echo "Secret Recipes S3 Bucket: $SECRET_RECIPES_S3_BUCKET"