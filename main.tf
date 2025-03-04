terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.13.0"
    }
  }
}

provider "docker" {
  host = "npipe:////./pipe/docker_engine"  # เชื่อมต่อ Docker daemon บน Windows
}

# สร้าง Docker image จาก Dockerfile
resource "docker_image" "web_app_image" {
  name = "my-web-app"   # ชื่อของ Docker image
  keep_locally = true            # เก็บไว้ในเครื่อง
  build {
    path = "./"               # ระบุ path ของ Dockerfile ที่อยู่ในโฟลเดอร์เดียวกับไฟล์นี้
    dockerfile = "Dockerfile"  # ชื่อ Dockerfile ถ้าต่างจาก "Dockerfile"

  }
}

# สร้าง Docker container จาก Docker image
resource "docker_container" "web_app_container" {
  name  = "my-web-app-container"   # ชื่อของ Docker container
  image = docker_image.web_app_image.name  # ใช้ image ที่สร้างขึ้น
  ports {
    internal = 3000               # พอร์ตภายใน container
    external = 3000               # พอร์ตที่ expose ออกมา
  }
  env = [                          # แก้ไขเป็น env แทน environment
    "NODE_ENV=production"         # กำหนด environment variable
  ]
}
