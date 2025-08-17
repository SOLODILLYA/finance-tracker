@echo off
setlocal enabledelayedexpansion

echo 🔍 Running backend checks...
if exist backend (
  pushd backend
  call gradlew.bat -q spotlessApply test
  if errorlevel 1 exit /b 1
  popd
)

echo 🔍 Running frontend lint...
if exist frontend (
  pushd frontend
  call npm.cmd run -s lint
  if errorlevel 1 exit /b 1
  popd
)

echo ✅ All checks passed
