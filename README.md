# SDKMAN PowerShell 实现

## 项目简介

这是一个用 PowerShell 实现的 SDKMAN 客户端，用于管理多个 SDK 版本，支持在 Windows 系统上方便地安装、使用和切换不同版本的 SDK（如 Java、Maven、Gradle 等）。

## 安装步骤

### 1. 创建 PowerShell 模块目录

在用户目录下创建 PowerShell 模块文件夹：

```powershell
# 打开 PowerShell 并执行
New-Item -ItemType Directory -Path "$HOME\Documents\WindowsPowerShell\Modules" -Force
```

### 2. 克隆项目

将本项目克隆到刚刚创建的模块目录中：

```powershell
# 切换到模块目录
cd "$HOME\Documents\WindowsPowerShell\Modules"

# 克隆项目
git clone https://github.com/YanGaofanygf/sdkman-ps.git
```

### 3. 导入模块

打开新的 PowerShell 会话，模块会自动加载，或者手动导入：

```powershell
# 手动导入模块
Import-Module sdkman-ps
```

## 使用方法

### 基本命令

```powershell
# 查看版本
sdk version

# 安装 SDK
sdk install <候选名称> <版本号>

# 使用特定版本
sdk use <候选名称> <版本号>

# 列出可用版本
sdk list <候选名称>
```

### 示例

```powershell
# 安装 Java 11
sdk install java 11.0.15

# 使用 Java 11
sdk use java 11.0.15

# 列出可用的 Maven 版本
sdk list maven

# 安装 Maven 3.8.6
sdk install maven 3.8.6
```

## 功能介绍

### 核心功能

- **安装 SDK**：从 SDKMAN 仓库下载并安装指定版本的 SDK
- **版本管理**：在多个 SDK 版本之间切换
- **环境变量配置**：自动配置 JAVA_HOME 和 PATH 环境变量
- **版本列表**：查看可用的 SDK 版本

### 支持的 SDK

- Java
- Maven
- Gradle
- Kotlin
- Scala
- Groovy
- 以及更多...

## 配置

模块会在用户目录下创建 `.sdkman` 文件夹，用于存储下载的 SDK 和配置信息：

```
~/.sdkman/
├── candidates/        # 存储各个 SDK 的不同版本
├── tmp/               # 临时文件
└── config             # 配置文件
```

## 系统要求

- Windows 系统
- PowerShell 5.1 或更高版本
- 网络连接（用于下载 SDK）

## 注意事项

1. 首次使用时，模块会自动配置 JAVA_HOME 和 PATH 环境变量
2. 环境变量的更改需要重新打开 PowerShell 会话才能生效
3. 确保网络连接正常，以便下载 SDK

## 故障排除

### 常见问题

- **无法下载 SDK**：检查网络连接，确保能够访问 https://broker.sdkman.io
- **环境变量未更新**：重新打开 PowerShell 会话，或者手动更新环境变量
- **模块未加载**：确保模块已正确克隆到 `$HOME\WindowsPowerShell\Modules` 目录

### 手动更新环境变量

```powershell
# 手动更新当前会话的环境变量
$env:JAVA_HOME = "$HOME\.sdkman\candidates\java\current"
$env:PATH = "$env:PATH;$env:JAVA_HOME\bin"
```

## 贡献

欢迎提交 Issue 和 Pull Request 来改进这个项目！

## 许可证

本项目采用 MIT 许可证。