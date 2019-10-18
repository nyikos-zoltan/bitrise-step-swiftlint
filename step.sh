#!/bin/bash
set -ex

if [ -z "${linting_path}" ] ; then
  echo " [!] Missing required input: linting_path"

  exit 1
fi

FLAGS=''

if [ "${strict}" = "yes" ] ; then
  FLAGS=$FLAGS' --strict'
fi

if [ -s "${lint_config_file}" ] ; then
  FLAGS=$FLAGS' --config '"${lint_config_file}"  
fi

cd "${linting_path}"

test_run_dir="$BITRISE_TEST_RESULT_DIR/swiftlint"
mkdir "$test_run_dir"

swiftlint lint --reporter checkstyle --quiet > "$test_run_dir/checkstyle.xml"
echo '{"test-name":"swiftlint"}' >> "$test_run_dir/test-info.json"
