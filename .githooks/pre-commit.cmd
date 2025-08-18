@echo off
setlocal enabledelayedexpansion

echo 🔧 Formatting backend (Spotless)…
if exist backend (
  pushd backend
  call gradlew.bat -q spotlessApply
  if errorlevel 1 exit /b 1
  popd
)

echo 🔧 Formatting + linting frontend (Prettier + ESLint)…
if exist frontend (
  pushd frontend
  call npm.cmd run -s format
  if errorlevel 1 exit /b 1
  call npm.cmd run -s lint:fix
  if errorlevel 1 exit /b 1
  popd
)

echo ✅ Pre-commit: formatters completed

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
