# Arm Assembly 명령어

## SPSR(Saved Program Status Register)과 PSTATE(Processor State)



## 분기 명령어

https://sunrinjuntae.tistory.com/114

### b 명령어 (Branch)
: b 명령어 뒤에 지정된 상수값에 해당하는 주소로 분기하는 명령
: b 명령은 분기 주소로 레지스터를 쓸 수 없음..
ex)
    b primary_entry : global_label  
    b 1f : local_label  
    b . : 무한 루프(.은 제자리를 의미)

### bl 명령어 (Branch and Link) - 함수 콜, 리턴에 해당
: bl 명령어 뒤에 지정된 상수값에 해당하는 주소로 분기
: b 명령과 차이는 b는 PC를 업데이트 하고 끝이지만, bl은 PC 업데이트 후, 레지스터 14번(lr레지스터)에 돌아와서 실행할 다음 명령어의 주소를 업데이트 한다.(돌아와 실행할 주소를 저장)
: 함수의 마지막에 'mov pc, lr'을 사용해 lr 레지스터에 저장했던 주소를 pc로 업데이트해 이전 위치로 돌아와 실행을 할 수 있음..
: 호출된 함수에서 또 다른 함수를 호출할 경우.. 기존에 lr 레지스터의 정보를 메모리에 저장 후 진행..
ex)
    bl recode_mmu_state

### bx 명령어 (Branch Indirect)

### blx 명령어 (Branch Indirect with Link)

(12 - 3) * (4 - 2) + 3 = 9 * 2 + 3
(14 - 3) * (4 - 2) + 3 = 11 * 2 + 3
(16 - 3) * (4 - 2) + 3 = 13 * 2 + 3


## 

### mrs 명령어