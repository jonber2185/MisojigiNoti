# CGV Notification

> 기기 캘린더에서 CGV 근무 일정을 읽어 출근 알람과 휴게 알람을 자동으로 설정해주는 Flutter 모바일 앱입니다.

[English](README.md)

![홈](./images/home.jpg)

---

## 기능

- **아침 설정** — 오늘 근무 일정을 캘린더에서 읽어 알람을 한 번에 등록
- **출근 알람** — 근무 시작 3분 전에 알림
- **휴게 전 알람** — 근무 시작 1시간 50분 후에 알림, 정확한 휴게 시작 시간 입력 유도
- **휴게 종료 알람** — 실제 휴게 시작 시간 입력 시 27분 후(휴게 종료 3분 전)에 알림
- **알람 현황** — 현재 등록된 알람 4개의 상태 확인

## 스크린샷

### 권한 요청

최초 실행 시 알림과 캘린더 접근 권한을 요청합니다. 알람 동작에 둘 다 필요합니다.

<table>
  <tr>
    <td align="center"><img src="./images/permission_noti.jpg" width="240"/><br/>알림 권한</td>
    <td align="center"><img src="./images/permission_calendar.jpg" width="240"/><br/>캘린더 권한</td>
  </tr>
</table>

### 홈

![홈](./images/home.jpg)

아침 설정, 휴게 시간, 알람 현황으로 이동하는 3개의 카드.

### 아침 설정

Morning 카드를 탭하면 오늘 캘린더 일정을 읽어 출근·휴게 알람을 자동으로 등록합니다.

<table>
  <tr>
    <td align="center"><img src="./images/morning_toast.jpg" width="240"/><br/>일정 등록 완료</td>
    <td align="center"><img src="./images/alarms_morning.jpg" width="240"/><br/>아침 설정 이후 알람 상태</td>
  </tr>
</table>

### 휴게 설정

실제 휴게 시작 시간을 입력하면 27분 후(휴게 종료 3분 전)에 알람이 울립니다.

<table>
  <tr>
    <td align="center"><img src="./images/break_picker.jpg" width="240"/><br/>타임 피커</td>
    <td align="center"><img src="./images/break_toast.jpg" width="240"/><br/>휴게 시간 설정 완료</td>
    <td align="center"><img src="./images/alarms_break.jpg" width="240"/><br/>휴게 설정 이후 알람 상태</td>
  </tr>
</table>

## 기술 스택

| 레이어 | 기술 |
|---|---|
| 프레임워크 | Flutter |
| 언어 | Dart |
| 알림 | [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) |
| 캘린더 접근 | [device_calendar](https://pub.dev/packages/device_calendar) |
| 타임존 | [timezone](https://pub.dev/packages/timezone) / [flutter_timezone](https://pub.dev/packages/flutter_timezone) |
| 토스트 | [fluttertoast](https://pub.dev/packages/fluttertoast) |
| 권한 | [permission_handler](https://pub.dev/packages/permission_handler) |

## 시작하기

### 요구사항

- Flutter SDK
- Android 또는 iOS 기기 / 에뮬레이터

### 설치

```bash
flutter pub get
```

### 실행

```bash
flutter run
```

### 빌드

```bash
# Android
flutter build apk

# iOS
flutter build ios
```

---

## 필요 권한

- **알림** — 로컬 알람 예약 및 실행
- **캘린더 (전체 접근)** — 오늘 근무 일정 읽기