#!/bin/bash
#
#set -e
#
#REGION="us-east-1"
#ACCOUNT_ID="122794303175"
#
#echo "🔍 Verifying AWS identity..."
#aws sts get-caller-identity
#
#echo "🗑️ Deleting ECR repositories..."
#repos=(
#  "api-gateway"
#    "auth-service"
#      "pharma-ui"
#        "notification-service"
#          "drug-catalog-service"
#            "supplier-service"
#              "inventory-service"
#                "manufacturing-service"
#                )
#
#                for repo in "${repos[@]}"; do
#                  echo "Deleting ECR repo: $repo"
#                    aws ecr delete-repository \
#                        --repository-name "$repo" \
#                            --force \
#                                --region "$REGION" || echo "Repo $repo not found, skipping"
#                                done
#
#                                echo "🗑️ Deleting IAM roles..."
#                                roles=(
#                                  "pharma-dev-eks-cluster-role"
#                                    "pharma-dev-eks-node-group-role"
#                                    )
#
#                                    for role in "${roles[@]}"; do
#                                      echo "Deleting IAM role: $role"
#
#                                        # Detach attached policies
#                                          attached_policies=$(aws iam list-attached-role-policies --role-name "$role" --query 'AttachedPolicies[*].PolicyArn' --output text 2>/dev/null || true)
#                                            for policy in $attached_policies; do
#                                                aws iam detach-role-policy --role-name "$role" --policy-arn "$policy"
#                                                  done
#
#                                                    # Delete inline policies
#                                                      inline_policies=$(aws iam list-role-policies --role-name "$role" --query 'PolicyNames[*]' --output text 2>/dev/null || true)
#                                                        for policy in $inline_policies; do
#                                                            aws iam delete-role-policy --role-name "$role" --policy-name "$policy"
#                                                              done
#
#                                                                aws iam delete-role --role-name "$role" || echo "Role $role not found, skipping"
#                                                                done
#
#                                                                echo "🗑️ Deleting IAM policies..."
#                                                                policies=(
#                                                                  "pharma-dev-github-actions-policy"
#                                                                    "pharma-dev-eso-secrets-policy"
#                                                                      "pharma-dev-gitlab-runner-policy"
#                                                                      )
#
#                                                                      for policy in "${policies[@]}"; do
#                                                                        POLICY_ARN="arn:aws:iam::$ACCOUNT_ID:policy/$policy"
#                                                                          echo "Deleting policy: $policy"
#                                                                            aws iam delete-policy --policy-arn "$POLICY_ARN" || echo "Policy $policy not found, skipping"
#                                                                            done
#
#                                                                            echo "🗑️ Deleting OIDC provider..."
#                                                                            OIDC_ARN=$(aws iam list-open-id-connect-providers \
#                                                                              --query "OpenIDConnectProviderList[?contains(Arn, 'token.actions.githubusercontent.com')].Arn" \
#                                                                                --output text)
#
#                                                                                if [ -n "$OIDC_ARN" ]; then
#                                                                                  aws iam delete-open-id-connect-provider --open-id-connect-provider-arn "$OIDC_ARN"
#                                                                                  else
#                                                                                    echo "OIDC provider not found, skipping"
#                                                                                    fi
#
#                                                                                    echo "🗑️ Deleting RDS subnet group..."
#                                                                                    aws rds delete-db-subnet-group \
#                                                                                      --db-subnet-group-name pharma-dev-rds-subnet-group \
#                                                                                        --region "$REGION" || echo "Subnet group not found, skipping"
#
#                                                                                        echo "🗑️ Deleting Secrets..."
#                                                                                        secrets=(
#                                                                                          "/pharma/dev/db-credentials"
#                                                                                            "/pharma/dev/jwt-secret"
#                                                                                            )
#
#                                                                                            for secret in "${secrets[@]}"; do
#                                                                                              echo "Deleting secret: $secret"
#                                                                                                aws secretsmanager delete-secret \
#                                                                                                    --secret-id "$secret" \
#                                                                                                        --force-delete-without-recovery \
#                                                                                                            --region "$REGION" || echo "Secret $secret not found, skipping"
#                                                                                                            done
#
#                                                                                                            echo "✅ Cleanup completed. You can now run: terraform apply"
