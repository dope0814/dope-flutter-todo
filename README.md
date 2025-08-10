# Dope Flutter Todo App

## 🚀 프로젝트 소개

`Dope Flutter Todo App`은 Flutter로 개발된 간단하지만 견고한 할 일 관리 애플리케이션입니다. 백엔드로는 Supabase를 활용하며, 효율적인 상태 관리를 위해 Provider 패키지를 사용합니다.

## ✨ 주요 기능

- **사용자 인증**: 이메일과 비밀번호를 이용한 회원가입, 로그인, 로그아웃 기능
- **실시간 할 일 관리**: 할 일 추가, 완료/미완료 상태 변경, 삭제 기능
- **데이터 영속성**: Supabase PostgreSQL을 통한 데이터 저장 및 관리
- **상태 관리**: Provider 패키지를 활용한 효율적인 UI 업데이트

## 🛠️ 사용된 기술

- **프론트엔드**: Flutter (Dart)
- **백엔드**: Supabase (인증, 실시간 데이터베이스, PostgreSQL)
- **상태 관리**: Provider

## ⚙️ 설치 및 실행 방법

### 1. 필수 전제 조건

- [Flutter SDK](https://flutter.dev/docs/get-started/install) 설치
- [Docker Desktop](https://www.docker.com/products/docker-desktop) 설치 및 실행
- [Supabase CLI](https://supabase.com/docs/guides/cli/getting-started) 설치 (`brew install supabase/tap/supabase`)

### 2. 프로젝트 설정

1.  **리포지토리 클론**: 
    ```bash
    git clone https://github.com/dope0814/dope-flutter-todo.git
    cd dope-flutter-todo
    ```

2.  **Supabase 로컬 환경 설정**: 
    ```bash
    supabase login # GitHub 계정으로 로그인
    supabase link --project-ref <YOUR_SUPABASE_PROJECT_ID> # 실제 Supabase 프로젝트 ID로 연결
    supabase start # 로컬 Supabase 서버 시작
    ```
    > **참고**: `supabase start` 시 출력되는 `API URL`과 `anon key`는 `lib/main.dart` 파일에 이미 설정되어 있습니다.

3.  **데이터베이스 마이그레이션 적용**: 
    ```bash
    supabase db reset # todos 테이블 및 RLS 정책 적용
    ```

4.  **Flutter 의존성 설치**: 
    ```bash
    flutter pub get
    ```

### 3. 앱 실행

```bash
flutter run
```

앱이 실행되면 로그인 화면이 나타납니다. 새로운 계정을 생성하거나 기존 계정으로 로그인하여 할 일 관리 기능을 사용해 보세요.

## 🤝 기여

이 프로젝트에 기여하고 싶으시다면 언제든지 Pull Request를 보내주세요.

## 📄 라이선스

이 프로젝트는 MIT 라이선스에 따라 배포됩니다.