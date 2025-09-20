#!/bin/sh
# ===== Pre-Push Hook =====
# Runs Flutter checks + branch name validation before allowing push

echo "🚀 Running pre-push checks..."

# 0. Validate branch name
echo "🔍 Validating branch name..."
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
echo "Branch: $BRANCH_NAME"

BRANCH_REGEX="^(bugfix|hotfix|release|feature)\/ECOM-[0-9]+\/[a-zA-Z0-9\-]+$"

if echo "$BRANCH_NAME" | grep -Eq "$BRANCH_REGEX"; then
  echo "✅ Branch name is valid."
else
  echo "❌ Invalid branch name!"
  echo "✅ Allowed format: <prefix>/ECOM-<ticketNumber>-<task-name>"
  echo "Examples:"
  echo "   feature/ECOM-27-Initialize-Project"
  echo "   bugfix/ECOM-102-Fix-Login"
  exit 1
fi

# 1. Get packages
echo "📦 Running flutter pub get..."
flutter pub get
if [ $? -ne 0 ]; then
  echo "❌ flutter pub get failed."
  exit 1
fi

# 2. Run code generation
echo "⚙️ Running code generation..."
flutter pub run build_runner build --delete-conflicting-outputs
if [ $? -ne 0 ]; then
  echo "❌ Code generation failed."
  exit 1
fi

# 3. Run intl generation
echo "🌍 Running intl generation..."
flutter pub run intl_utils:generate
if [ $? -ne 0 ]; then
  echo "❌ Intl generation failed."
  exit 1
fi

# 4. Run analyzer
echo "🔍 Running flutter analyze..."
flutter analyze
if [ $? -ne 0 ]; then
  echo "❌ Lint issues found. Fix them before pushing."
  exit 1
fi

# 5. Run unit tests
echo "🧪 Running flutter tests..."
flutter test --coverage
if [ $? -ne 0 ]; then
  echo "❌ Tests failed. Fix them before pushing."
  exit 1
fi

echo "✅ All checks passed. Proceeding with push..."
exit 0
