// Peer Review 1, 2, 5번

// ✅ 로직 설명
// 1. 작업 시간 및 휴식 시간 함수 선언
// 2. 메인 함수에서 첫 번째 사이클 시작
// 3. 커스텀: 최대 반복 횟수를 설정하여 도달 시 종료
// 4. 시간 설정: 작업 시간 = 25*60, 짧은 휴식 = 5*60, 긴 휴식 = 15*60
// 5. 4회차마다 25분 작업 후 15분 휴식 적용

import 'dart:async';

const int QUARTER = 4;
const int MAX_CYCLE = 5; // 최대 반복 횟수 임의로 설정
const int WORK_DURATION = 25 * 60; // 작업 시간 (25분)
const int SHORT_BREAK = 5 * 60; // 짧은 휴식 (5분)
const int LONG_BREAK = 15 * 60; // 긴 휴식 (15분)
void main() {
  print('flutter: Pomodoro 타이머를 시작합니다.');
  workTimer(1); // 첫 사이클 시작
}

// 초 단위를 '분:초' 형식으로 변환 -> final 사용
// final: 값이 한 번만 할당되고 변경되지 않음을 보장
// const는 사용 불가능한지? -> 런타임에 계산되는 값이므로 컴파일 타임 상수(const)로는 사용 불가
String formatTime(int seconds) {
  final min = (seconds ~/ 60).toString().padLeft(2, '0');
  final sec = (seconds % 60).toString().padLeft(2, '0');
  return '$min:$sec';
}

// 작업 타이머
void workTimer(int cycle) {
  // cycle: 현재 작업 사이클 번호
  // 최대 반복 횟수 도달 시 종료
  if (cycle > MAX_CYCLE) {
    print('flutter: 최대 반복 횟수 도달. 프로그램 종료합니다.');
    return;
  }

  int workTime = WORK_DURATION; // 작업 시간 초기화
  Timer.periodic(Duration(seconds: 1), (Timer t) {
    print('flutter 작업: ${formatTime(workTime--)}'); // 남은 시간 출력 후 감소

    // 작업 시간 끝났을 때
    if (workTime < 0) {
      t.cancel(); // 타이머 중지
      print('flutter: 작업 시간이 종료되었습니다. 휴식 시간을 시작합니다.');

      // 휴식 시간 결정 (4회차 마다 긴 휴식, 그 외 짧은 휴식 적용)
      breakTimer(cycle, (cycle % QUARTER == 0) ? LONG_BREAK : SHORT_BREAK);
    }
  });
}

// 휴식 타이머
void breakTimer(int cycle, int breakTime) {
  // cycle: 현재 작업 사이클 번호, breakTime: 휴식 시간
  Timer.periodic(Duration(seconds: 1), (Timer t) {
    print('flutter 휴식: ${formatTime(breakTime--)}'); // 남은 시간 출력 후 감소

    // 휴식 시간이 끝났을 때
    if (breakTime < 0) {
      t.cancel(); // 타이머 중지
      print('flutter: 휴식 시간이 종료되었습니다.');

      workTimer(++cycle); // 다음 작업 사이클 시작 (cycle 증가 후 호출)
    }
  });
}


// Peer Review 3번
// 💡 새로운 시도
// 윗 코드에서 MAX_CYCLE: 최대 반복 횟수 추가
// 💡 추가 실험
//  분기별로 if로 나누어 로직 작성
// void startPomodoro({int workMinutes = 25, int breakMinutes = 5}) {
//   int workSeconds = workMinutes * 60;
//   int breakSeconds = breakMinutes * 60; //분 단위를 초 단위로 변환
//   Timer.periodic(Duration(seconds: 1), (Timer timer) {
//     //Timer.periodic : 일정 시간마다 반복 실행 / Duration(seconds:1) : 1초마다 실행되도록 설정 / (Timer timer){} : 타이머가 실행될 때 실행할 코드
//     if (workSeconds > 0) {
//       if (workSeconds > 0) {
//         if (workSeconds == 20 * 60) print("20분 남았습니다.");
//         if (workSeconds == 15 * 60) print("15분 남았습니다.");
//         if (workSeconds == 10 * 60) print("10분 남았습니다.");
//         if (workSeconds == 5 * 60) print("5분 남았습니다.");
//         if (workSeconds == 60) print("1분 남았습니다.");
//         if (workSeconds == 30) print("30초 남았습니다.");
//       } else if (breakSeconds > 0) {
//         print("휴식 시간: ${breakSeconds--}초 남았습니다.");
//       } else {
//         print("한 세트가 완료되었습니다. 다시 시작합니다.");
//         timer.cancel(); //Timer.periodic으로 반복 실행 되던 걸 멈춤.
//         startPomodoro();
//       }
//     }
//   });
// }

// Peer Review 4번
// 📝 회고
// 홍지수: 코드를 작성하는 것보다 지윤님의 환경에서 실행되지 않는 코드가
// 내가 사용하는 환경(vscode)에서는 정상 작동해 원인을 파악하는 데 시간이 걸렸다.
// 코드를 분석해보니 잘 짜여 있어서 당황했지만, 퍼실님의 도움으로 문제의 원인이 환경에 있다는 것을 알게 되었다!
// 역시 코드를 잘 짜는 것도 중요하지만, 기본적으로 환경 설정이 제대로 되어 있어야 한다는 점을 다시 한번 깨달았다.

// 박지윤:  지수님 것에서는 되었는데 내 것에서 안 돌아가서 되게 당황스러웠다 ㅜㅜ 그래도 코드에 오류가 있는 건 아니라서 다행인 것 같다. 
// 처음에는 초가 다 뜨게 했는데, 너무 난잡해서 5분 단위로 뜨게 바꿔보았다. 
// 그랬더니 이게 제대로 돌아가는 게 맞나? 생각이 들었다. 
// 좀 덜 난잡하면서 제대로 돌아가는게 맞다는 걸 확인 받을 수 있는?? 그런 기능을 넣으면 좋을 것 같다.
