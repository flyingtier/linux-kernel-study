# Lunux Kernel Build

참고 : https://sagik.tistory.com/m/51

## Kernel Build

### Build Dependency

arm64용 cross compile을 위한 패키지 설치
```bash
$ sudo apt-get build-dep linux linux-image-$(uname -r)
$ sudo apt-get install libncurses-dev gawk flex bison openssl libssl-dev dkms libelf-dev libudev-dev libpci-dev libiberty-dev autoconf llvm
$ sudo apt-get install gcc-aarch64-linux-gnu
$ sudo apt-get install g++-aarch64-linux-gnu
```

### Kernel Source 다운로드

MainLine Kernel(=Vanilla) 다운로드
```bash
$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
$ git tag  | grep 5.19
$ git checkout v5.19
```

### Kernel Configuration

menuconfig 에서 RAM Disk 지원 기능(CONFIG_BLK_DEV_RAM) 활성화
- Device Drivers > Block devices > RAM block device support
```bash
$ cd linux
$ make ARCH=arm64 mrproper
$ make ARCH=arm64 O=../out defconfig -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu-
$ make ARCH=arm64 O=../out menuconfig -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu-
```

