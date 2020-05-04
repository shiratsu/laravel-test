# タスク定義を登録

```
aws --profile all ecs register-task-definition --cli-input-json file://Users/hiratsukashu/vscode/laravel-test/fargate-laravel-task.json
```

# サービス作成

```
aws --profile all ecs create-service --cluster hiratsuka-laravel-test --service-name hiratsuka-laravel-service --task-definition fargate-laravel-app:1 --desired-count 1 --launch-type "FARGATE" --network-configuration "awsvpcConfiguration={subnets=[subnet-0f230902a7219fd5d],securityGroups=[sg-0287ed2754acf2cd5]}"
```

# スケールを調整

# タスク実行