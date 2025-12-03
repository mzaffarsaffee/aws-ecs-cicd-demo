# ECR Repository
resource "aws_ecr_repository" "app_repo" {
  name = "my-demo-repo"
  force_delete = true # Allows deleting repo even if it has images (good for demos)
}

# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "my-demo-cluster"
}

# ECS Task Definition (The Blueprint for the container)
resource "aws_ecs_task_definition" "app" {
  family                   = "my-demo-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256" # Smallest size
  memory                   = "512" # Smallest size
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "my-demo-app-container"
      image     = "${aws_ecr_repository.app_repo.repository_url}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}

# ECS Service
resource "aws_ecs_service" "main" {
  name            = "my-demo-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true # Required because we are in public subnets
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.blue.arn
    container_name   = "my-demo-app-container"
    container_port   = 3000
  }
  
  # Ignore changes to task_definition because CodeDeploy handles updates, not Terraform
  lifecycle {
    ignore_changes = [task_definition, load_balancer]
  }
}