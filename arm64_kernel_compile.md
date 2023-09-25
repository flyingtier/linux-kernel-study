# arm64 kernel compile

## prepare build environment

```bash
$ sudo apt install crossbuild-essential-arm64 bc bison flex libssl-dev make libc6-dev libncurses5-dev
```

## download linux kernel

```bash
$  git clone --depth=1 --branch rpi-6.1.y https://github.com/raspberrypi/linux
```

## build script

### defconfig

```bash
#!/bin/bash

echo "configure build output path..."
KERNEL_TOP_PATH="$(cd "$(dirname "$0")"; pwd -P)"
OUTPUT_PATH="$KERNEL_TOP_PATH/out" # use custom build artifact path
echo "Output Path: ${OUTPUT_PATH}"

BUILD_LOG_PATH="$KERNEL_TOP_PATH/make_defconf.log"

echo "move to kernel source tree..."
cd linux-kernel-arm

echo "make mrproper..."
make mrproper

echo "make defconfig..."
make O=$OUTPUT_PATH ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig 2>&1 | tee $BUILD_LOG_PATH
 ```

### menuconfig

```bash
#!/bin/bash

echo "configure build output path..."
KERNEL_TOP_PATH="$(cd "$(dirname "$0")"; pwd -P)"
OUTPUT_PATH="$KERNEL_TOP_PATH/out" # use custom build artifact path
echo "Output Path: ${OUTPUT_PATH}"

BUILD_LOG_PATH="$KERNEL_TOP_PATH/make_menuconfig.log"

echo "move to kernel source tree..."
cd linux-kernel-arm

echo "make menuconfig..."
make O=$OUTPUT_PATH ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig 2>&1 | tee $BUILD_LOG_PATH
```

### kernel build

```bash
#!/bin/bash

echo "configure build output path..."
KERNEL_TOP_PATH="$(cd "$(dirname "$0")"; pwd -P)"
OUTPUT_PATH="$KERNEL_TOP_PATH/out" # use custom build artifact path
echo "Output Path: ${OUTPUT_PATH}"

BUILD_LOG_PATH="$KERNEL_TOP_PATH/kernel_build.log"

echo "move to kernel source tree..."
cd linux-kernel-arm

echo "make kernel build..."
make O=$OUTPUT_PATH ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc) 2>&1 | tee $BUILD_LOG_PATH
```

### script file 실행 권한

```bash
$ sudo chmod +x file_name.sh
```

## kernel build

```bash
$ ./make_defconfig.sh
$ ./make_menuconfig.sh
$ ./make_kernel_build.sh
```

커널 빌드가 완료되면, 커널 디렉토리 안에 vmlinux가 생성된다.  
arch/arm64/boot 에는 Image가 생성된다.


## qemu..

qemu를 사용해 빌드한 커널 이미지를 가상 보드에 올리고 gdb와 연결해 디버깅 할 수 있다.

### qemu package 설치

```bash
$ sudo apt install gdb-multiarch
$ sudo apt install qemu-system-aarch64
```

### linux kernel boot on qemu script

커널 이미지 경로는 각자 환경에 맞게 수정해야 한다.

```bash
#!/bin/sh
qemu-system-aarch64 \
    -S \
    -machine virt \
    -cpu cortex-a57 \
    -machine type=virt \
    -nographic \
    -smp 4 \
    -m 4096 \
    -kernel /usr/src/linux-stable/arch/arm64/boot/Image \
    --append "console=ttyAMA0 nokaslr" \
    -s
```

### 스크립트 파일 실행 권한..

```bash
$ sudo chmod +x file_name.sh
```

### qemu 시작하기

1. 위에서 작성한 스크립트 실행 - 화면이 멈춘것 처럼 보임
2. 터미널을 하나 더 열어 아래와 같이 입력
```bash
$ gdb-multiarch
(gdb) set arch aarch64
(gdb) target remote:1234
(gdb) file vmlinux
```

### gdb 관련 추가 내용..

http://jake.dothome.co.kr/gdb2/#comment-308124

gdb 관련 플러그인 - 플러그인마다 인터페이스에 조금씩 차이가 있음  
gef: https://github.com/hugsy/gef  
peda: https://github.com/longld/peda  
pwngdb: https://github.com/scwuaptx/Pwngdb  
pwndbg: https://github.com/pwndbg/pwndbg

#### 자주 사용하는 명령어(pwndbg)로는 

ni (next instruction, n으로 대체 가능)  
si (step into, s로 대체 가능)  
finish (step into로 들어갔다가 나오고 싶을 때)  
b *함수명 또는 b *주소 (break point)  
c (continue)  
r (run)  
disassemble 함수명 (disassemble, disass로 대체 가능)  
info registers (register들 출력, i r로 대체 가능)  
info registers 레지스터명 (특정 레지스터만 출력, 레지스터명은 info registers로 확인한 이름으로 써야합니다.)  
set $레지스터명=값 (레지스터 값 변경, 흐름 바꿔서 디버깅하고 싶을 때)  
x/10gx 주소 (주소로부터 8바이트씩 10개의 값을 hex로 출력, g는 giant(8바이트)를 의미, x는 hex를 의미)  
x/10wi 주소 (주소로부터 4바이트씩 10개의 값을 명령어로 출력, w는 word(4바이트)를 의미, i는 instruction을 의미)  
x/s 주소 (주소의 문자열 출력, s는 string을 의미)  
...
